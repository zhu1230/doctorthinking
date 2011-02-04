require 'rack/utils'
 
class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_doctor_session')
    @app = app
    @session_key = session_key
  end
 
  def call(env)
	p "env"
	 p env
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      params = ::Rack::Request.new(env).params
	p "params"
	p params
      env['HTTP_COOKIE'] = [ @session_key, params[@session_key] ].join('=').freeze unless params[@session_key].nil?
    end
    @app.call(env)
  end
end