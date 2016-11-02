require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

desc "Validate manifests, templates, and ruby files"
task :syntax_validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    flags = ENV['FUTURE_PARSER'] == 'yes' ? '--parser future' : ''
    sh "puppet parser validate  --noop #{flags}  #{manifest}"
  end

end

task :default => [:syntax_validate, :lint]
