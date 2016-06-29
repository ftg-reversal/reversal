Rake.application.instance_variable_get('@tasks').delete('db:version')
Rake.application.instance_variable_get('@tasks').delete('db:rollback')
Rake.application.instance_variable_get('@tasks').delete('db:migrate')
Rake.application.instance_variable_get('@tasks').delete('db:migrate:status')
Rake.application.instance_variable_get('@tasks').delete('db:schema:dump')
Rake.application.instance_variable_get('@tasks').delete('db:schema:load')
Rake.application.instance_variable_get('@tasks').delete('db:schema:cache:dump')
Rake.application.instance_variable_get('@tasks').delete('db:schema:cache:clear')
Rake.application.instance_variable_get('@tasks').delete('db:structure:dump')
Rake.application.instance_variable_get('@tasks').delete('db:structure:load')

namespace :db do
  desc 'Apply database schema (options: DRYRUN=false, VERBOSE=false)'
  task migrate: :environment do
    Rake::Task['ridgepole:apply'].invoke
    Rake::Task['ridgepole:export'].invoke unless ENV['DRYRUN']
  end
  namespace :schema do
    desc 'Creates a db/Schemafile'
    task dump: :environment do
      Rake::Task['ridgepole:export'].invoke
    end

    desc 'Loads a Schemafile into the database'
    task load: :environment do
      Rake::Task['ridgepole:apply'].invoke
    end
  end
end

namespace :ridgepole do
  desc 'Apply database schema (options: DRYRUN=false, VERBOSE=false)'
  task apply: :environment do
    options = ['--apply']
    options << '--dry-run' if ENV['DRYRUN']
    options << '--verbose' if ENV['VERBOSE']
    ridgepole(*options, "--file #{schema_file}")
  end

  desc 'Export database schema'
  task export: :environment do
    options = ['--export']
    ridgepole(*options, "--output #{schema_file}")
  end

  private

  def schema_file
    Rails.root.join('db/Schemafile')
  end

  def config_file
    Rails.root.join('config/database.yml')
  end

  def ridgepole(*options)
    command = ['bundle exec ridgepole', "--config #{config_file} --env #{Rails.env}"]
    system [command + options].join(' ')
  end
end
