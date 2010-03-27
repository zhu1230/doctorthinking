class AddMyApp < ActiveRecord::Migration
  def self.up
   	 create_table "attachment_miscs", :force => true do |t|
	    t.integer  "size"
	    t.string   "content_type"
	    t.string   "filename"
	    t.integer  "height"
	    t.integer  "width"
	    t.integer  "parent_id"
	    t.string   "thumbnail"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.integer  "owner_id"
	    t.string   "owner_type"
	  end

	  create_table "attachments", :force => true do |t|
	    t.string  "content_type"
	    t.string  "filename"
	    t.string  "thumbnail"
	    t.integer "size"
	    t.integer "width"
	    t.integer "height"
	    t.integer "fuzhu_detail_id"
	    t.integer "parent_id"
	  end

	  create_table "bingli_comments", :force => true do |t|
	    t.string   "title",          :limit => 45, :default => "",  :null => false
	    t.datetime "thetime",                                       :null => false
	    t.integer  "uphold",                       :default => 0,   :null => false
	    t.integer  "bingli_info_id"
	    t.integer  "user_id",                      :default => 0,   :null => false
	    t.integer  "keshi_id",                     :default => 0,   :null => false
	    t.integer  "catelog_id",                   :default => 0,   :null => false
	    t.string   "attachment_has",               :default => "0"
	    t.text     "content",                                       :null => false
	    t.integer  "denial",                       :default => 0,   :null => false
	  end

	  create_table "bingli_infos", :force => true do |t|
	    t.string   "title",                 :default => "", :null => false
	    t.datetime "thetime",                               :null => false
	    t.integer  "rank_num",              :default => 0,  :null => false
	    t.integer  "bingli_id",             :default => 0,  :null => false
	    t.integer  "keshi_id",              :default => 0,  :null => false
	    t.integer  "user_id",               :default => 0,  :null => false
	    t.integer  "catelog_id",            :default => 0,  :null => false
	    t.integer  "bingli_comments_count", :default => 0,  :null => false
	  end

	  create_table "bingli_infos_users", :force => true do |t|
	    t.integer "user_id",        :null => false
	    t.integer "bingli_info_id", :null => false
	    t.string  "desc"
	  end

	  create_table "binglis", :force => true do |t|
	    t.integer "sex",               :default => 0,     :null => false
	    t.integer "age",               :default => 0
	    t.boolean "marriage",          :default => false, :null => false
	    t.text    "yibanqingkuang",                       :null => false
	    t.text    "zhuyaozhengzhuang",                    :null => false
	    t.text    "xianbingshi",                          :null => false
	    t.text    "jiwang",                               :null => false
	    t.string  "fuzhu_has"
	    t.string  "chubu_has"
	    t.string  "yiwen_has"
	    t.text    "buchong",                              :null => false
	    t.string  "final",             :default => ""
	    t.string  "attachment_has"
	    t.string  "zhusu",             :default => "",    :null => false
	    t.text    "tigejiancha"
	    t.text    "yibanbuchong"
	    t.text    "zongbuchong"
	  end

	  create_table "catelogs", :force => true do |t|
	    t.string  "title",       :limit => 45, :default => "", :null => false
	    t.string  "information", :limit => 45
	    t.integer "parent_id",                 :default => 0,  :null => false
	    t.integer "keshi_id",                  :default => 0,  :null => false
	  end

	  create_table "chubu_details", :force => true do |t|
	    t.string  "content",   :default => "", :null => false
	    t.integer "bingli_id",                 :null => false
	  end



	  create_table "favorites", :force => true do |t|
	    t.integer "user_id",        :null => false
	    t.integer "bingli_info_id", :null => false
	  end

	  create_table "fuzhu_details", :force => true do |t|
	    t.integer "fuzhu_type_id"
	    t.string  "content",       :default => "", :null => false
	    t.integer "bingli_id",                     :null => false
	  end

	  create_table "fuzhu_pics", :force => true do |t|
	    t.string  "url",             :default => "", :null => false
	    t.integer "fuzhu_detail_id",                 :null => false
	    t.string  "pic_type",        :default => "", :null => false
	  end

	  create_table "fuzhu_types", :force => true do |t|
	    t.string  "title",     :default => "", :null => false
	    t.integer "parent_id", :default => 0,  :null => false
	  end

	  create_table "keshis", :force => true do |t|
	    t.string "title",   :limit => 45, :default => "", :null => false
	    t.string "reserve", :limit => 45, :default => "", :null => false
	  end

	  create_table "meeting_tags", :force => true do |t|
	    t.datetime "created_at"
	    t.datetime "updated_at"
	  end

	  create_table "meetings", :force => true do |t|
	    t.string   "title"
	    t.datetime "thetime"
	    t.datetime "arrange_time"
	    t.string   "content"
	    t.integer  "user_id"
	    t.string   "richeng"
	    t.string   "chuxi"
	    t.string   "zhuban"
	    t.string   "xieban"
	    t.integer  "keshi_id"
	    t.integer  "type_id"
	    t.string   "address"
	  end


	  create_table "question_details", :force => true do |t|
	    t.string  "content",   :default => "", :null => false
	    t.integer "bingli_id",                 :null => false
	  end



	  create_table "roles_users", :id => false, :force => true do |t|
	    t.integer "role_id"
	    t.integer "user_id"
	  end

	  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
	  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"


	  create_table "tags_bingli_infos", :id => false, :force => true do |t|
	    t.integer "tag_id",         :default => 0, :null => false
	    t.integer "bingli_info_id", :default => 0, :null => false
	  end



	  create_table "users_rank_bingli_comments", :force => true do |t|
	    t.integer  "user_id",                                              :null => false
	    t.integer  "bingli_comment_id",                                    :null => false
	    t.integer  "rank_tag",                                             :null => false
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.datetime "thetime",           :default => '2008-04-26 11:43:52'
	  end

	  create_table "users_rank_bingli_infos", :force => true do |t|
	    t.integer  "user_id",                                           :null => false
	    t.integer  "bingli_info_id",                                    :null => false
	    t.string   "rank_tag",       :default => "",                    :null => false
	    t.datetime "thetime",        :default => '2008-04-26 11:43:52'
	  end

  end

  def self.down
  end
end
