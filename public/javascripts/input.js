function init(o){
	// alert("ddd");

}
function add_new_fuzhu(){
	
		var new_id=new Date().getTime();
		var div=new Element('div',{'id':'fuzhu_'+new_id});
        div.addClassName('fuzhu');
		$('fuzhu_scope').insert({bottom:div.update($('fuzhu_blank').innerHTML.gsub(/fuzhu_details_attributes\]\[\d+\]/,'fuzhu_details_attributes]['+new_id+']'))});
		new Effect.Highlight(div);
}
function add_new_chubu() {
	var new_id=new Date().getTime();
	var div=new Element('div',{'id':'chubu_'+new_id,style:'display:block;'});
	$('chubu').insert({bottom:div.update($('chubu_blank').innerHTML.gsub(/chubu_details_attributes\]\[\d+\]/,'chubu_details_attributes]['+new_id+']'))});
	new Effect.Highlight(div);
}
function add_new_question() {
	var new_id=new Date().getTime();
	var div=new Element('div',{'id':'yiwen_'+new_id,style:'display:block;'});
	$('yiwen').insert({bottom:div.update($('yiwen_blank').innerHTML.gsub(/question_details_attributes\]\[\d+\]/,'question_details_attributes]['+new_id+']'))});
	new Effect.Highlight(div);
}
function add_new_file(fuzhu) {
	var new_id=new Date().getTime();
	var div=new Element('div',{'id':'upload_file_'+new_id,style:'display:block;','class':'upload_file'});
	fuzhu.down('#file_upload_scope').insert({bottom:div.update(fuzhu.down('#upload_file_blank').innerHTML.gsub(/attachments_attributes\]\[\d+\]/,'attachments_attributes]['+new Date().getTime()+']'))});
	new Effect.Highlight(div);
}
function add_new_bingcheng() {
	
}

