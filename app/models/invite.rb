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

class Invite < ActiveRecord::Base  
  
  belongs_to :user
  validates_format_of       :email,    :with => Authentication.email_regex, :message => I18n.t("activerecord.errors.messages.look_like_email")
  validates_length_of :message, :within => 3..1000, :on => :create, :too_long => I18n.t("activerecord.errors.messages.bingli_info.title.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli_info.title.too_short_content")
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
