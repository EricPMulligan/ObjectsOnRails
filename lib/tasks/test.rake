require 'rspec/core/rake_task'
namespace 'test' do |ns|
  test_files             = FileList['spec/**/*_spec.rb']
  integration_test_files = FileList['spec/**/*_integration_spec.rb']
  unit_test_files        = test_files - integration_test_files

  desc 'Run unit tests'
  RSpec::Core::RakeTask.new('unit') do |t|
    # t.libs.push 'lib'
    t.test_files = unit_test_files
    t.verbose = true
  end

  desc 'Run integration tests'
  RSpec::Core::RakeTask.new('integration') do |t|
    t.libs.push 'lib'
    t.test_files = integration_test_files
    t.verbose = true
  end
end

# Clear out the default Rails dependencies
Rake::Task['test'].clear
desc 'Run all tests'
task 'test' => %w[test:unit test:integration]