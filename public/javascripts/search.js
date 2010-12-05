function init(o){
	add_more();
}
function add_more(link) {
	var new_id=new Date().getTime();
	result=$('blank_search').clone(true).show();
	// result=link.up('ul').down('li').clone(true);
	result.down('span').update((Object.isUndefined(link) ? '选择' : link.innerText));
	result.down("input[type='hidden']").setValue((Object.isUndefined(link) ? 'and' : link.readAttribute('id')));
	result.insert({bottom:"<a href='#' onclick=\"this.up('li').remove();\" style=\"color:#F26521\">取消</a>"});
	$('search_conditions').down('ul > li#add_botton').insert({before:result.outerHTML.gsub(/bingli_info\[\d+\]/,'bingli_info['+new_id+']')});
	$('search_conditions').down('ul > li#add_botton').previous().highlight();
	// result.highlight();
}
function add_fuzhu(link){
	if(link.getValue()=='fuzhu_detail'){
		link.next('span').show().highlight();
		// b.up('li').highlight();
	}else{
		link.next('span').hide();
	}
	// THS.NExt('input'I).insert({before:})
	// $('bingli_info_0_fuzhu_type_id').clone(true).outerHTML.gsub(/bingli_info\[\
	// d+\][fuzhu_type_id]/,'bingli_info['+new_id+'][fuzhu_type_id]');
	}


