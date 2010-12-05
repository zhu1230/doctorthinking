class TagsController < ApplicationController

	# before_filter :find_model
	def index
		@tags= Tag.paginate(:all,:per_page => 30,:page => params[:page],:include => [:taggings])
	end
	
	def bingli_infos
		@tags= Tag.find(:all) do 
				taggings.taggable_type =='BingliInfo'
		end
	end
	
	def bingli_comments
			@tags= Tag.find(:all) do 
					taggings.taggable_type =='BingliComment'
			end
	end
	
	def search
		@tags=Tag.find(:all,:conditions => ['name like ?',"%#{params[:search_tag]}%"])
		render @tags,:layout => false
	end
	
	private
	def find_model
		@model = Tag.find(params[:id]) if params[:id]
	end
end