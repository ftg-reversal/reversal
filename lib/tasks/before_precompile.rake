task :build_frontend do
  sh 'npm install'
  sh 'npm run prod'
end

Rake::Task['assets:precompile'].enhance(%i(build_frontend))
