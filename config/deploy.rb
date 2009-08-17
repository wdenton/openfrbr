set :application, "OpenFRBR"
set :repository,  "git://github.com/wdenton/openfrbr.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/var/www/openfrbr.org"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

server "anvil.lisforge.net", :app, :web, :db, :primary => true

set :user, "wtd"
