class QuestionDetail < ActiveRecord::Base
	attr_accessor :new_by_build
	@new_by_build=false;
	def new_by_build?
		@new_by_build || false
	end
end
