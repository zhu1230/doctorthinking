class Bingli < ActiveRecord::Base
  acts_as_commentable
  has_one :bingli_info,:autosave=>true
  has_many :chubu_details#,:conditions=>"chubu_has is not null" 
  has_many :fuzhu_details#,:conditions=>"fuzhu_has is not null"
  has_many :question_details#,:conditions=>"yiwen_has is not null"
  has_many :attachments
  belongs_to :user
  validates_presence_of :bingli_info
  validates_associated :bingli_info
  validates_presence_of :zhusu
  acts_as_ferret :fields => [:zhusu, :yibanqingkuang,:zhuyaozhengzhuang,:xianbingshi,:tigejiancha,:jiwang,:final]
	def keshi_id
		self.bingli_info.keshi.id
	end
	def after_validation

	    # Skip errors that won't be useful to the end user
	    filtered_errors = self.errors.reject{ |err| %{ bingli_info }.include?(err.first) }
	    # recollect the field names and retitlize them
	    # this was I won't be getting 'user.person.first_name' and instead I'll get
	    # 'First name'
	    filtered_errors.collect{ |err|
	      if err[0] =~ /(.+\.)?(.+)$/
	        err[0] = $2
	      end
	      err
	    }

	    # reset the errors collection and repopulate it with the filtered errors.
	    self.errors.clear
	    filtered_errors.each { |err| self.errors.add(*err) }

	  end
#  validates_
end
