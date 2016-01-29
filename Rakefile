# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :test_log => :environment do
  Rails.logger.level = Logger::DEBUG
  Rake::Task['db:migrate'].invoke
end