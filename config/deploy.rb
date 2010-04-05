default_run_options[:pty] = true
set :user,'root'
set :password,'200113'
set :application, "doctorthinking.com"
set :repository,  "git://github.com/zhu1230/doctorthinking.git"
set :use_sudo, false 
# If you have previously been relying upon the code to start, stop 
# and restart your mongrel application, or if you rely on the database
# migration code, please uncomment the lines you require below

# If you are deploying a rails app you probably need these:

# load 'ext/rails-database-migrations.rb'
# load 'ext/rails-shared-directories.rb'

# There are also new utility libaries shipped with the core these 
# include the following, please see individual files for more
# documentation, or run `cap -vT` with the following lines commented
# out to see what they make available.

# load 'ext/spinner.rb'              # Designed for use with script/spin
# load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
# load 'ext/web-disable-enable.rb'   # Gives you web:disable and web:enable

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
 set :deploy_to, "/var/www/html/#{application}"
# set :scm_username, "zhu1230"
#set :scm_password, "zhu1230"
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, "git"
# see a full list by running "gem contents capistrano | grep 'scm/'"

role :web, "doctorthinking.com"
role :app, "doctorthinking.com"
role :db, "doctorthinking.com"




after "deploy:symlink",:prepare

desc "restart override"
task :restart, :roles => :app do
  run "apachectl restart"
end

desc "change file mode"
task :prepare do
  run "chmod -R 0755 /var/www/html/#{application}/current/*"
  run "touch /var/www/html/#{application}/current/log/acts_as_ferret.log | chmod -R 0777 /var/www/html/#{application}/current/log/acts_as_ferret.log"
  run "chown -R apache /var/www/html/#{application}/current/*"
  run "cd /var/www/html/#{application}/current/"
  run "rake db:migrate"
#  run "apachectl restart"
end
