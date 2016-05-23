lock '3.5.0'

set :application, 'deltamike_node'
set :repo_url,    'git@bitbucket.org:caspg/deltamike-node.git'
set :user,        'caspg'

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :linked_dirs, %w(
  node_modules
  log
)

set :keep_releases, 3

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  # desc 'Initial Deploy'
  # task :initial do
  #   on roles(:app) do
  #     # before 'deploy:restart', 'deploy:start'
  #     invoke 'deploy'
  #   end
  # end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app) do
  #     within release_path do
  #       run('npm run restart-server-prod')
  #     end
  #   end
  # end

  # desc 'Start application'
  # task :start do
  #   on roles(:app) do
  #     within release_path do
  #       run('npm run start-server-prod > /dev/null 2>&1 &')
  #     end
  #   end
  # end

  # desc 'Build react file' do
  #   task :build do
  #     on roles(:app) do
  #       within release_path do
  #         execute(:npm, :run, 'build')
  #       end
  #     end
  #   end
  # end

  before :starting, :check_revision
  # after :finishing, :restart
  # after :finishing, :build
end
