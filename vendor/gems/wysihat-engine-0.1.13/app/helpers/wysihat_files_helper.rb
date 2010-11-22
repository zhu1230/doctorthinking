module WysihatFilesHelper
  def include_link(file)    
    function = file.file_content_type.starts_with?('image') ?
 ".insertHTML('<a href='+this.href+' rel=\\\"lytebox[0]\\\" toptions=\\\"effect=transform,group=7,layout=quicklook,shaded=1\\\" ><img src=\\\'#{file.file.url(:thumb)}\\\'></a>');" :
      # ".insertImage(this.href);" :
    ".insertHTML('<a href=\"' + this.href + '\">#{file.file_file_name}</a>');"
   # ".insertHTML('<a href='+this.href+' rel=\\\"lytebox[0]\\\" toptions=\\\"effect=transform,group=7,layout=quicklook,shaded=1\\\" ><img src=\\\'#{file.file.url(:thumb)}\\\'></a>');"
          
    link_to_function(
      file.file_file_name,
		# file.furl(:thumb),
      "$$('iframe##{editor_id}')[0]#{function}facebox.close();",
      :href => file.file.url
    )
  end
  
  def editor_id
    return params[:wysihat_file][:editor] if params[:wysihat_file] && params[:wysihat_file][:editor]
    params[:editor]
  end
end
