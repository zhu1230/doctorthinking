class UserMailer < ActionMailer::Base
  
  def init
    @network = Network.find(:first)
    @urls = 'http://www.doctorthinking.com/'
    @network_name = '医思网'
    @admin_email = 'zhu1230@gmail.com'
  end
  
  
  # Send the activation code to users who sign up
  def signup_notification(user)
    init
    setup_email(user)
    @subject    += '请激活您的帐户'  
    @body[:url]="#{@urls}activate/#{user.activation_code}" 
    # @body[:url]  = "#{@url}/activate/#{user.activation_code}" 
  end
  
  
  # Send a new user signup notification to the site admins
  def new_user_signup(user)
    init
    setup_admin_email(user)

    @subject    += '新用户登记'  
    @body[:url]  = "http://www.doctorthinking.com/" 

  end
  

  # Send a new user activated notification to the site admins
  def new_user_activated(user)
    init
    setup_admin_email(user)

    @subject    += '新用户激活'  
    @body[:url]  = "http://www.doctorthinking.com/" 

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

    @body[:url]  = "http://www.doctorthinking.com/" 

    @content_type = "text/html"
  end
  
  
  # Send a notification to the recipient of a message.
  def message_notification(message)
    init
    setup_email(message.recipient)
    @subject    += '消息通知'  
    @body[:message] = message

    @body[:url]  = "http://www.doctorthinking.com/" 

    @content_type = "text/html"
  end
  
 
  # Send an invitation to a non-user
  def invite_notification(invite)
    init
    @recipients  = "#{invite.email}"
    @from        = "#{invite.user.email}"

    @subject     = "#{invite.user.name} 邀请您加入医思社区"

    @sent_on     = Time.now
    @body[:invite] = invite
    @content_type = "text/html"
  end

  
  def activation(user)
    init
    setup_email(user)

    @subject    += '您的帐户已被激活!'
    @body[:url]  = "http://www.doctorthinking.com/"
  end

  def reset_notification(user)  
  setup_email(user)  
  @subject    += '请重新设置您的密码'  
  @body[:url]  = "http://www.doctorthinking.com/reset/#{user.password_reset_code}"  

  end
  
  protected
  # Setup an email that will be sent to a single user
  def setup_email(user)
    @recipients  = "#{user.email}"

    @from        = "zhu1230@gmail.com"
    @subject     = "[医思社区－－doctorthinking.com] "

    @sent_on     = Time.now
    @body[:user] = user
  end
  
  
  # Setup an email that will be sent only to site admins
  def setup_admin_email(user)
    emails = User.admins_and_creators.collect { |p| p.email } 
    @recipients  = emails.join(',')  

    @from        = "zhu1230@gmail.com"
    @subject     = "[医思社区－－doctorthinking.com] "

    @sent_on     = Time.now
    @body[:user] = user 
  end
  
  
  # Setup an email that will be sent to all users
  def setup_all_user_email
    emails = User.find(:all).collect { |p| p.email } 
    @recipients  = emails.join(',')  

    @from        = "zhu1230@gmail.com"
    @subject     = "[医思社区－－doctorthinking.com] "

    @sent_on     = Time.now
  end
  
end
