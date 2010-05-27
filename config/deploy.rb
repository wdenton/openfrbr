set :application, "openfrbr"
set :repository,  "git://github.com/wdenton/openfrbr.git"
set :deploy_to, "/var/www/openfrbr.org"
set :scm, :git

server "anvil.lisforge.net", :app, :web, :db, :primary => true

set :user, "wtd"
set :runner, "wtd"
set :use_sudo, false

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
