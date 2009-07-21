# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sproutcore}
  s.version = "1.0.20090721155704"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sprout Systems, Inc.  Apple, Inc. and contributors"]
  s.date = %q{2009-07-21}
  s.description = %q{sproutcore - abbot
    by Charles Jolley and contributors
    http://www.sproutcore.com
    http://github.com/sproutit/sproutcore-abbot

== DESCRIPTION:

SproutCore is a platform for building native look-and-feel applications on 
the web.  This Ruby library includes a copy of the SproutCore JavaScript 
framework as well as a Ruby-based build system called Abbot.

Abbot is a build system for creating static web content.  You can supply Abbot with a collection of JavaScript, HTML, CSS and image files and it will 
combine the files into a bundle that are optimized for efficient, cached 
deliver directly from your server or using a CDN.

Some of the benefits of using Abbot versus assembling your own content 
include:

 * Easy maintenance.  Organize your source content in a way that is useful for 
   you without impacting performance on loaded apps.
 
 * Automatically versioned URLs. Serve content with long expiration dates
   while Abbot handles the cache invalidation for you.
 
 * Dependency management.  Divide your code into frameworks; load 3rd party
   libraries.  Abbot will make sure everything loads in the correct order.
   
 * Packing.  Combines JavaScript and CSS into single files to minimize the
   number of resources you download for each page.
  
Although Abbot is intended primarily for building Web applications that 
use the SproutCore JavaScript framework, you can also use it to efficiently build any kind of static web content, even if SproutCore is not involved.

Abbot can be used both directly from the command line or as a ruby library. 
  
== USING ABBOT WITH SPROUTCORE:

This gem includes both the Abbot build tools and a copy of the SproutCore
JavaScript framework.  You can use built-in commands to create, develop, 
build, and deploy SproutCore-based applications.

== KNOWN LIMITATIONS:

* Currently does not support sites using relative-links.  You must specify
  the absolute path you expect built targets to be hosted as.  

== SYNOPSIS:

To create a new project:

  sc-init my_app
  
To test said project:

  cd my_app
  sc-server
  open http://localhost:4020/my_app (in web browser)
  
Write code, refresh, debug.  Once you are ready to deploy, build your static
output using:

  cd my_app
  sc-build my_app -rc
  
Copy the resulting files found in my_app/tmp/build to your server and you are
deployed!

== REQUIREMENTS:

* Ruby 1.8.6 or later.  Ruby 1.9 is currently untested
* extlib 0.9.9 or later
* rack 0.9.1 or later
* erubis 2.6.2 or later
* json_pure 1.1.0 or later

== INSTALL:

sudo gem install sproutcore

== LICENSE:

Copyright (c) 2009 Apple, Inc.  
Portions copyright (c) 2006-2009 Sprout Systems, Inc. and contributors

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}
  s.email = %q{contact@sproutcore.com}
  s.executables = ["sc-build", "sc-build-number", "sc-gen", "sc-init", "sc-manifest", "sc-server", "sproutcore"]
  s.extra_rdoc_files = [
    "History.txt",
     "README.txt",
     "README.txt"
  ]
  s.files = [
    "Buildfile",
     "History.txt",
     "README.txt",
     "Rakefile",
     "Todo.txt",
     "VERSION",
     "bin/sc-build",
     "bin/sc-build-number",
     "bin/sc-gen",
     "bin/sc-init",
     "bin/sc-manifest",
     "bin/sc-server",
     "bin/sproutcore",
     "buildtasks/build.rake",
     "buildtasks/entry.rake",
     "buildtasks/manifest.rake",
     "buildtasks/render.rake",
     "buildtasks/target.rake",
     "gen/Buildfile",
     "gen/app/Buildfile",
     "gen/app/README",
     "gen/app/USAGE",
     "gen/controller/Buildfile",
     "gen/controller/README",
     "gen/controller/USAGE",
     "gen/framework/Buildfile",
     "gen/framework/README",
     "gen/framework/USAGE",
     "gen/language/Buildfile",
     "gen/language/README",
     "gen/language/USAGE",
     "gen/model/Buildfile",
     "gen/model/README",
     "gen/model/USAGE",
     "gen/project/Buildfile",
     "gen/project/INIT",
     "gen/project/README",
     "gen/project/USAGE",
     "gen/test/Buildfile",
     "gen/test/README",
     "gen/test/USAGE",
     "gen/theme/Buildfile",
     "gen/theme/README",
     "gen/theme/USAGE",
     "gen/view/Buildfile",
     "gen/view/README",
     "gen/view/USAGE",
     "lib/sproutcore.rb",
     "lib/sproutcore/builders/base.rb",
     "lib/sproutcore/builders/combine.rb",
     "lib/sproutcore/builders/html.rb",
     "lib/sproutcore/builders/javascript.rb",
     "lib/sproutcore/builders/minify.rb",
     "lib/sproutcore/builders/sass.rb",
     "lib/sproutcore/builders/strings.rb",
     "lib/sproutcore/builders/stylesheet.rb",
     "lib/sproutcore/builders/test.rb",
     "lib/sproutcore/builders/test_index.rb",
     "lib/sproutcore/buildfile.rb",
     "lib/sproutcore/buildfile/build_task.rb",
     "lib/sproutcore/buildfile/buildfile_dsl.rb",
     "lib/sproutcore/buildfile/cloneable.rb",
     "lib/sproutcore/buildfile/early_time.rb",
     "lib/sproutcore/buildfile/invocation_chain.rb",
     "lib/sproutcore/buildfile/namespace.rb",
     "lib/sproutcore/buildfile/string_ext.rb",
     "lib/sproutcore/buildfile/task.rb",
     "lib/sproutcore/buildfile/task_arguments.rb",
     "lib/sproutcore/buildfile/task_manager.rb",
     "lib/sproutcore/deprecated/view_helper.rb",
     "lib/sproutcore/helpers/capture_helper.rb",
     "lib/sproutcore/helpers/cssmin.rb",
     "lib/sproutcore/helpers/dom_id_helper.rb",
     "lib/sproutcore/helpers/entry_sorter.rb",
     "lib/sproutcore/helpers/packed_optimizer.rb",
     "lib/sproutcore/helpers/static_helper.rb",
     "lib/sproutcore/helpers/tag_helper.rb",
     "lib/sproutcore/helpers/text_helper.rb",
     "lib/sproutcore/models/generator.rb",
     "lib/sproutcore/models/hash_struct.rb",
     "lib/sproutcore/models/manifest.rb",
     "lib/sproutcore/models/manifest_entry.rb",
     "lib/sproutcore/models/project.rb",
     "lib/sproutcore/models/target.rb",
     "lib/sproutcore/rack/builder.rb",
     "lib/sproutcore/rack/dev.rb",
     "lib/sproutcore/rack/docs.rb",
     "lib/sproutcore/rack/filesystem.rb",
     "lib/sproutcore/rack/proxy.rb",
     "lib/sproutcore/rack/service.rb",
     "lib/sproutcore/rack/test_runner.rb",
     "lib/sproutcore/render_engines/erubis.rb",
     "lib/sproutcore/render_engines/haml.rb",
     "lib/sproutcore/tools.rb",
     "lib/sproutcore/tools/build.rb",
     "lib/sproutcore/tools/build_number.rb",
     "lib/sproutcore/tools/gen.rb",
     "lib/sproutcore/tools/init.rb",
     "lib/sproutcore/tools/manifest.rb",
     "lib/sproutcore/tools/server.rb",
     "spec/buildtasks/build/copy_spec.rb",
     "spec/buildtasks/build/spec_helper.rb",
     "spec/buildtasks/manifest/catalog_spec.rb",
     "spec/buildtasks/manifest/hide_buildfiles_spec.rb",
     "spec/buildtasks/manifest/localize_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/combine_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/css_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/html_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/javascript_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/minify_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/packed_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/sass_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/strings_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/tests_spec.rb",
     "spec/buildtasks/manifest/prepare_spec.rb",
     "spec/buildtasks/manifest/spec_helper.rb",
     "spec/buildtasks/target_spec.rb",
     "spec/fixtures/builder_tests/Buildfile",
     "spec/fixtures/builder_tests/apps/combine_test/a.js",
     "spec/fixtures/builder_tests/apps/combine_test/b.js",
     "spec/fixtures/builder_tests/apps/combine_test/c.js",
     "spec/fixtures/builder_tests/apps/combine_test/english.lproj/a.css",
     "spec/fixtures/builder_tests/apps/combine_test/english.lproj/b.css",
     "spec/fixtures/builder_tests/apps/combine_test/english.lproj/c.css",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/bar1_sample.rhtml",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/erb_sample.html.erb",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/icons/image.png",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/image.jpg",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/rhtml_sample.rhtml",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/strings.js",
     "spec/fixtures/builder_tests/apps/html_test/english.lproj/style.css",
     "spec/fixtures/builder_tests/apps/html_test/french.lproj/french-icons/fr.png",
     "spec/fixtures/builder_tests/apps/html_test/french.lproj/strings.js",
     "spec/fixtures/builder_tests/apps/html_test/lib/layout_template.rhtml",
     "spec/fixtures/builder_tests/apps/html_test/scripts.js",
     "spec/fixtures/builder_tests/apps/javascript_test/sc_static.js",
     "spec/fixtures/builder_tests/apps/javascript_test/sc_super.js",
     "spec/fixtures/builder_tests/apps/javascript_test/strings.js",
     "spec/fixtures/builder_tests/apps/sass_test/sample.sass",
     "spec/fixtures/builder_tests/apps/strings_test/lproj/strings.js",
     "spec/fixtures/builder_tests/apps/stylesheet_test/build_directives.css",
     "spec/fixtures/builder_tests/apps/stylesheet_test/sc_static.css",
     "spec/fixtures/builder_tests/apps/test_test/lib/alt_layout.rhtml",
     "spec/fixtures/builder_tests/apps/test_test/lib/test_layout.rhtml",
     "spec/fixtures/builder_tests/apps/test_test/tests/qunit_test.js",
     "spec/fixtures/builder_tests/apps/test_test/tests/qunit_test2.js",
     "spec/fixtures/builder_tests/apps/test_test/tests/rhtml_test.rhtml",
     "spec/fixtures/builder_tests/frameworks/debug/core.js",
     "spec/fixtures/builder_tests/frameworks/debug/english.lproj/dummy.css",
     "spec/fixtures/builder_tests/frameworks/qunit/core.js",
     "spec/fixtures/builder_tests/frameworks/qunit/english.lproj/dummy.css",
     "spec/fixtures/builder_tests/frameworks/req_target_1/english.lproj/req_style_1.css",
     "spec/fixtures/builder_tests/frameworks/req_target_1/english.lproj/strings.js",
     "spec/fixtures/builder_tests/frameworks/req_target_1/english.lproj/test.rhtml",
     "spec/fixtures/builder_tests/frameworks/req_target_1/req_js_1.js",
     "spec/fixtures/builder_tests/frameworks/req_target_2/english.lproj/req_style_2.css",
     "spec/fixtures/builder_tests/frameworks/req_target_2/english.lproj/test.rhtml",
     "spec/fixtures/builder_tests/frameworks/req_target_2/javascript.js",
     "spec/fixtures/builder_tests/frameworks/req_target_2/lib/alt_layout.rhtml",
     "spec/fixtures/builder_tests/frameworks/req_target_2/req_js_2.js",
     "spec/fixtures/builder_tests/themes/sample_theme/Buildfile",
     "spec/fixtures/buildfiles/basic/Buildfile",
     "spec/fixtures/buildfiles/basic/task_module.rake",
     "spec/fixtures/buildfiles/installed/Buildfile",
     "spec/fixtures/buildfiles/installed/Buildfile2",
     "spec/fixtures/buildfiles/project_test/Buildfile",
     "spec/fixtures/buildfiles/project_test/not_project/Buildfile",
     "spec/fixtures/buildfiles/project_test/not_project/child/PLACEHOLDER",
     "spec/fixtures/entry_for_project/Buildfile",
     "spec/fixtures/entry_for_project/apps/test_app/entry.txt",
     "spec/fixtures/entry_for_project/apps/test_app/frameworks/nested/PLACEHOLDER",
     "spec/fixtures/entry_for_project/frameworks/shared/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/Buildfile",
     "spec/fixtures/find_targets/custom/bars/bar1/bars/bar1/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/bars/bar1/bars/bar2/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/bars/bar1/foos/foo1/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/bars/bar1/foos/foo2/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/foos/custom_foos/Buildfile",
     "spec/fixtures/find_targets/custom/foos/custom_foos/custom_foodir/foo1/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/foos/custom_foos/custom_foodir/foo2/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/foos/custom_foos/foos/not_foo1/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/foos/foo1/bars/bar1/PLACEHOLDER",
     "spec/fixtures/find_targets/custom/foos/foo1/bars/bar2/PLACEHOLDER",
     "spec/fixtures/find_targets/nested/Buildfile",
     "spec/fixtures/find_targets/nested/apps/app1/Buildfile",
     "spec/fixtures/find_targets/nested/apps/app1/apps/nested_app/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/Apps/app1/frameworks/framework1/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/Apps/app1/frameworks/framework2/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/clients/client1/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/frameworks/framework1/frameworks/framework1/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/frameworks/framework2/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/themes/theme1/PLACEHOLDER",
     "spec/fixtures/find_targets/standard/themes/theme2/PLACEHOLDER",
     "spec/fixtures/languages/apps/caps_long_names/English.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/caps_long_names/FreNCH.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/caps_long_names/UnknOWN.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/english.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/french.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/german.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/italian.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/japanese.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/spanish.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/long_names/unknown.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/no_names/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/de.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/en-CA.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/en-GB.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/en-US.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/en.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/es.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/foo.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/fr.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/it.lproj/PLACEHOLDER",
     "spec/fixtures/languages/apps/short_names/ja.lproj/PLACEHOLDER",
     "spec/fixtures/ordered_entries/apps/no_requires/1.js",
     "spec/fixtures/ordered_entries/apps/no_requires/B.js",
     "spec/fixtures/ordered_entries/apps/no_requires/a.js",
     "spec/fixtures/ordered_entries/apps/no_requires/a/a.js",
     "spec/fixtures/ordered_entries/apps/no_requires/a/b.js",
     "spec/fixtures/ordered_entries/apps/no_requires/b/a.js",
     "spec/fixtures/ordered_entries/apps/no_requires/c.js",
     "spec/fixtures/ordered_entries/apps/no_requires/core.js",
     "spec/fixtures/ordered_entries/apps/no_requires/english.lproj/B.css",
     "spec/fixtures/ordered_entries/apps/no_requires/english.lproj/a.css",
     "spec/fixtures/ordered_entries/apps/no_requires/english.lproj/a/a.css",
     "spec/fixtures/ordered_entries/apps/no_requires/english.lproj/a/b.css",
     "spec/fixtures/ordered_entries/apps/no_requires/english.lproj/b/a.css",
     "spec/fixtures/ordered_entries/apps/no_requires/english.lproj/c.css",
     "spec/fixtures/ordered_entries/apps/no_requires/lproj/strings.js",
     "spec/fixtures/ordered_entries/apps/no_requires/utils.js",
     "spec/fixtures/ordered_entries/apps/with_requires/a.js",
     "spec/fixtures/ordered_entries/apps/with_requires/b.js",
     "spec/fixtures/ordered_entries/apps/with_requires/c.js",
     "spec/fixtures/ordered_entries/apps/with_requires/english.lproj/a.css",
     "spec/fixtures/ordered_entries/apps/with_requires/english.lproj/b.css",
     "spec/fixtures/ordered_entries/apps/with_requires/english.lproj/c.css",
     "spec/fixtures/ordered_entries/apps/with_requires/english.lproj/d.js",
     "spec/fixtures/real_world/Buildfile",
     "spec/fixtures/real_world/apps/account/README",
     "spec/fixtures/real_world/apps/calendar/README",
     "spec/fixtures/real_world/apps/contacts/README_BEFORE_EDITING",
     "spec/fixtures/real_world/apps/files/README",
     "spec/fixtures/real_world/apps/mail/README",
     "spec/fixtures/real_world/apps/mobile_photos/README",
     "spec/fixtures/real_world/apps/photos/README",
     "spec/fixtures/real_world/apps/uploader/README",
     "spec/fixtures/real_world/frameworks/core_files/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/core_photos/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/shared/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/Buildfile",
     "spec/fixtures/real_world/frameworks/sproutcore/README",
     "spec/fixtures/real_world/frameworks/sproutcore/apps/docs/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/apps/test_runner/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/core.js",
     "spec/fixtures/real_world/frameworks/sproutcore/debug/debug-resource.html",
     "spec/fixtures/real_world/frameworks/sproutcore/debug/sample_debug.js",
     "spec/fixtures/real_world/frameworks/sproutcore/demo2.js",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/debug/sample_debug-loc.js",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/demo.css",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/demo.html",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/demo2.sass",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/file_extension_test.haml",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/file_extension_test.html.erb",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/file_extension_test.rhtml",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/fixtures/sample_fixtures-loc.js",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/has_require.css",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/no_require.css",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/no_sc_resource.rhtml",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/protocols/sample-loc.js",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/sc_resource.css",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/sc_resource.rhtml",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/strings.js",
     "spec/fixtures/real_world/frameworks/sproutcore/english.lproj/tests/sample-loc.js",
     "spec/fixtures/real_world/frameworks/sproutcore/fixtures/sample-json-fixture.json",
     "spec/fixtures/real_world/frameworks/sproutcore/fixtures/sample_fixtures.js",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/application/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/costello/core.js",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/data_store/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/debug/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/desktop/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/empty_theme/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/foundation/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/mobile/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/qunit/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/frameworks/uploader/PLACEHOLDER",
     "spec/fixtures/real_world/frameworks/sproutcore/french.lproj/french-resource.js",
     "spec/fixtures/real_world/frameworks/sproutcore/french.lproj/strings.js",
     "spec/fixtures/real_world/frameworks/sproutcore/german.lproj/german-resource.js",
     "spec/fixtures/real_world/frameworks/sproutcore/german.lproj/strings.js",
     "spec/fixtures/real_world/frameworks/sproutcore/has_require.js",
     "spec/fixtures/real_world/frameworks/sproutcore/lib/index.html",
     "spec/fixtures/real_world/frameworks/sproutcore/no_require.js",
     "spec/fixtures/real_world/frameworks/sproutcore/protocols/sample.js",
     "spec/fixtures/real_world/frameworks/sproutcore/sc_resource.js",
     "spec/fixtures/real_world/frameworks/sproutcore/tests/nested/sample1.js",
     "spec/fixtures/real_world/frameworks/sproutcore/tests/nested/sample2.js",
     "spec/fixtures/real_world/frameworks/sproutcore/tests/sample.js",
     "spec/fixtures/real_world/frameworks/sproutcore/tests/sample.rhtml",
     "spec/fixtures/real_world/frameworks/sproutcore/themes/standard_theme/README",
     "spec/fixtures/real_world/frameworks/sproutcore/views/view.js",
     "spec/fixtures/real_world/generators/sample_custom/Buildfile",
     "spec/fixtures/recursive_project/Buildfile",
     "spec/fixtures/recursive_project/frameworks/sproutcore/frameworks/costello/PLACEHOLDER",
     "spec/lib/builders/combine_spec.rb",
     "spec/lib/builders/html_spec.rb",
     "spec/lib/builders/javascript_spec.rb",
     "spec/lib/builders/sass_spec.rb",
     "spec/lib/builders/spec_helper.rb",
     "spec/lib/builders/strings_spec.rb",
     "spec/lib/builders/stylesheet_spec.rb",
     "spec/lib/builders/test_index_spec.rb",
     "spec/lib/builders/test_spec.rb",
     "spec/lib/buildfile/config_for_spec.rb",
     "spec/lib/buildfile/define_spec.rb",
     "spec/lib/buildfile/dup_spec.rb",
     "spec/lib/buildfile/invoke_spec.rb",
     "spec/lib/buildfile/load_spec.rb",
     "spec/lib/buildfile/task/dup_spec.rb",
     "spec/lib/buildfile/task_defined_spec.rb",
     "spec/lib/buildfile_commands/build_task_spec.rb",
     "spec/lib/buildfile_commands/config_spec.rb",
     "spec/lib/buildfile_commands/import_spec.rb",
     "spec/lib/buildfile_commands/namespace_spec.rb",
     "spec/lib/buildfile_commands/proxies_spec.rb",
     "spec/lib/buildfile_commands/replace_task_spec.rb",
     "spec/lib/buildfile_commands/task_spec.rb",
     "spec/lib/helpers/packing_optimizer/optimize_spec.rb",
     "spec/lib/models/hash_struct/deep_clone_spec.rb",
     "spec/lib/models/hash_struct/has_options_spec.rb",
     "spec/lib/models/hash_struct/hash_spec.rb",
     "spec/lib/models/hash_struct/merge_spec.rb",
     "spec/lib/models/hash_struct/method_missing.rb",
     "spec/lib/models/manifest/add_entry_spec.rb",
     "spec/lib/models/manifest/add_transform_spec.rb",
     "spec/lib/models/manifest/build_spec.rb",
     "spec/lib/models/manifest/entry_for_spec.rb",
     "spec/lib/models/manifest/find_entry.rb",
     "spec/lib/models/manifest/prepare_spec.rb",
     "spec/lib/models/manifest_entry/cacheable_url_spec.rb",
     "spec/lib/models/manifest_entry/prepare_spec.rb",
     "spec/lib/models/project/add_target_spec.rb",
     "spec/lib/models/project/buildfile_spec.rb",
     "spec/lib/models/project/find_targets_for_spec.rb",
     "spec/lib/models/project/load_nearest_project_spec.rb",
     "spec/lib/models/project/target_for_spec.rb",
     "spec/lib/models/project/targets_spec.rb",
     "spec/lib/models/target/compute_build_number_spec.rb",
     "spec/lib/models/target/config_spec.rb",
     "spec/lib/models/target/expand_required_targets_spec.rb",
     "spec/lib/models/target/installed_languages_spec.rb",
     "spec/lib/models/target/lproj_for_spec.rb",
     "spec/lib/models/target/manifest_for_spec.rb",
     "spec/lib/models/target/parent_target_spec.rb",
     "spec/lib/models/target/prepare_spec.rb",
     "spec/lib/models/target/required_targets_spec.rb",
     "spec/lib/models/target/target_for_spec.rb",
     "spec/lib/tools/build_number_spec.rb",
     "spec/lib/tools/gen_spec.rb",
     "spec/lib/tools/tools_spec.rb",
     "spec/spec_helper.rb",
     "sproutcore-abbot.gemspec",
     "vendor/github_gem_lint.rb",
     "vendor/jsdoc/README.txt",
     "vendor/jsdoc/app/frame.js",
     "vendor/jsdoc/app/frame/Chain.js",
     "vendor/jsdoc/app/frame/Dumper.js",
     "vendor/jsdoc/app/frame/Hash.js",
     "vendor/jsdoc/app/frame/Link.js",
     "vendor/jsdoc/app/frame/Namespace.js",
     "vendor/jsdoc/app/frame/Opt.js",
     "vendor/jsdoc/app/frame/Reflection.js",
     "vendor/jsdoc/app/frame/String.js",
     "vendor/jsdoc/app/frame/Testrun.js",
     "vendor/jsdoc/app/handlers/FOODOC.js",
     "vendor/jsdoc/app/handlers/XMLDOC.js",
     "vendor/jsdoc/app/handlers/XMLDOC/DomReader.js",
     "vendor/jsdoc/app/handlers/XMLDOC/XMLDoc.js",
     "vendor/jsdoc/app/handlers/XMLDOC/XMLParse.js",
     "vendor/jsdoc/app/lib/JSDOC.js",
     "vendor/jsdoc/app/lib/JSDOC/DocComment.js",
     "vendor/jsdoc/app/lib/JSDOC/DocTag.js",
     "vendor/jsdoc/app/lib/JSDOC/JsDoc.js",
     "vendor/jsdoc/app/lib/JSDOC/JsPlate.js",
     "vendor/jsdoc/app/lib/JSDOC/Lang.js",
     "vendor/jsdoc/app/lib/JSDOC/Parser.js",
     "vendor/jsdoc/app/lib/JSDOC/PluginManager.js",
     "vendor/jsdoc/app/lib/JSDOC/Symbol.js",
     "vendor/jsdoc/app/lib/JSDOC/SymbolSet.js",
     "vendor/jsdoc/app/lib/JSDOC/TextStream.js",
     "vendor/jsdoc/app/lib/JSDOC/Token.js",
     "vendor/jsdoc/app/lib/JSDOC/TokenReader.js",
     "vendor/jsdoc/app/lib/JSDOC/TokenStream.js",
     "vendor/jsdoc/app/lib/JSDOC/Util.js",
     "vendor/jsdoc/app/lib/JSDOC/Walker.js",
     "vendor/jsdoc/app/main.js",
     "vendor/jsdoc/app/plugins/commentSrcJson.js",
     "vendor/jsdoc/app/plugins/frameworkPrototype.js",
     "vendor/jsdoc/app/plugins/functionCall.js",
     "vendor/jsdoc/app/plugins/publishSrcHilite.js",
     "vendor/jsdoc/app/plugins/sproutcoreTags.js",
     "vendor/jsdoc/app/plugins/symbolLink.js",
     "vendor/jsdoc/app/plugins/tagParamConfig.js",
     "vendor/jsdoc/app/plugins/tagSynonyms.js",
     "vendor/jsdoc/app/run.js",
     "vendor/jsdoc/app/t/TestDoc.js",
     "vendor/jsdoc/app/t/runner.js",
     "vendor/jsdoc/app/test.js",
     "vendor/jsdoc/app/test/addon.js",
     "vendor/jsdoc/app/test/anon_inner.js",
     "vendor/jsdoc/app/test/augments.js",
     "vendor/jsdoc/app/test/augments2.js",
     "vendor/jsdoc/app/test/borrows.js",
     "vendor/jsdoc/app/test/borrows2.js",
     "vendor/jsdoc/app/test/config.js",
     "vendor/jsdoc/app/test/constructs.js",
     "vendor/jsdoc/app/test/encoding.js",
     "vendor/jsdoc/app/test/encoding_other.js",
     "vendor/jsdoc/app/test/functions_anon.js",
     "vendor/jsdoc/app/test/functions_nested.js",
     "vendor/jsdoc/app/test/global.js",
     "vendor/jsdoc/app/test/globals.js",
     "vendor/jsdoc/app/test/ignore.js",
     "vendor/jsdoc/app/test/inner.js",
     "vendor/jsdoc/app/test/jsdoc_test.js",
     "vendor/jsdoc/app/test/lend.js",
     "vendor/jsdoc/app/test/memberof.js",
     "vendor/jsdoc/app/test/memberof_constructor.js",
     "vendor/jsdoc/app/test/name.js",
     "vendor/jsdoc/app/test/namespace_nested.js",
     "vendor/jsdoc/app/test/nocode.js",
     "vendor/jsdoc/app/test/oblit_anon.js",
     "vendor/jsdoc/app/test/overview.js",
     "vendor/jsdoc/app/test/param_inline.js",
     "vendor/jsdoc/app/test/params_optional.js",
     "vendor/jsdoc/app/test/prototype.js",
     "vendor/jsdoc/app/test/prototype_nested.js",
     "vendor/jsdoc/app/test/prototype_oblit.js",
     "vendor/jsdoc/app/test/prototype_oblit_constructor.js",
     "vendor/jsdoc/app/test/public.js",
     "vendor/jsdoc/app/test/shared.js",
     "vendor/jsdoc/app/test/shared2.js",
     "vendor/jsdoc/app/test/shortcuts.js",
     "vendor/jsdoc/app/test/static_this.js",
     "vendor/jsdoc/app/test/synonyms.js",
     "vendor/jsdoc/app/test/tosource.js",
     "vendor/jsdoc/app/test/variable_redefine.js",
     "vendor/jsdoc/changes.txt",
     "vendor/jsdoc/conf/sample.conf",
     "vendor/jsdoc/java/build.xml",
     "vendor/jsdoc/java/build_1.4.xml",
     "vendor/jsdoc/java/classes/js.jar",
     "vendor/jsdoc/java/src/JsDebugRun.java",
     "vendor/jsdoc/java/src/JsRun.java",
     "vendor/jsdoc/jsdebug.jar",
     "vendor/jsdoc/jsrun.jar",
     "vendor/jsdoc/t/TestDoc.js",
     "vendor/jsdoc/t/runner.js",
     "vendor/jsdoc/templates/jsdoc/allclasses.tmpl",
     "vendor/jsdoc/templates/jsdoc/allfiles.tmpl",
     "vendor/jsdoc/templates/jsdoc/class.tmpl",
     "vendor/jsdoc/templates/jsdoc/index.tmpl",
     "vendor/jsdoc/templates/jsdoc/publish.js",
     "vendor/jsdoc/templates/jsdoc/static/default.css",
     "vendor/jsdoc/templates/jsdoc/static/header.html",
     "vendor/jsdoc/templates/jsdoc/static/index.html",
     "vendor/jsdoc/templates/jsdoc/symbol.tmpl",
     "vendor/jsdoc/templates/sproutcore/allclasses.tmpl",
     "vendor/jsdoc/templates/sproutcore/allfiles.tmpl",
     "vendor/jsdoc/templates/sproutcore/class.tmpl",
     "vendor/jsdoc/templates/sproutcore/index.tmpl",
     "vendor/jsdoc/templates/sproutcore/publish.js",
     "vendor/jsdoc/templates/sproutcore/static/default.css",
     "vendor/jsdoc/templates/sproutcore/static/header.html",
     "vendor/jsdoc/templates/sproutcore/static/index.html",
     "vendor/jsdoc/templates/sproutcore/symbol.tmpl",
     "vendor/jsdoc/test.js",
     "vendor/jsdoc/test/addon.js",
     "vendor/jsdoc/test/anon_inner.js",
     "vendor/jsdoc/test/augments.js",
     "vendor/jsdoc/test/augments2.js",
     "vendor/jsdoc/test/borrows.js",
     "vendor/jsdoc/test/borrows2.js",
     "vendor/jsdoc/test/config.js",
     "vendor/jsdoc/test/constructs.js",
     "vendor/jsdoc/test/encoding.js",
     "vendor/jsdoc/test/encoding_other.js",
     "vendor/jsdoc/test/functions_anon.js",
     "vendor/jsdoc/test/functions_nested.js",
     "vendor/jsdoc/test/global.js",
     "vendor/jsdoc/test/globals.js",
     "vendor/jsdoc/test/ignore.js",
     "vendor/jsdoc/test/inner.js",
     "vendor/jsdoc/test/jsdoc_test.js",
     "vendor/jsdoc/test/lend.js",
     "vendor/jsdoc/test/memberof.js",
     "vendor/jsdoc/test/memberof_constructor.js",
     "vendor/jsdoc/test/name.js",
     "vendor/jsdoc/test/namespace_nested.js",
     "vendor/jsdoc/test/nocode.js",
     "vendor/jsdoc/test/oblit_anon.js",
     "vendor/jsdoc/test/overview.js",
     "vendor/jsdoc/test/param_inline.js",
     "vendor/jsdoc/test/params_optional.js",
     "vendor/jsdoc/test/prototype.js",
     "vendor/jsdoc/test/prototype_nested.js",
     "vendor/jsdoc/test/prototype_oblit.js",
     "vendor/jsdoc/test/prototype_oblit_constructor.js",
     "vendor/jsdoc/test/public.js",
     "vendor/jsdoc/test/shared.js",
     "vendor/jsdoc/test/shared2.js",
     "vendor/jsdoc/test/shortcuts.js",
     "vendor/jsdoc/test/static_this.js",
     "vendor/jsdoc/test/synonyms.js",
     "vendor/jsdoc/test/tosource.js",
     "vendor/jsdoc/test/variable_redefine.js",
     "vendor/yui-compressor/yuicompressor-2.4.2.jar"
  ]
  s.homepage = %q{http://www.sproutcore.com/sproutcore}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sproutcore}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{SproutCore is a platform for building native look-and-feel applications on  the web}
  s.test_files = [
    "spec/buildtasks/build/copy_spec.rb",
     "spec/buildtasks/build/spec_helper.rb",
     "spec/buildtasks/manifest/catalog_spec.rb",
     "spec/buildtasks/manifest/hide_buildfiles_spec.rb",
     "spec/buildtasks/manifest/localize_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/combine_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/css_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/html_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/javascript_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/minify_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/packed_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/sass_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/strings_spec.rb",
     "spec/buildtasks/manifest/prepare_build_tasks/tests_spec.rb",
     "spec/buildtasks/manifest/prepare_spec.rb",
     "spec/buildtasks/manifest/spec_helper.rb",
     "spec/buildtasks/target_spec.rb",
     "spec/lib/builders/combine_spec.rb",
     "spec/lib/builders/html_spec.rb",
     "spec/lib/builders/javascript_spec.rb",
     "spec/lib/builders/sass_spec.rb",
     "spec/lib/builders/spec_helper.rb",
     "spec/lib/builders/strings_spec.rb",
     "spec/lib/builders/stylesheet_spec.rb",
     "spec/lib/builders/test_index_spec.rb",
     "spec/lib/builders/test_spec.rb",
     "spec/lib/buildfile/config_for_spec.rb",
     "spec/lib/buildfile/define_spec.rb",
     "spec/lib/buildfile/dup_spec.rb",
     "spec/lib/buildfile/invoke_spec.rb",
     "spec/lib/buildfile/load_spec.rb",
     "spec/lib/buildfile/task/dup_spec.rb",
     "spec/lib/buildfile/task_defined_spec.rb",
     "spec/lib/buildfile_commands/build_task_spec.rb",
     "spec/lib/buildfile_commands/config_spec.rb",
     "spec/lib/buildfile_commands/import_spec.rb",
     "spec/lib/buildfile_commands/namespace_spec.rb",
     "spec/lib/buildfile_commands/proxies_spec.rb",
     "spec/lib/buildfile_commands/replace_task_spec.rb",
     "spec/lib/buildfile_commands/task_spec.rb",
     "spec/lib/helpers/packing_optimizer/optimize_spec.rb",
     "spec/lib/models/hash_struct/deep_clone_spec.rb",
     "spec/lib/models/hash_struct/has_options_spec.rb",
     "spec/lib/models/hash_struct/hash_spec.rb",
     "spec/lib/models/hash_struct/merge_spec.rb",
     "spec/lib/models/hash_struct/method_missing.rb",
     "spec/lib/models/manifest/add_entry_spec.rb",
     "spec/lib/models/manifest/add_transform_spec.rb",
     "spec/lib/models/manifest/build_spec.rb",
     "spec/lib/models/manifest/entry_for_spec.rb",
     "spec/lib/models/manifest/find_entry.rb",
     "spec/lib/models/manifest/prepare_spec.rb",
     "spec/lib/models/manifest_entry/cacheable_url_spec.rb",
     "spec/lib/models/manifest_entry/prepare_spec.rb",
     "spec/lib/models/project/add_target_spec.rb",
     "spec/lib/models/project/buildfile_spec.rb",
     "spec/lib/models/project/find_targets_for_spec.rb",
     "spec/lib/models/project/load_nearest_project_spec.rb",
     "spec/lib/models/project/target_for_spec.rb",
     "spec/lib/models/project/targets_spec.rb",
     "spec/lib/models/target/compute_build_number_spec.rb",
     "spec/lib/models/target/config_spec.rb",
     "spec/lib/models/target/expand_required_targets_spec.rb",
     "spec/lib/models/target/installed_languages_spec.rb",
     "spec/lib/models/target/lproj_for_spec.rb",
     "spec/lib/models/target/manifest_for_spec.rb",
     "spec/lib/models/target/parent_target_spec.rb",
     "spec/lib/models/target/prepare_spec.rb",
     "spec/lib/models/target/required_targets_spec.rb",
     "spec/lib/models/target/target_for_spec.rb",
     "spec/lib/tools/build_number_spec.rb",
     "spec/lib/tools/gen_spec.rb",
     "spec/lib/tools/tools_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<json_pure>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<extlib>, [">= 0.9.9"])
      s.add_runtime_dependency(%q<erubis>, [">= 2.6.2"])
      s.add_development_dependency(%q<jeweler>, [">= 1.0.1"])
    else
      s.add_dependency(%q<rack>, [">= 0.9.1"])
      s.add_dependency(%q<json_pure>, [">= 1.1.0"])
      s.add_dependency(%q<extlib>, [">= 0.9.9"])
      s.add_dependency(%q<erubis>, [">= 2.6.2"])
      s.add_dependency(%q<jeweler>, [">= 1.0.1"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0.9.1"])
    s.add_dependency(%q<json_pure>, [">= 1.1.0"])
    s.add_dependency(%q<extlib>, [">= 0.9.9"])
    s.add_dependency(%q<erubis>, [">= 2.6.2"])
    s.add_dependency(%q<jeweler>, [">= 1.0.1"])
  end
end