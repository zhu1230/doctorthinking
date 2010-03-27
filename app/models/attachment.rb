class Attachment < ActiveRecord::Base
   has_attachment :content_type => [:image],
                 :storage => :file_system, 
                 :min_size => 0.kilobytes,
                 :max_size => 50000.kilobytes,
                 :resize_to => '520x500>',
                 :thumbnails => {:thumb => '100x100>'},
                 :processor=>"Rmagick"

    validates_as_attachment
#      has_many :childs,
#              :class_name=>"Attachment",
#              :foreign_key => "parent_id"
def random_tempfile_filename
"#{rand Time.now.to_i}"
end

end
