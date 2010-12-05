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

class BugReport < ActiveRecord::Base
  
  belongs_to :user
  normalize_attributes :title
  normalize_attributes :description
  validates_length_of :title, :within => 3..50, :on => :save,  :too_long => I18n.t("activerecord.errors.messages.bingli_info.title.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli_info.title.too_short_content")
  validates_length_of :description, :within => 5..2000, :on => :save,  :too_long => I18n.t("activerecord.errors.messages.bingli_info.title.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.bingli_info.title.too_short_content")
  # validates_length_of :description, :within => 3..2000, :on => :save, :message => "must be present"
  
end
