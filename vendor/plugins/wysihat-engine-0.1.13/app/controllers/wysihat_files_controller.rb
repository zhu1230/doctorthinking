class WysihatFilesController < ApplicationController
  def index
    @wysihat_file, @wysihat_files = WysihatFile.new, current_user.wysihat_files.recent(1)
    render :layout => false
  end

  def create
    @wysihat_file = WysihatFile.new(:file => params[:wysihat_file][:file])
	@wysihat_file.user=current_user
    responds_to_parent do
      render :update do |page|
        if(@wysihat_file.save)
          page.insert_html :bottom, :wysihat_files, :partial => 'wysihat_file', :object => @wysihat_file
		  page << "$('new_wysihat_file').reset();"
			page << "$('new_wysihat_file').down('#ajax-loader').remove();"
        end
      end
    end
  end

  def destroy
    @wysihat_file = current_user.wysihat_files.find(params[:id])
    respond_to do |wants|
      wants.js {
        render :update do |page|
          page.remove "wysihat_file_#{@wysihat_file.id}"
        end
      }
    end
    @wysihat_file.destroy
  end
end
