class Invite < ActiveRecord::Base  
  
  belongs_to :user
  validates_format_of       :email,    :with => Authentication.email_regex, :message => I18n.t("activerecord.errors.messages.look_like_email")
  validates_length_of :message, :within => 3..1000, :on => :create, :too_long => I18n.t("activerecord.errors.messages.bingli_info.title.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli_info.title.too_short_content")
	@@per_page=20
  def self.generate_invite_code
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(16) { |i| newpass << chars[rand(chars.size-1)] }
    newpass
  end
  
  
  def self.accept(invite_code) 
    invite = Invite.find_by_invite_code(invite_code)
    invite.update_attributes(:accepted=>true)
  end
  
end
