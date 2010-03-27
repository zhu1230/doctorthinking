require File.dirname(__FILE__) + '/../test_helper'
require 'user_news_controller'

# Re-raise errors caught by the controller.
class UserNewsController; def rescue_action(e) raise e end; end

class UserNewsControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :user_news

  def test_should_allow_signup
    assert_difference 'UserNew.count' do
      create_user_new
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'UserNew.count' do
      create_user_new(:login => nil)
      assert assigns(:user_new).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'UserNew.count' do
      create_user_new(:password => nil)
      assert assigns(:user_new).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'UserNew.count' do
      create_user_new(:password_confirmation => nil)
      assert assigns(:user_new).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'UserNew.count' do
      create_user_new(:email => nil)
      assert assigns(:user_new).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_user_new(options = {})
      post :create, :user_new => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
