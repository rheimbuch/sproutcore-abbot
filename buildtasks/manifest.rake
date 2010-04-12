# ===========================================================================
# SC::Manifest Buildtasks
# copyright 2008, Sprout Systems, Inc. and Apple Inc. all rights reserved
# ===========================================================================

# Tasks invoked while building Manifest objects.  You can override these 
# tasks in your buildfiles.
namespace :manifest do
  
  desc "Invoked just before a manifest object is built to setup standard properties"
  task :prepare do
    require 'tempfile'

    # make sure a language was set
    MANIFEST.language ||= :en
    
    # build_root is target.build_root + language + build_number
    MANIFEST.build_root = File.join(TARGET.build_root, 
      MANIFEST.language.to_s, TARGET.build_number.to_s)
      
    # staging_root is target.staging_root + language + build_number
    MANIFEST.staging_root = File.join(TARGET.staging_root, 
      MANIFEST.language.to_s, TARGET.build_number.to_s)
#      MANIFEST.language.to_s, 'current')
      
    # cache_root is target.cache_root + language + build_number
    MANIFEST.cache_root = File.join(TARGET.cache_root, 
      MANIFEST.language.to_s, TARGET.build_number.to_s)
#      MANIFEST.language.to_s, 'current')
      
    # url_root
    MANIFEST.url_root = 
      [TARGET.url_root, MANIFEST.language, TARGET.build_number].join('/')
      
    # index_root
    MANIFEST.index_root = 
      [TARGET.index_root, MANIFEST.language, TARGET.build_number].join('/')
      
    # source_root
    MANIFEST.source_root = TARGET.source_root
  end

  desc "Actually builds a manifest.  This will catalog all entries and then filter them"
  task :build => %w(catalog hide_buildfiles localize prepare_build_tasks:all)
  
  desc "first step in building a manifest, this adds a simple copy file entry for every file in the source"
  task :catalog do |t|
    source_root = TARGET.source_root
    Dir.glob(File.join(source_root, '**', '*')).each do |path|
      next if !File.exist?(path) || File.directory?(path)
      next if TARGET.target_directory?(path)
      
      # cut source root out to make filename.  make sure path separators are /
      filename = path.sub /^#{Regexp.escape source_root}\//, ''
      filename = filename.split(::File::SEPARATOR).join('/')
      MANIFEST.add_entry filename, :original => true # entry:prepare will fill in the rest
    end
  end
  
  desc "hides structural files that do not belong in build include Buildfiles and debug or fixtures if turned off"
  task :hide_buildfiles => :catalog do
    # these directories are to be excluded unless CONFIG.load_"dirname" = true
    dirnames = %w(debug tests fixtures protocols).reject do |k| 
      CONFIG["load_#{k}"]
    end

    # loop through entries and hide those that do not below...
    MANIFEST.entries.each do |entry|

      # if in /dirname or /foo.lproj/dirname -- hide it!
      dirnames.each do |dirname|
        if entry.filename =~ /^(([^\/]+)\.lproj\/)?#{dirname}\/.+$/
          entry.hide!
          next
        end
      end
      
      # otherwise, allow if inside lproj
      next if entry.localized? || entry.filename =~ /^.+\.lproj\/.+$/
      
      # allow if in tests, fixtures or debug as well...
      next if entry.filename =~ /^(resources|tests|fixtures|debug)\/.+$/
      
      # or skip if ext not js
      entry.hide! if entry.ext != 'js'
    end
  end
  
  desc "localizes files. reject any files from other languages"
  task :localize => [:catalog, :hide_buildfiles] do
    seen = {} # already seen entries...
    preferred_language = TARGET.config.preferred_language || :en
    
    MANIFEST.entries.each do |entry|
      
      # Is a localized resource!
      if entry.filename =~ /^([^\/]+)\.lproj\/(.+)$/
        entry.language = (SC::Target::LONG_LANGUAGE_MAP[$1.to_s.downcase.to_sym]) || $1.to_sym
        entry.localized = true

        # remove .lproj dir from build paths as well..
        lang_dir = "#{$1}.lproj/"
        sub_str = (entry.ext == 'js') ? 'lproj/' : ''
        entry.filename   = entry.filename.sub(lang_dir, sub_str)
        entry.build_path = entry.build_path.sub(lang_dir, sub_str)
        entry.url        = entry.url.sub(lang_dir, sub_str)
              
        # if this is part of the current language, always include...
        # hide any preferred_language entry...
        if entry.language == MANIFEST.language
          if seen[entry.filename]
            seen[entry.filename].hide! 
          else
            seen[entry.filename] = entry
          end
          
        # if this is a preferred_language, hide unless we've seen one
        elsif entry.language == preferred_language
          if seen[entry.filename]
            entry.hide!
          else
            seen[entry.filename] = entry
          end
        
        # Otherwise, hide it...
        else
          entry.hide!
        end
         
      # Not a localized resource
      else
        entry.language = MANIFEST.language
        entry.localized = false
      end
    end
  end

  namespace :prepare_build_tasks do
    
    desc "main entrypoint for preparing all build tasks.  This should invoke all needed tasks"
    task :all => %w(css javascript sass combine minify html strings tests packed) 

    desc "executes prerequisites needed before one of the subtasks can be invoked.  All subtasks that have this as a prereq"
    task :setup => %w(manifest:catalog manifest:hide_buildfiles manifest:localize)
    
    desc "create builder tasks for all unit tests based on file extension."
    task :tests => :setup do
      
      # Generate test entries
      test_entries = []
      entries_by_dirname = {} # for building composites...
      MANIFEST.entries.each do |entry|
        next unless entry.filename =~ /^tests\//

        # if this is a js file, add js transform first to handle sc_static()
        # etc.
        if entry.ext == 'js'
          entry = MANIFEST.add_transform entry,
            :build_task => 'build:javascript',
            :module_name   => entry.filename.ext,
            :use_modules => CONFIG.use_modules,
            :use_loader  => CONFIG.use_loader,
            :factory_format => :function
          entry.discover_build_directives!(true)
        end
        
        # Add transform to build into test.
        test_entries << MANIFEST.add_transform(entry, 
          :build_task => "build:test",
          :entry_type => :test,
          :ext        => :html)
          
        # Strip off dirnames, saving each by dirname...
        dirname = entry.filename
        while (dirname = dirname.sub(/\/?[^\/]+$/,'')).size > 0
          (entries_by_dirname[dirname] ||= []) << entry
        end
      end
      
      # Generate composite entries for each directory...
      entries_by_dirname.each do |dirname, entries|
        filename = "#{dirname}.html"
        MANIFEST.add_composite filename,
          :build_task     => "build:test",
          :entry_type     => :test,
          :ext            => :html,
          :source_entries => entries,
          :hide_entries   => false
      end
      
      # Add summary entry
      if CONFIG.load_tests
        MANIFEST.add_entry 'tests/-index.json',
          :composite      => true, 
          :source_entries => test_entries,
          :build_task     => 'build:test_index',
          :entry_type     => :resource
      end
    end
    task :javascript => :tests # IMPORTANT! to avoid JS including unit tests.
    task :html       => :tests # IMPORTANT! to avoid HTML including tests

    desc "scans for javascript files, annotates them and prepares combined entries for each output target" 
    task :javascript => :setup do
      # select all original entries with with ext of css
      entries = MANIFEST.entries.select do |e| 
        e.original? && e.ext == 'js'
      end

      libs = Array(CONFIG.module_lib)

      # add transform & tag with build directives.
      entries.each do |entry|
        
        # if module_lib is defined, then only include JavaScript from 
        # those directories (or those in an lproj)
        module_name = entry.filename.ext
        if libs.size>0 && !(module_name =~ /^__(postamble|preamble)__$/)
          found_lib = libs.find do |x| 
            reg = /^#{Regexp.escape(x)}\//
            lproj_reg = /^lproj\/#{Regexp.escape(x)}\//
          
            if module_name =~ reg
              module_name = module_name.sub(reg, '')
              true
            
            elsif module_name =~ lproj_reg
              module_name = module_name.sub(lproj_reg, '')
              true
            else
              
              false
            end
          end

          next unless found_lib
        end
        
        entry = MANIFEST.add_transform entry,
          :lazy_instantiation => CONFIG.lazy_instantiation,
          :notify_onload => CONFIG.use_loader,
          :filename      => ['source', entry.filename].join('/'),
          :module_name   => module_name,
          :use_modules   => CONFIG.use_modules,
          :use_loader    => CONFIG.use_loader,
          :factory_format => CONFIG.factory_format,
          :build_path    => File.join(MANIFEST.build_root, 'source', entry.filename),
          :url => [MANIFEST.url_root, 'source', entry.filename].join("/"),
          :build_task => 'build:javascript',
          :resource   => 'javascript',
          :entry_type => :javascript
        entry.discover_build_directives!
      end
      
    end

    desc "scans for css files, creates a transform and annotates them"
    task :css => :setup do
      
      # select all original entries with with ext of css
      entries = MANIFEST.entries.select do |e| 
        e.original? && e.ext == 'css'
      end

      # add transform & tag with build directives.
      entries.each do |entry|
        entry = MANIFEST.add_transform entry,
          :filename   => ['source', entry.filename].join('/'),
          :build_path => File.join(MANIFEST.build_root, 'source', entry.filename),
          :url => [MANIFEST.url_root, 'source', entry.filename].join("/"),
          :build_task => 'build:css',
          :resource   => 'stylesheet',
          :entry_type => :css
        entry.discover_build_directives!
      end
    end
    
    desc "generates combined entries for javascript and css"
    task :combine => %w(setup css javascript sass) do

      # sort entries...
      css_entries = {}
      javascript_entries = {}
      final_css_entries = {}
      MANIFEST.entries.each do |entry|

        # we can only combine entries with a resource property.
        next if entry.resource.nil?

        # normalize entry names.  remove default extension
        full_name = entry.resource.to_s
        base_name = full_name.ext
        
        # look for CSS or JS type entries
        case entry.entry_type
        when :css
          full_name = base_name if full_name == base_name.ext('css')
          (css_entries[full_name] ||= []) << entry
        when :javascript
          full_name = base_name if full_name == base_name.ext('js')
          (javascript_entries[full_name] ||= []) << entry
        end
      end

      # build combined CSS entry
      css_entries.each do |resource_name, entries|
        
        if (resource_name == resource_name.ext)
          entry_name = resource_name.ext('css')
        else
          entry_name = resource_name
        end
        
        entry = MANIFEST.add_composite entry_name,
          :build_task      => 'build:combine',
          :source_entries  => entries,
          :hide_entries    => CONFIG.combine_stylesheets,
          :ordered_entries => SC::Helpers::EntrySorter.sort(entries),
          :entry_type      => :css,
          :combined        => true

      end
      
      # if NO js is defined forthe default but the loader is in use, we
      # need to generate the bundle_info.js and javascript.js anyway
      if javascript_entries['javascript'].nil? && CONFIG.use_loader
        javascript_entries['javascript'] = []
      end
      
      # build combined JS entry
      javascript_entries.each do |resource_name, entries|

        if (resource_name == resource_name.ext)
          entry_name = resource_name.ext('js')
        else
          entry_name = resource_name
        end
        
        # sort entries
        pf = (entry_name == 'javascript.js') ? %w(source/lproj/strings.js source/core.js source/utils.js) : []

        # if we're using modules, then add a generated index module if needed
        has_index = !!entries.find { |e| e.module_name == 'index' }
        if CONFIG.use_modules && !has_index
          package_exports = MANIFEST.add_entry 'package_exports.js',
            :build_task => 'build:package_exports',
            :resource   => resource_name,
            :entry_type => :javascript,
            :source_entries  => entries.dup,
            :module_name     => 'index',
            :composite       => true

          entries << package_exports
        end

        # Add a package_info to register with the loader, unless the loader
        # is disabled.  Note that this must come AFTER package_exports is 
        # added to ensure that the exports are generated also.
        package_info = nil
        if CONFIG.use_loader
          package_info = MANIFEST.add_entry 'package_info.js',
            :build_task      => 'build:package_info',
            :resource        => resource_name,
            :entry_type      => :javascript,
            :source_entries  => entries.dup,
            :composite       => true,
            :package_info    => true # used for timestamp building
            
          entries << package_info
        end
          
        ordered_entries = SC::Helpers::EntrySorter.sort(entries, pf)
        
        MANIFEST.add_composite entry_name,
          :build_task      => 'build:combine',
          :source_entries  => entries,
          :top_level_lazy_instantiation => CONFIG.lazy_instantiation, 
          :hide_entries    => CONFIG.combine_javascript,
          :ordered_entries => ordered_entries,
          :entry_type      => :javascript,
          :combined        => true,
          :notify_onload   => CONFIG.use_loader,
          :use_loader      => CONFIG.use_loader,
          :use_modules     => false  # combined never uses a module
        
        # Use final list for package_info to make sure we get the package_info
        # itself.  
        if package_info
          if CONFIG.combine_javascript
            package_info.ordered_entries = [composite_entry]
          else
            package_info.ordered_entries = ordered_entries.dup
          end
        end
        
      end
      
    end

    desc "adds a packed entry including javascript.js from required targets"
    task :packed => %w(setup combine) do

      # don't add packed entries for apps.
      if TARGET.target_type != :app
        # Handle JavaScript version.  get all required targets and find their
        # javascript.js.  Build packed js from that.
        targets = TARGET.expand_required_targets + [TARGET]
        entries = targets.map do |target|
          m = target.manifest_for(MANIFEST.variation).build!
        
          # need to find the version that is not minified
          entry = m.entry_for('javascript.js')
          entry = entry.source_entry while entry && entry.minified?
          entry
        end
      
        entries.compact!
        MANIFEST.add_composite 'javascript-packed.js',
          :build_task        => 'build:combine',
          :source_entries    => entries,
          :hide_entries      => false,
          :entry_type        => :javascript,
          :combined          => true,
          :ordered_entries   => entries, # orderd by load order
          :targets           => targets,
          :packed            => true
      
      end      
    end
    task :minify => :packed # IMPORTANT: don't want minified version
    
    desc "adds a packed entry including stylesheet.css from required targets"
    task :packed => %w(setup combine) do

      # don't add packed entries for apps.
      if TARGET.target_type != :app
        # Handle CSS version.  get all required targets and find their
        # stylesheet.css.  Build packed css from that.
        targets = TARGET.expand_required_targets + [TARGET]
        entries = targets.map do |target|
          m = target.manifest_for(MANIFEST.variation).build!
        
          # need to find the version that is not minified
          entry = m.entry_for('stylesheet.css')
          entry = entry.source_entry while entry && entry.minified?
          entry
        end
      
        entries.compact!
        MANIFEST.add_composite 'stylesheet-packed.css',
          :build_task        => 'build:combine',
          :source_entries    => entries,
          :hide_entries      => false,
          :entry_type        => :css,
          :combined          => true,
          :ordered_entries   => entries, # orderd by load order
          :targets           => targets,
          :packed            => true
      
      end      
    end
    task :minify => :packed # IMPORTANT: don't want minified version
    
    
    desc "create a builder task for all sass files to create css files"
    task :sass => :setup do
      MANIFEST.entries.each do |entry|
        next unless entry.ext == "sass"
        
        MANIFEST.add_transform entry,
          :filename   => ['source', entry.filename].join('/'),
          :build_path => File.join(MANIFEST.build_root, 'source', entry.filename),
          :url => [MANIFEST.url_root, 'source', entry.filename].join("/"),
          :build_task => 'build:sass',
          :entry_type => :css,
          :ext        => 'css',
          :resource   => 'stylesheet',
          :required   => []
      end
    end
    
    desc "find all html-generating files, annotate and combine them"
    task :html => :setup do
      
      # select all entries with proper extensions
      known_ext = %w(rhtml erb haml)
      entries = MANIFEST.entries.select do |e| 
        (e.entry_type == :html) || (e.entry_type.nil? && known_ext.include?(e.ext))
      end

      # tag entry with build directives and sort by resource
      entries_by_resource = {}
      entries.each do |entry|
        entry.entry_type = :html
        entry.resource = 'index'

        entry.render_task = case entry.ext
        when 'rhtml'
          'render:erubis'
        when 'erb'
          "render:erubis"
        when 'haml'
          'render:haml'
        end
        
        # items beginning with an underscore are partials.  do not build
        if entry.filename =~ /^_/
          entry.hide!
          entry.is_partial = true

        # not a partial
        else
          # use a custom scan method since discover_build_directives! is too
          # general...
          entry.scan_source(/<%\s*sc_resource\(?\s*['"](.+)['"]\s*\)?/) do |m|
            entry.resource = m[0].ext ''
          end
          (entries_by_resource[entry.resource] ||= []) << entry
        end
        
      end
      
      # even if no resource was found for the index.html, add one anyway if 
      # the target is loadable
      if TARGET.loadable? && entries_by_resource['index'].nil?
        entries_by_resource['index'] = []
      end
      
      # Now, build combined entry for each resource
      entries_by_resource.each do |resource_name, entries|
        resource_name = resource_name.ext('html')
        is_index = resource_name == 'index.html'
        
        # compute the friendly_url assuming normal install process
        friendly_url = [TARGET.index_root]
        m_language = MANIFEST.language.to_sym
        t_preferred = (TARGET.config.preferred_language || :en).to_sym
        if is_index
          friendly_url << m_language.to_s unless t_preferred == m_language
        else
          friendly_url << m_language.to_s
          friendly_url << resource_name
        end
        friendly_url = friendly_url.join('/')

        is_pref_lang = (MANIFEST.language == CONFIG.preferred_language)
        is_hidden = !TARGET.loadable? && is_index
        overwrite_current = CONFIG.overwrite_current
        
        # index.html entries get generated three times.  Once for inside the
        # build dir, once for the language and once for the entire target name
        # Note that you must generate an index.html entry for all three even
        # if you won't actually use it because other index.html entries may
        # reference it 
        (is_index ? 3 : 1).times do |rep_cnt|
          
          MANIFEST.add_composite resource_name,
            :entry_type => :html,
            :combined => true,
            :build_task => 'build:html',
            :source_entries => entries, # make independent
            :hidden     =>  is_hidden,
            :include_required_targets => TARGET.loadable? && is_index,
            :friendly_url => friendly_url,
            :is_index   => is_index
            
          # if this is the index, setup next rep
          if is_index
            resource_name = File.join('..', resource_name)
            is_hidden = true if !TARGET.loadable? || !overwrite_current
            is_hidden = true if (rep_cnt>=2) && !is_pref_lang
          end
        end
        
      end
    end
    
    desc "creates transform entries for all css and Js entries to minify them if needed"
    task :minify => %w(setup javascript css combine sass) do
      
      minify_css = CONFIG.minify_css
      minify_css = CONFIG.minify if minify_css.nil?

      minify_javascript = CONFIG.minify_javascript
      minify_javascript = CONFIG.minify if minify_javascript.nil?
      
      MANIFEST.entries.dup.each do |entry|
        case entry.entry_type
        when :css
          if minify_css
            MANIFEST.add_transform entry, 
              :build_task => 'build:minify:css',
              :entry_type => :css,
              :minified   => true,
              :packed     => entry.packed? # carry forward
          end
              
        when :javascript
          if minify_javascript 
            MANIFEST.add_transform entry, 
              :build_task => 'build:minify:javascript',
              :entry_type => :javascript,
              :minified   => true,
              :packed     => entry.packed? # carry forward
          end
        end
        
      end
      
    end

    desc "adds a loc strings entry that generates a yaml file server-side functions can use" 
    task :strings => %w(setup javascript) do
      # find the lproj/strings.js file...
      if entry = (MANIFEST.entry_for('source/lproj/strings.js') || MANIFEST.entry_for('source/lproj/strings.js', :hidden => true))
        MANIFEST.add_transform entry, 
          :filename   => 'strings.yaml',
          :build_path => File.join(MANIFEST.build_root, 'strings.yaml'),
          :staging_path => File.join(MANIFEST.staging_root, 'strings.yaml'),
          :url        => [MANIFEST.url_root, 'strings.yaml'].join('/'),
          :build_task => 'build:strings',
          :ext        => 'yaml',
          :entry_type => :strings,
          :hide_entry => false,
          :hidden     => true
      end
    end
    
    desc "..."
    task :image => :setup do
    end
    
    
  end
      
  
end
