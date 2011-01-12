function uploadSuccess(file, serverData) {
	try {

		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setComplete();
		progress.setStatus("完成.");
		progress.toggleCancel(false);
		var hidden=document.createElement("input");
		hidden.type="hidden";
		hidden.name='attach[]'
		if(serverData.length==0){
			alert(file.name);
			new Ajax.Request("/shared_resources/ie6_patch",{asynchronous:false,method:'post',parameters:{file_name:file.name},onSuccess:function(response){
				hidden.value=response.responseText;
			}});
		}else{
		hidden.value=serverData.substring(7);
		}	
		var container=document.getElementById("attachments");
		container.appendChild(hidden);
		$(file.id).down('.progressName').insert({bottom:"<span class='hO' name='^i' title='删除此文件' alt='删除此文件'><a href='#' onclick=\"del_file('"+(hidden.value)+"','"+file.id+"');return false;\">X删除</a></span>"});
	} catch (ex) {
		this.debug(ex);
	}
}
function del_file(remote_file_id,local_div_id) {
	new Ajax.Request("/shared_resources/del_attach",{method:'post',parameters:{rfid:remote_file_id,ldid:local_div_id}});
}