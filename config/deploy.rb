#

set :application, "openfrbr"
set :repository,  "git://github.com/wdenton/openfrbr.git"
set :deploy_to, "/var/www/openfrbr.org"
set :scm, :git

server "anvil.lisforge.net", :app, :web, :db, :primary => true

set :user, "wtd"
set :runner, "wtd"


namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

# namespace :deploy do
#   desc "Restarting mod_rails with restart.txt"
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "touch #{current_path}/tmp/restart.txt"
#   end

#   [:start, :stop].each do |t|
#     desc "#{t} task is a no-op with mod_rails"
#     task t, :roles => :app do ; end
#   end
# end

#namespace :passenger do
#  desc "Restart Application"
#  task :restart do
#    run "touch #{current_path}/tmp/restart.txt"
#  end
#end

#after :deploy, "passenger:restart"
