set :application,  "turismoconquense"
set :repository,   "ssh://deploys@91.121.229.244/home/git/turismoconquense"
set :deploy_to,    "/var/www/#{application}"
set :server_group, 'www-data'
set :runner,       'deploys'
set :user,         'deploys'
set :rake,         "/opt/ruby-enterprise-1.8.7-2009.10/bin/rake"
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
set :turismoconquense,    '91.121.229.244'

#########
# ROLES #
#########
role :web,      turismoconquense
role :app,      turismoconquense
role :db,       turismoconquense

#####################
## PERSONALIZACIÓN ##
#####################
after  "deploy:update_code", :delete_git_folder, :run_migrations#, :generate_sitemap
after  "deploy:update", "deploy:cleanup"

###############
##  TAREAS   ##
###############

desc "Migrations"
task :run_migrations, :roles => :app do
  run <<-CMD
    export RAILS_ENV=production &&
    cd #{release_path} &&
    /opt/ruby-enterprise-1.8.7-2009.10/bin/rake db:migrate
  CMD
end

desc "Restart Application"
deploy.task :restart, :roles => [:app] do
  run "touch #{current_path}/tmp/restart.txt"
end
task :delete_git_folder, :roles => [:web] do
  run "rm -rf #{release_path}/.git"
end

desc "Generar Sitemap"
task :generate_sitemap, :roles => [:web] do
  run <<-EOF
     cd #{release_path} && /opt/ruby-enterprise-1.8.7-2009.10/bin/rake RAILS_ENV=production sitemap:refresh:no_ping
   EOF
end

