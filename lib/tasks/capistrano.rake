# =============================================================================
	# A set of rake tasks for invoking the Capistrano automation utility.
	# =============================================================================
	# Invoke the given actions via Capistrano
	def cap(*parameters)
	  begin
	    require 'rubygems'
	  rescue LoadError
	    # no rubygems to load, so we fail silently
	  end

	  require 'capistrano/cli'

	  Capistrano::CLI.new(parameters.map { |param| param.to_s }).execute!
	end

	namespace :cap do
    desc "dd"
	  task(:deploy) { IO.popen("cap deploy >0") { |f| puts f.gets } }
    desc "pre"
	  task(:prepare) { IO.popen("cap prepare >0") { |f| puts f.gets } }
    task(:setup) { IO.popen("cap deploy:setup >0") { |f| puts f.gets } }
	  desc "Execute a specific action using capistrano"
	  task :exec do
	    unless ENV['ACTION']
	      raise "Please specify an action (or comma separated list of actions) via the ACTION environment variable"
	    end

	    actions = ENV['ACTION'].split(",")
	    actions.concat(ENV['PARAMS'].split(" ")) if ENV['PARAMS']

	    cap(*actions)
	  end
	end
	desc "Push the latest revision into production (delegates to remote:deploy)"
	task :deploy => "cap:deploy"

	desc "Rollback to the release before the current release in production (delegates to remote:rollback)"
	task :rollback => "remote:rollback"