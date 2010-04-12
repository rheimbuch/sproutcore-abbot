# ===========================================================================
# Project:   Abbot - SproutCore Build Tools
# Copyright: ©2009 Apple Inc.
#            portions copyright @2006-2009 Sprout Systems, Inc.
#            and contributors
# ===========================================================================

require File.expand_path(File.join(File.dirname(__FILE__), 'base'))
require 'fileutils'

module SC

  # This build is used to process a single javascript file.  It will
  # substitute any calls to sc_super and sc_static() (or static_url()).  It 
  # does NOT product a combined JavaScript for production.  See the 
  # Builder::CombinedJavaScript for more.
  class Builder::JavaScript < Builder::Base
    
    def build(dst_path)
      lines = []
      target_name = entry.target.target_name.to_s.sub(/^\//,'')
      
      if entry.lazy_instantiation && entry.notify_onload
        lines << ";
if ((typeof SC !== 'undefined') && SC && !SC.LAZY_INSTANTIATION) {
  SC.LAZY_INSTANTIATION = {};
}
if(!SC.LAZY_INSTANTIATION['#{target_name}']) {
  SC.LAZY_INSTANTIATION['#{target_name}'] = [];
}
SC.LAZY_INSTANTIATION['#{target_name}'].push(
  (
    function() {
"
      end

      lines << readlines(entry.source_path).map { |l| rewrite_inline_code(l) }

      # Wrap in a module if enabled
      if entry.use_modules
        lines.unshift entry.module_preamble
        lines.unshift "sc_loader.module('#{entry.manifest.bundle_name}', '#{entry.module_name}', function(require, exports, module) {"

        lines << entry.module_postamble
        lines << "\n});\n"
      end
      
      # Try to load dependencies if we're not combining javascript.
      if entry.notify_onload && !entry.target.config.combine_javascript
        lines << "; sc_loader.script('#{entry.cacheable_url}');"
      end

      if entry.lazy_instantiation && entry.notify_onload
        lines << "
    }
  )
);
"
      end
      
      writelines dst_path, lines
    end

    # Returns true if the current entry is a localized strings file.  These
    # files receive some specialized processing to allow for server-side only
    # strings.  -- You can name a string key beginning with "@@" and it will 
    # be removed.
    def localized_strings?
      @lstrings ||= entry.localized? && entry.filename =~ /strings.js$/
    end

    # Rewrites inline content for a single line
    def rewrite_inline_code(line)

      # Fors strings file, remove server-side keys (i.e '@@foo' = 'bar')
      if localized_strings?
        line = line.gsub(/["']@@.*["']\s*?:\s*?["'].*["']\s*,\s*$/,'')

      # Otherwise process sc_super 
      else
        return unless (line.valid_encoding?)
        if line.match(/sc_super\(\s*\)/)
          line = line.gsub(/sc_super\(\s*\)/, 'arguments.callee.base.apply(this,arguments)')
        elsif line.match(/sc_super\(.+?\)/)
          SC.logger.warn "\nWARNING: Calling sc_super() with arguments is DEPRECATED. Please use sc_super() only.\n\n"
          line = line.gsub(/sc_super\((.+?)\)/, 'arguments.callee.base.apply(this, \1)')
        end
      end

      # and finally rewrite static_url
      return replace_static_url(line)
    end
    
  end
  
end
