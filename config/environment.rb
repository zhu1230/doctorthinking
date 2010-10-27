# Be sure to restart your server when you modify this file
#ENV['GEM_PATH'] = File.expand_path('~/.gems') + ':/usr/lib/ruby/gems/1.8'

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require 'plugins/app_config/lib/configuration'
Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  config.gem "peteonrails-vote_fu", :lib => 'vote_fu', :source => 'http://gems.github.com'
  config.gem 'disguise'
  config.gem "ruby-openid", :lib => "openid"
  config.gem "aws-s3", :lib => "aws/s3"

  config.gem 'tiny_mce'
  config.active_record.observers = :user_observer

  # config.gem "jammit"

  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"


  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug
config.load_paths += %W(#{RAILS_ROOT}/app/middleware)
  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  #config.time_zone = 'UTC'
  #config.time_zone = 'Eastern Time (US & Canada)'
  config.time_zone = 'UTC'
  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.

  # config.action_controller.session = {
  #   :session_key => '_enginey_session',
  #   :secret      => '1de1b661448c6a6b1ad69c2e7dfdf921887cde6d32f1e218f4f69a600f4969195085e05e9f24a8a911cae34d9085ac4c115510857b11df236f7526d2a0c307a7'
  # }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
 # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.i18n.default_locale = 'zh-CN'
  config.app_config.maxRankBingliCommentOneDay=20
  config.app_config.maxRankBingliInfoOneDay=20
  config.app_config.rankTagBingliInfo={:perfect=>10,:fine=>5,:hide=>-3}
  config.app_config.perfectNum='10'
  config.app_config.fineNum='5'
 config.active_record.observers = :announcement_observer, :invite_observer, :user_observer, :message_observer, :wall_post_observer
 
 config.action_mailer.delivery_method = :smtp
 
end

# ActionMailer::Base.smtp_settings = {
# :address  => "smtp.gmail.com",
# :port  => 25,
# :user_name  => "zhu1230@gmail.com",
# :password  => "",
# :authentication  => :login
# }

# sample usage
#   event.start_time.to_s(:event_brief)

#   February 27
Time::DATE_FORMATS[:event_list] = "%B %d"

#  Feb 27, 2009
Time::DATE_FORMATS[:short_text] = "%b月 %d日, %Y" 

#   Friday
Time::DATE_FORMATS[:event_day] = "%A"

#   February 27, 2009 at 12:04 PM
Time::DATE_FORMATS[:event_brief] = "%B %d, %Y at %I:%M %p"

#   2009-03-04 13:51:51
Time::DATE_FORMATS[:basic] = "%Y-%m-%d %H:%M %p"

TagList.delimiter = /,|;|，/

