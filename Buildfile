# ===========================================================================
# Project:   Abbot - SproutCore Build Tools
# Copyright: ©2009 Apple Inc.
#            portions copyright @2006-2009 Sprout Systems, Inc.
#            and contributors
# ===========================================================================

# Default buildfile loaded by all projects.  Any options you put into your 
# project buildfile will override these defaults.

# Import all build tasks
import *Dir.glob(File.join(File.dirname(current_path), 'buildtasks', '**', '*.rake'))

mode :all do
  config :all,

    # REQUIRED CONFIGS 
    # You will not usually need to override these configs, but the code 
    # assumes they will be present, so you must support them.
    :build_prefix   => "tmp/#{SC.env.build_mode}/build",
    :staging_prefix => "tmp/#{SC.env.build_mode}/staging",
    :cache_prefix   => "tmp/#{SC.env.build_mode}/cache",
    :url_prefix     => 'static',
  
    # Defines the directories that may contain targets, and maps them to a 
    # target type.  When a project tries to find all of the targets in a 
    # project, it will use this map to find them.
    :target_types => { 
      :apps       => :app, 
      :clients    => :app, 
      :pages      => :app, # used for static pages with your site
      :frameworks => :framework,
      :themes     => :theme,
      :bundles    => :framework,
      :packages   => :framework
    },
  
    # Allows the target to have other targets nested inside of it.  Override 
    # this in your target Buildfile to disable nesting.
    :allow_nested_targets => true,

    # The default preferred language.  Assets will be pulled from this 
    # language unless otherwise specified.
    :preferred_language => :en,
    
    # Do not include fixtures in built project.
    :load_fixtures => false,
    
    # Do not include debug directory in built project
    :load_debug => false,
    
    # Do not load protocols in production mode
    :load_protocols => false,
    
    # Do not build tests.
    :load_tests => false,
    
    # Generate a combined javascript and stylesheet
    :combine_javascript => true,
    :combine_stylesheets => true,

    # by default all targets autobuild
    :autobuild => true,
    
    # by default minify javacript and stylesheets
    :minify => true,
    :minify_css => true,
    
    # use the default layout defined in SproutCore
    :layout => 'sproutcore:lib/index.rhtml',
    :test_layout => 'sproutcore:lib/index.rhtml',
    
    # name a framework to use as the theme.  will be included in required
    # frameworks automatically if found.
    :theme  => 'sproutcore/standard_theme',
    
    # use default bootstrap framework
    :bootstrap_inline   => 'sproutcore/bootstrap:javascript',
    :bootstrap_env      => true, # include an ENV global variable

    # In design mode, load the designer
    :design_required => ['sproutcore/designer'],
    
    :use_packed => true,

		# If set to true, the specified framework, if loaded via the SC.loadBundle
		# API, will be set up to be lazily instantiated when loaded.
		:lazy_instantiation => false,
    
    # indicates that you want to include bundle loading code.  this is almost
    # always a setting you want to leave enabled.  The value of this property
    # should be the name of the global loader object.  It should also be the
    # name of the framework that contains the loader.
    :use_loader => true,

    # Actives module loading.  Currently off by default.  If you enable the 
    # loader, you may also choose the name of the loader that will be used.
    # defaults to "tiki".
    :use_modules    => false,
    :module_loader  => 'tiki',
    :factory_format => :text,  # or function
    
    # if set to true then the index.html will build into the global language
    # and target directory.  This can interfere with deploying multiple builds
    # at one but it is more convenient.
    :overwrite_current => false,
    
    # causes the default index.html file to add an overflow:hidden statement
    # to the body tag.  This is usually preferred since it makes drag and drop
    # look nicer
    :hide_body_overflow => true
    
end


mode :debug do
  config :all,
  
    # in debug mode, load fixtures, debug, tests, and protocols
    :load_fixtures  => true,
    :load_debug     => true,
    :load_tests     => true,
    :load_protocols => true,
    
    # Do not combine javascript and stylesheet
    :combine_javascript => false,
    :combine_stylesheets => true,
    
    :minify_javascript => false,
    :minify_css => false,
    
    # debug settings for sc-server
    :serve_exceptions => true,
    :reload_project   => true,

    # In debug mode, we want to simply compute the build number each time
    # to ensure the latest version is always loaded.
    :build_number     => :current,

    # Instructs the URL builders to include a timestamp token at the end of 
    # urls.  This option is only useful in development mode since browsers
    # will respect the timestamp token as a way to unique the url.  This
    # should not be used in production as some proxies on the internet do
    # not respect tokens.
    :timestamp_urls  =>  true,
    
    # Do not pack javascripts in development mode, we want each file to 
    # load independently.
    :use_packed => false
end


