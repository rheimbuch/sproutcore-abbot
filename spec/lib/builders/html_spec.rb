require File.join(File.dirname(__FILE__), 'spec_helper')
describe SC::Builder::Html do
  
  include SC::SpecHelpers
  include SC::BuilderSpecHelper
  
  before do
    std_before :html_test
    
    # most of these tests assume load_debug is turned off like it would be
    # in production mode
    @target.config.load_debug = false
    @target.config.theme = nil
    @target.config.timestamp_urls = false
    
    # make sure all targets have the same settings...
    @target.expand_required_targets.each do |t|
      t.config.timestamp_urls = false
    end
    
    # run std rules to run manifest.  Then verify preconditions to make sure
    # no other changes to the build system effect the ability of these tests
    # to run properly.
    @manifest.build!
    @index_entry = @manifest.entry_for('index.html')
    @bar_entry   = @manifest.entry_for('bar1.html')
  end

  after do
    std_after
  end
  
  it "VERIFY PRECONDITIONS" do
    @target.should be_loadable
    
    # target should require one other target...
    (req = @target.required_targets).size.should == 1
    req.first.target_name.should == :'/req_target_2'
    
    # the required target should itself require another target...
    (req = req.first.required_targets).size.should == 1
    req.first.target_name.should == :'/req_target_1'
    
    # Verify index entry -- should have erb_sample + rhtml_sample entries
    @index_entry.should_not be_nil
    @index_entry.should be_include_required_targets
    entry_names = @index_entry.source_entries.map { |e| e.filename }.sort
    entry_names.should == %w(erb_sample.html.erb rhtml_sample.rhtml)
    
    # Verify bar entry - should have 1 entry
    @bar_entry.should_not be_nil
    entry_names = @bar_entry.source_entries.map { |e| e.filename }.sort
    entry_names.should == %w(bar1_sample.rhtml)
  end

  describe "layout_path" do
    
    before do 
      @index_builder = SC::Builder::Html.new(@index_entry)
    end
    
    it "initially resolves layout_path using layout config for target" do
      # see the Buildfile for the fixture project to see this config.
      @index_builder.layout_path.should == File.join(@project.project_root, %w(apps html_test lib layout_template.rhtml))
    end
    
    it "changes its resolved path if you alter the layout variable" do
      # use helper method...
      @index_builder.sc_resource('index', 
        :layout => 'req_target_2:lib/alt_layout.rhtml')
      
      @index_builder.layout_path.should == File.join(@project.project_root, %w(frameworks req_target_2 lib alt_layout.rhtml))
    end
  end
      

      
  describe "render an index.html entry" do
    
    it "should render html, including any content from required targets" do
      result = SC::Builder::Html.new(@index_entry).render
      result.should =~ /erb_sample/
      result.should =~ /rhtml_sample/
      
      # verify it included the other items..
      result.should =~ /req_target_1_sample/
      result.should =~ /req_target_2_sample/
    end
      
  end
  
  describe "building non-index entries" do
    
    it "should render html, including only items from the target itself" do
      result = SC::Builder::Html.new(@bar_entry).render
      result.should =~ /bar1_sample/

      # verify it did not include other targets..
      result.should_not =~ /req_target_1_sample/
      result.should_not =~ /req_target_2_sample/
    end
    
  end
  
  describe "expand_required_targets helper" do
    
    it "returns the required targets for a typical target" do
      @builder = SC::Builder::Html.new(@index_entry)
      @target.config.load_debug = false # simulate prod environment
      @target.config.load_tests = false 

      @builder.expand_required_targets(@target).should == @target.expand_required_targets
    end
    
    it "include debug targets if load_debug is true" do
      @builder = SC::Builder::Html.new(@index_entry)
      @target.config.debug_required.should_not be_nil # precondition
      
      @target.config.load_debug = true
      @target.config.load_tests = false
      
      @builder.expand_required_targets(@target).should == @target.expand_required_targets(:debug => true)
    end
    
    it "includes theme if theme is specified and target is app" do
      @builder = SC::Builder::Html.new(@index_entry)
      @target.config.theme = :sample_theme
      
      expected = @project.target_for :sample_theme
      expected.should_not be_nil #precondition
      @builder.expand_required_targets(@target).should include(expected)
    end
      
  end
  
  # templates should expect to be able to access certain environmental 
  # variables and other commands when running.  This API is exposed as methods
  # on the HTML builder object itself.
  describe "API for templates" do
    
    before do
      # get the simplest builder...
      @builder = SC::Builder::Html.new(@bar_entry)
    end
    
    describe "Basic properties" do
      it "exposes entry = current entry" do
        @builder.entry.should == @bar_entry
      end
    
      it "exposes current target as both 'target' & 'bundle' (for backwards compatibility)" do
        @builder.bundle.should == @target
        @builder.target.should == @target
      end
    
      it "exposes current project as both 'project' & 'library' (for backwards compatibility)" do
        @builder.project.should == @project
        @builder.library.should == @project
      end
    
      it "exposes output filename as 'filename'" do
        @builder.filename.should == 'bar1.html'
      end
    
      it "exposes current language as 'language'" do
        @builder.language.should == :en
      end
      
      it "exposes bundle_name & target_name" do
        expected = @target.target_name.to_s.sub(/^\//,'')
        @builder.target_name.should == expected
        @builder.bundle_name.should == expected
      end
      
      it "exposes title - titlizes target name, respects config.title" do
        @target.config.title = nil
        @builder.title.should == 'Html Test'
        
        @target.config.title = 'TEST'
        @builder.title.should == "TEST"
      end
      
      it "exposes config" do
        @builder.config.should == @target.config
      end
      
    end
    
    # Static helper contains methods needed to generate a SproutCore app
    # such as static_url, sc_resource, etc.
    describe "StaticHelper" do
      
      it "exposes static_url() & sc_static() alias" do
        @builder.static_url('icons/image').should =~ /icons\/image.png/
        @builder.static_url('image.jpg').should =~ /image.jpg/
  
        @builder.sc_static('icons/image').should =~ /icons\/image.png/
        @builder.sc_static('image.jpg').should =~ /image.jpg/
      end
      
      it "takes a :language option for static_url to select an alternate manifest (deprecated - supported for backwards compatibility)" do
        @builder.static_url('fr.png', :language => :fr).should =~ /french-icons\/fr.png/
        
        @builder.sc_static('fr.png', :language => :fr).should =~ /french-icons\/fr.png/
      end
      
      it "respects the timestamp_url option for static_url()" do
        @target.config.timestamp_urls = false
        @builder.static_url('icons/image').should_not =~ /\?.+$/
        
        @target.config.timestamp_urls = true
        @builder.static_url('icons/image').should =~ /\?.+$/
      end
      
      it "accepts sc_resource(rsrc_name, opts).  :layout opt may be used to set layout.  otherwise this is scanned for during manifest building" do
        @builder.sc_resource('foo', :layout => 'bar')
        @builder.instance_variable_get('@layout').should == 'bar'
      end
      
      describe "exposes theme_name()" do
        
        it "returns passed default value or 'sc-theme' if no theme is configd" do
          @target.config.theme = nil # precondition
          @builder.theme_name.should == 'sc-theme'
          @builder.theme_name(:default => 'foo').should == 'foo'
        end
        
        it "returns targets theme_name config if set" do
          @target.config.theme = 'sample_theme'
          @target.config.theme_name = "foo"
          @builder.theme_name.should == 'foo'
        end
        
        it "returns theme_name set in theme target if set and not overridden in app itself" do
          @target.config.theme = 'sample_theme'
          @target.config.theme_name = nil # precondition
          
          # this value is set in the sample_theme/Buildfile
          @builder.theme_name.should == 'sample_theme_name'
        end
      end
       
      describe "exposes loc()" do
        
        it "maps passed string to local target strings.js, if present" do
          @builder.loc('local_string').should eql('LOCAL STRING')
        end
        
        it "maps passed string to required target strings.js, otherwise" do
          @builder.loc('req_string').should eql('REQ STRING')
        end
        
        it "accepts a language option to loc a different language (deprecated - included for backward compatibility)" do
          @builder.loc('local_string', :language => :fr).should eql('LOCAL STRING FR')
        end
        
      end
      
      describe "exposes stylesheets_for_client()" do
        
        # look for link tags in order...
        def expect_links(result, urls = [])
          urls = urls.dup # don't corrupt original array
          result.scan /\<link.+href\=\"([^\"]+)\"[^\<]+\/\>/ do |m|
            $1.should == urls.shift
          end
        end
  
        # look for link tags in order...
        def expect_imports(result, urls = [])
          urls = urls.dup # don't corrupt original array
          result.scan /@import\s+url\(\'(.+)\'\)/ do |m|
            $1.should == urls.shift
          end
        end
          
        it "generates a link to stylesheet.css entries for all required targets if CONFIG.combine_stylesheetss = true" do
          # figure expected urls...
          urls = %w(req_target_1 req_target_2 html_test).map do |target_name|
            t = @project.target_for(target_name)
            t.manifest_for(:language => :en).build!.entry_for('stylesheet.css').url
          end
          
          @target.config.combine_stylesheets = true 
          @target.config.load_debug = false
          @target.config.load_tests = false

          result = @builder.stylesheets_for_client
          expect_links(result, urls)
          
          # also works for @import
          result = @builder.stylesheets_for_client(:include_method => :import)
          expect_imports(result, urls)
        end
        
        it "generates a link to the ordered entries of each stylesheet.css for all required targets if CONFIG.combine_stylesheetss = false" do
          # figure expected urls...
          urls = %w(req_target_1 req_target_2 html_test).map do |target_name|
            t = @project.target_for(target_name)
            e = t.manifest_for(:language => :en).build!.entry_for('stylesheet.css')
            e.ordered_entries.map { |e| e.url }
          end
          urls.flatten!
          
          @target.config.combine_stylesheets = false 
          @target.config.load_debug = false
          @target.config.load_tests = false
          
          result = @builder.stylesheets_for_client
          expect_links(result, urls)
  
          result = @builder.stylesheets_for_client(:include_method => :import)
          expect_imports(result, urls)
        end
      
        it "adds stylehseet_libs to end of styles" do
          @target.config.stylesheet_libs = %w(foo bar)
          result = @builder.stylesheets_for_client
          result.should =~ /href=\"foo\"/
          result.should =~ /href=\"bar\"/
        end
        
        describe "timestamp_urls support" do
          
          def test_timestamps(should_have)
            result = @builder.stylesheets_for_client
            matches = 0
            result.scan(/href=\"([^\"]+)\"/) do |m|
              m=m.first # look @ match...
              matches += 1 
              if should_have
                m.should =~ /\?.+$/
              else
                m.should_not =~ /\?.+$/
              end
            end
            matches.should > 0 # should match some urls...
          end
          
          it "does NOT timestamp to all urls if timestamp_urls is false" do
            # simulate having timestamp_urls set true in the root buildfile
            @target.config.timestamp_urls = false # preconditon
            @target.config.load_debug = true
            @target.config.load_tests = false
            
            req_targets = @target.expand_required_targets(:debug => true, 
              :tests => false, :theme => true)
            req_targets.each do |t|
              t.config.timestamp_urls = false
            end
            test_timestamps false
          end
        
          it "does timestamp all urls if timestamp_urls is true" do
            # simulate having timestamp_urls set true in the root buildfile
            @target.config.timestamp_urls = true # precondition
            @target.config.load_debug = true
            @target.config.load_tests = false
            
            req_targets = @target.expand_required_targets(:debug => true, 
              :tests => false, :theme => true)
            req_targets.each do |t|
              t.config.timestamp_urls = true
            end
            test_timestamps true
          end
        end
          
        
        it "adds stylesheet for debug if CONFIG.load_debug" do
          # figure expected urls...
          t = @project.target_for(:debug)
          url = t.manifest_for(:language => :en).build!.entry_for('stylesheet.css').url
          url = /#{Regexp.escape url}/
          
          @target.config.combine_stylesheets = true 
          @target.config.load_debug = true 
          result = @builder.stylesheets_for_client
          result.should =~ url
          
          # also works for @import
          result = @builder.stylesheets_for_client(:include_method => :import)
          result.should =~ url
        end

        it "adds stylesheet for test if CONFIG.load_test" do
          # figure expected urls...
          t = @project.target_for(:qunit)
          url = t.manifest_for(:language => :en).build!.entry_for('stylesheet.css').url
          url = /#{Regexp.escape url}/
          
          @target.config.combine_stylesheets = true 
          @target.config.load_tests = true 
          result = @builder.stylesheets_for_client
          result.should =~ url
          
          # also works for @import
          result = @builder.stylesheets_for_client(:include_method => :import)
          result.should =~ url
        end
          
      end
      
      describe "exposes javascript_for_client()" do
        
        # look for link tags in order...
        def expect_scripts(result, urls = [])
          urls = urls.dup # don't corrupt original array
          result.scan /\<script.+src\=\"([^\"]+)\"[^\<]+\>\s*\<\/script\>/ do |m|
            $1.should == urls.shift
          end
        end
  
        it "generates a link to javascript.js entries for all required targets if CONFIG.combine_javascript = true" do
          # figure expected urls...
          urls = %w(req_target_1 req_target_2 html_test).map do |target_name|
            t = @project.target_for(target_name)
            t.manifest_for(:language => :en).build!.entry_for('javascript.js').url
          end
          
          @target.config.combine_javascript = true 
          result = @builder.javascripts_for_client
          expect_scripts(result, urls)
        end
        
        it "generates a link to the ordered entries of each javascript.js for all required targets if CONFIG.combine_javascript = false" do
          # figure expected urls...
          urls = %w(req_target_1 req_target_2 html_test).map do |target_name|
            t = @project.target_for(target_name)
            e = t.manifest_for(:language => :en).build!.entry_for('javascript.js', :combined => true)
            e.ordered_entries.map { |e| e.url }
          end
          urls.flatten!
          
          @target.config.combine_javascript = false 
          result = @builder.javascripts_for_client
          expect_scripts(result, urls)
        end
        
        it "adds preferredLanguage definition" do
          result = @builder.javascripts_for_client
          result.should =~ /String.preferredLanguage = "en"/
        end
        
        it "adds javascript_libs to end of scripts" do
          @target.config.javascript_libs = %w(foo bar)
          result = @builder.javascripts_for_client
          result.should =~ /src=\"foo\"/
          result.should =~ /src=\"bar\"/
        end

        it "adds link to debug JS if CONFIG.load_debug = true" do
          # figure expected urls...
          t = @project.target_for(:debug)
          t.config.combine_javascript = true
          url = t.manifest_for(:language => :en).build!.entry_for('javascript.js').url
          url = /#{Regexp.escape url}/
          
          @target.config.combine_javascript = true 
          
          @target.config.load_debug = true
          result = @builder.javascripts_for_client
          result.should =~ url
        end

        it "does NOT add link to test, even if load_test is true" do
          # figure expected urls...
          t = @project.target_for(:qunit)
          url = t.manifest_for(:language => :en).build!.entry_for('javascript.js').url
          url = /#{Regexp.escape url}/
          
          @target.config.combine_javascript = true 
          @target.config.load_test = true
          result = @builder.javascripts_for_client
          result.should_not =~ url
        end

        describe "timestamp_urls support" do
          
          def test_timestamps(should_have)
            result = @builder.javascripts_for_client
            matches = 0
            result.scan(/src=\"([^\"]+)\"/) do |m|
              matches += 1 
              m = m.first # look @ match
              if should_have
                m.should =~ /\?.+$/
              else
                m.should_not =~ /\?.+$/
              end
            end
            matches.should > 0 # should match some urls...
          end
          
          it "does NOT timestamp to all urls if timestamp_urls is false" do
            @target.config.timestamp_urls = false # preconditon
            @target.config.load_debug = true
            @target.config.load_tests = false

            req_targets = @target.expand_required_targets(:debug => true, 
              :test => false, :theme => true)
              
            req_targets.each do |t|
              t.config.timestamp_urls = false
            end
            test_timestamps false
          end
        
          it "does timestamp all urls if timestamp_urls is true" do
            @target.config.timestamp_urls = true # precondition
            @target.config.load_debug = true
            @target.config.load_tests = false

            req_targets = @target.expand_required_targets(:debug => true, 
              :test => false, :theme => true)
              
            req_targets.each do |t|
              t.config.timestamp_urls = true
            end
            test_timestamps true
          end
        end
      
      end
      
    end
    
    describe "TagHelpers" do
      it "exposes tag(br) => <br />" do
        @builder.tag(:br).should =~ /<br ?\/>/ # don't care if space is added
      end
      
      it "exposes content_tag(h1, 'hello_world')" do
        @builder.content_tag(:h1, 'hello world').should == '<h1>hello world</h1>'
      end
      
      it "exposes cdata_section('hello world')" do
        @builder.cdata_section('hello world').should == "<![CDATA[hello world]]>"
      end
      
      it "exposes escape_once('1 & 2')" do
        @builder.escape_once("1 > 2 &amp; 3").should == "1 &gt; 2 &amp; 3"
      end
    end
    
    describe "TextHelper" do
  
      it "exposes highlight(str, highlight_str, repl_Str)" do
        @builder.highlight('You searched for: rails', 'rails').should == 'You searched for: <strong class="highlight">rails</strong>'
      end
      
      it "exposes pluralize(cnt, 'foo')" do
        @builder.pluralize(1, 'person').should == '1 person'
        @builder.pluralize(2, 'person').should == '2 people'
        @builder.pluralize(3, 'person', 'users').should == '3 users'
      end
    
      begin
        gem 'RedCloth'
        require 'redcloth'
        
        it "exposes textilize('foo')" do
          @builder.textilize("h1. foo").should == "<h1>foo</h1>"
        end
      rescue LoadError
        puts "WARNING: Not testing textilize() because RedCloth is not installed"
      end
  
      begin
        gem 'bluecloth'
        require 'bluecloth'
        
        it "exposes markdown('foo')" do
          @builder.markdown("# foo").should == "<h1>foo</h1>"
        end
      rescue LoadError
        puts "WARNING: Not testing markdown() because BlueCloth is not installed"
      end
        
      ## TODO: Test remaining methods from TextHelper are added.
    end
    
    describe "DomIdHelper" do
      
      it "generates a unique ID each time it is called" do
        seen_ids = []
        10.times do
          next_id = @builder.dom_id!
          seen_ids.should_not include(seen_ids)
          seen_ids << next_id
        end
      end
    end
    
    describe "CaptureHelper" do
      
      it "returns the results of the passed block - optionally passing through renderer (not tested)" do
        result = @builder.capture { 'result' }
        result.should == 'result'
      end
      
      it "adds the result of the passed block to the builder as an instance variable called @content_for_foo" do
        result = @builder.content_for(:foo) { "result" }
        @builder.instance_variable_get('@content_for_foo').should == 'result'
        result.should == ''
      end
    end
        
  end
  
  
end