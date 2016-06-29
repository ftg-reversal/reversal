Rake.application.remove_task 'db:test:prepare'

namespace :db do
  namespace :test do
    task :prepare do |t|
      ridgepole('-c config/database.yml', '-f db/Schemafile', '--apply')
    end
  end
end
