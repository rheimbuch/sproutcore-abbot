# ===========================================================================
# Project:   Abbot - SproutCore Build Tools
# Copyright: ©2009 Apple Inc.
#            portions copyright @2006-2009 Sprout Systems, Inc.
#            and contributors
# ===========================================================================

module SC
  
  class Tools
    
    desc "server", "Starts the development server"
    method_options  :daemonize  => false,
                    :pid        => :string,
                    :port       => :string,
                    :host       => :string,
                    :irb        => false,
                    :filesystem => true
    def server
      prepare_mode!('debug') # set mode again, using debug as default
      
      SC.env.build_prefix   = options.buildroot if options.buildroot
      SC.env.staging_prefix = options.stageroot if options.stageroot
      
      # get project and start service.
      project = requires_project!
      
      # start shell if passed
      if options.irb
        require 'irb'
        require 'irb/completion'
        if File.exists? ".irbrc"
          ENV['IRBRC'] = ".irbrc"
        end
        
        SC.project = project
        SC.logger << "SproutCore v#{SC::VERSION} Interactive Shell\n"
        SC.logger << "SC.project = #{project.project_root}\n"
        ARGV.clear # do not pass onto IRB
        IRB.start
      else
        SC.logger << "SproutCore v#{SC::VERSION} Development Server\n"
        
        # Always clear tmp to keep file sizes to a minimum
        tmp_path = project.project_root / 'tmp'
        FileUtils.rm_rf(tmp_path) if File.exist?(tmp_path)
      
        SC::Rack::Service.start(options.merge(:project => project))
      end
    end
    
  end
end
