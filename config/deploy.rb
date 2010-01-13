set :stages, %w(staging production)
set :default_stage, "production"

require 'capistrano/ext/multistage'

##########################
#  PARÁMETROS GENERALES  #
##########################
set :application,  "ocr"
set :repository,   "ssh://deploys@91.121.229.244/home/git/ocr"
set :deploy_to,    "/var/www/#{application}"
set :server_group, 'www-data'
set :runner,       'deploys'
set :user,         'deploys'

#########
#  SCM  #
#########
set :scm,         :git
set :branch,      "master"
set :scm_user,    'deploys'
set :git_enable_submodules, 1

#####################
# FORMA DE DEPLOYAR #
#####################
set :deploy_via, :remote_cache
set :keep_releases, 5
default_run_options[:pty] = true #supuestamente subsana algún que otro error
ssh_options[:paranoid] = false
set :use_sudo, false


##############
#  MAQUINAS  #
##############
#
set :ocr,    '91.121.229.244'

#########
# ROLES #
#########
role :web,      ocr
role :app,      ocr
role :db,       ocr

#####################
## PERSONALIZACIÓN ##
#####################
after  "deploy:update_code", :delete_git_folder, :run_migrations
after  "deploy:update", "deploy:cleanup"

###############
##  TAREAS   ##
###############

desc "Migrations"
task :run_migrations, :roles => :app do
  run <<-CMD
    export RAILS_ENV=production &&
    cd #{release_path} &&
    rake db:migrate
  CMD
end

desc "Restart Application"
deploy.task :restart, :roles => [:app] do
  run "touch #{current_path}/tmp/restart.txt"
end
task :delete_git_folder, :roles => [:web] do
  run "rm -rf #{release_path}/.git"
end


