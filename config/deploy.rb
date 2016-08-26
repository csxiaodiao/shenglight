# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'shengwei_php'
set :repo_url, "git@github.com:csxiaodiao/shenglight.git"
set :repo_tree, 'website'

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :deploy_to, "/var/apps/#{fetch(:application)}_#{fetch(:stage)}"

set :linked_files, %w{
  caches/configs/database.php
  phpsso_server/caches/configs/database.php
}

set :linked_dirs, %w{
  uploadfile
}

set :keep_releases, 20

set :ssh_options, {forward_agent: true}

# rvm
set :rvm_ruby_version, "2.2.2@#{fetch(:application)}_#{fetch(:stage)}"

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
        # execute "rm -rf #{release_path}/data/cache/*"
      # end
    end
  end

end
