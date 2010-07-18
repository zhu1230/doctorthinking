#   Copyright 2009 Timothy Fisher
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

class UserMailer < ActionMailer::Base
  
  def init
    @network = Network.find(:first)
    @url = @network.url
    @network_name = @network.name
    @admin_email = @network.admin_email
  end
  
  
  # Send the activation code to users who sign up
  def signup_notification(user)
    init
    setup_email(user)
<<<<<<< HEAD
    @subject    += '请激活您的帐户'  
    @body[:url]  = "http://www.doctorthinking.com/activate/#{user.activation_code}" 

    # @body[:url]  = "#{@url}/activate/#{user.activation_code}" 

  end
  
  
  # Send a new user signup notification to the site admins
  def new_user_signup(user)
    init
    setup_admin_email(user)
<<<<<<< HEAD
    @subject    += '新用户登记'  
    @body[:url]  = "http://www.doctorthinking.com/" 
=======
    @subject    += 'New User Signup'  
    @body[:url]  = "#{@url}" 
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
  end
  

  # Send a new user activated notification to the site admins
  def new_user_activated(user)
    init
    setup_admin_email(user)
<<<<<<< HEAD
    @subject    += '新用户激活'  
    @body[:url]  = "http://www.doctorthinking.com/" 
=======
    @subject    += 'New User Activated'  
    @body[:url]  = "#{@url}" 
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
  end
  

  # Send a notice to a user who has received a friend request
  def friend_request_notification(friendship)
    init
    setup_email(friendship.friend)
    @subject += Friendship Request
    @content_type = "text/html"
  end
  
  
  # Send a notification to all users when a new announcement is posted
  def announcement_notification(announcement) 
    init
    setup_all_user_email
    @subject += announcement.title
    @body[:announcement] = announcement
    @content_type = "text/html"
  end
  
  
  # Send a notification to the owner of a wall with a new post.
  def wall_post_notification(wall_post)
    init
    setup_email(wall_post.user)
    @subject    += 'Wall Post Notification'  
<<<<<<< HEAD
    @body[:url]  = "http://www.doctorthinking.com/" 
=======
    @body[:url]  = "#{@url}" 
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
    @content_type = "text/html"
  end
  
  
  # Send a notification to the recipient of a message.
  def message_notification(message)
    init
    setup_email(message.recipient)
    @subject    += '消息通知'  
    @body[:message] = message
<<<<<<< HEAD
    @body[:url]  = "http://www.doctorthinking.com/" 
=======
    @body[:url]  = "#{@url}" 
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
    @content_type = "text/html"
  end
  
 
  # Send an invitation to a non-user
  def invite_notification(invite)
    init
    @recipients  = "#{invite.email}"
    @from        = "#{invite.user.email}"
<<<<<<< HEAD
    @subject     = "#{invite.user.name} 邀请您加入医思社区"
=======
    @subject     = "An Invitation to Join #{@network_name} "
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
    @sent_on     = Time.now
    @body[:invite] = invite
    @content_type = "text/html"
  end

  
  def activation(user)
    init
    setup_email(user)
<<<<<<< HEAD
    @subject    += '您的帐户已被激活!'
    @body[:url]  = "http://www.doctorthinking.com/"
  end

  def reset_notification(user)  
  setup_email(user)  
  @subject    += '请重新设置您的密码'  
  @body[:url]  = "http://www.doctorthinking.com/reset/#{user.password_reset_code}"  
=======
    @subject    += 'Your account has been activated!'
    @body[:url]  = "#{@url}"
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
  end
  
  protected
  # Setup an email that will be sent to a single user
  def setup_email(user)
    @recipients  = "#{user.email}"
<<<<<<< HEAD
    @from        = "zhu1230@gmail.com"
    @subject     = "[医思社区－－doctorthinking.com] "
=======
    @from        = "#{@admin_email}"
    @subject     = "[#{@network_name}] "
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
    @sent_on     = Time.now
    @body[:user] = user
  end
  
  
  # Setup an email that will be sent only to site admins
  def setup_admin_email(user)
    emails = User.admins_and_creators.collect { |p| p.email } 
    @recipients  = emails.join(',')  
<<<<<<< HEAD
    @from        = "zhu1230@gmail.com"
    @subject     = "[医思社区－－doctorthinking.com] "
=======
    @from        = "#{@admin_email}"
    @subject     = "[#{@network_name}] "
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
    @sent_on     = Time.now
    @body[:user] = user 
  end
  
  
  # Setup an email that will be sent to all users
  def setup_all_user_email
    emails = User.find(:all).collect { |p| p.email } 
    @recipients  = emails.join(',')  
<<<<<<< HEAD
    @from        = "zhu1230@gmail.com"
    @subject     = "[医思社区－－doctorthinking.com] "
=======
    @from        = "#{@admin_email}"
    @subject     = "[#{@network_name}] "
>>>>>>> ce05b8ce466d2a61476d30b6b9743fa12228499d
    @sent_on     = Time.now
  end
  
end
