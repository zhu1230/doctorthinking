class UserObserver < ActiveRecord::Observer
  
  
  # Triggered after a user signs up but before they 
  # have been activated.
  # def after_create(user)
  #   if !user.email.include?('email.com') && !user.active?
  #     UserMailer.deliver_signup_notification(user)  
  #     if !User.admins_and_creators.empty?
  #       UserMailer.deliver_new_user_signup(user)
  #     end
  #   end
  # end


  # Look for save when user has been activated
  def after_save(user)  
    if !user.email.include?('email.com')
      UserMailer.deliver_activation(user) if user.recently_activated?
      UserMailer.deliver_reset_notification(user) if user.recently_reset?  
      if !User.admins_and_creators.empty?
        UserMailer.deliver_new_user_activated(user) if user.recently_activated?
      end
    end
  end


end
