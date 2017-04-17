require 'rake/testtask'

task default: %w[test]

Rake::TestTask.new(:test) do |t|
  t.libs = ['lib']
  t.warning = true
  t.verbose = true
  t.test_files = FileList['test/*_test.rb']
end
