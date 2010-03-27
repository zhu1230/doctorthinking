class AttachmentMisc < ActiveRecord::Base
  has_attachment :storage => :file_system, #:content_type => [:image],
                :min_size => 0.kilobytes,
                :max_size => 100000.kilobytes,
             #   :resize_to => '520x500>',
             #   :thumbnails => {:thumb => '100x100>'},
                :processor=>"Rmagick"
end
