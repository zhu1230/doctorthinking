 function init(o){
    o.select('span.vote-up-off').each(function(t){t.observe('click',function(){
      if(t.hasClassName('disabled'))return;
      var b=t.hasClassName('vote-up-on');
      t.toggleClassName('vote-up-on');
      t.addClassName('disabled');
      var i=t.adjacent('input[type=hidden]').first().getValue();
      var v=parseInt(t.adjacent('span.vote-count-post').first().innerText);   
      t.adjacent('span.vote-count-post').first().innerText=(b ? v-1 : v+1);
      if(t.adjacent('div.favoritecount b').size()==0){
      new Ajax.Request('/biz/bingli_comments/'+i+'/voteup'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});}
      else{
      new Ajax.Request('/biz/bingli_infos/'+i+'/voteup'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
      }
  
  })});
  o.select('span.vote-down-off').each(function(t){t.observe('click',function(){
    if(t.hasClassName('disabled'))return;
      var b=t.hasClassName('vote-down-on');
      t.toggleClassName('vote-down-on');
      t.addClassName('disabled');
      var i=t.adjacent('input[type=hidden]').first().getValue();
      var v=parseInt(t.adjacent('span.vote-count-post').first().innerText);   
      t.adjacent('span.vote-count-post').first().innerText=(b ? v+1 : v-1);
      if(t.adjacent('div.favoritecount b').size()==0){
        new Ajax.Request('/biz/bingli_comments/'+i+'/votedown'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
      }else{
      new Ajax.Request('/biz/bingli_infos/'+i+'/votedown'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
      }
  
  })});
	o.select("a[id^='comments-link-']").each (
		function(s) { add_comment(s);
	});

	o.select("form[id^='add-comment-']").each(
		function(s){
			 comment_submit(s);
		});
	o.select("form[id^='edit-comment-']").each(
		function(f){
				 comment_submit(f,'put');
	});
	// o.select('#bingli_comment_form').each(function(f){
	// 	f.observe('submit',function(event){
	// 		// alert(f.select);
	// 	// blank_ajax_value(f);
	// 	// if(!check_form_length(f))
	// 	// 	{
	// 	// 		event.stop();
	// 	// 		f.select('img#ajax-loader').first().remove();
	// 	// 		return;
	// 	// 	}
	// 		f.select("input[type='submit']").first().disable();
	// 	f.request({method:'post',
	// 	onComplete:function(r){
	// 	 later_register($$("li[id^='bingli_comment_']").last());
	// 	f.select('img#ajax-loader').first().remove();
	// 	f.select("input[type='submit']").first().enable();
	// 	}
	// 	});
	// 	event.stop();
	// })});
    o.select('span.star-off').each(function(t){t.observe('click',function(){
      if(t.hasClassName('disabled'))return;
      var b=t.hasClassName('star-on');
      t.toggleClassName('star-on');
       t.addClassName('disabled');
       var v=parseInt(t.adjacent('div.favoritecount b').first().innerText);
       t.adjacent('div.favoritecount b').first().innerText= (b ? v-1 : v+1)   
      t.adjacent('div.favoritecount').first().toggleClassName('favoritecount-selected');
      var i=t.adjacent('input[type=hidden]').first().getValue();
      new Ajax.Request('/biz/bingli_infos/'+i+'/favorite'+'?type='+b,{method: 'get'
      ,
      onComplete: function(r){
        t.removeClassName('disabled');
      }});
  
  })});
  }
function favoriteback(i){
  
  var t=$('favorite_'+i).select('b').first();
  var b=$('favorite_'+i).hasClassName('star-on');
  var v=parseInt(t.innerText);
  t.innerText=b ? v+1 : v-1
  t.ancestors().first().adjacent('span.star-off').first().toggleClassName('star-on');
  t.toggleClassName('favoritecount-selected');
}
function voteupback(i){
  var t=$(i).select('span.vote-up-off').first();
  var b=t.hasClassName('vote-up-on');
  var c=t.adjacent('span.vote-count-post').first();
  var v=parseInt(c.innerText);
  c.innerText=b ? v-1 : v+1
  t.toggleClassName('vote-up-on');
}
function votedownback(i){
  var t=$(i).select('span.vote-down-off').first();
  var b=t.hasClassName('vote-down-on');
  var c=t.adjacent('span.vote-count-post').first();
  var v=parseInt(c.innerText);
  c.innerText=b ? v+1 : v-1
  t.toggleClassName('vote-down-on');
}
var add_comment=function(s){s.observe('click',function(){
	var id=s.id.substr('comments-link-'.length);
	var f=$('add-comment-'+id);
	f.insert($('comment-form').innerHTML.gsub('comment-form-error','comment-form-error-'+id).gsub('comment_counter','comment_'+id+"_counter").gsub('comment_id','comment_'+id));
	s.hide();
	//for later event register
	placeholder(f);//placeholder first register 
	var_textCounter(f);// text count check first register
});
}
var comment_submit=function(s,m){
	s.observe('submit',function(event){
		if(!check_form_length(s)){
			event.stop();
			s.select('img#ajax-loader').first().remove();
			return;
		}
		// new comment id is parent's(such as : bingli_info,bingli_comment)
		//edit comment id is comment's
		var v=s.select("textarea[id^='comment_']").first().getValue().trim();
		var id=m=='put' ? s.id.substr('edit-comment-'.length) : s.id.substr('add-comment-'.length);
		if (m=='put'){
			comments_id=s.up("[id^='comments-']").id;
			if(comments_id.indexOf('bingli')==-1){
											true_id=comments_id.substr('comments-'.length);
									s.writeAttribute('action', '/biz/bingli_comments/'+true_id+'/comments/'+id);
										}else{
											true_id=comments_id.substr('comments-bingli-'.length);
											s.writeAttribute('action', '/biz/bingli_infos/'+true_id+'/comments/'+id);
										}		
		}else{
		if(id.indexOf('bingli')==-1){
								s.writeAttribute('action', '/biz/bingli_comments/'+id+'/comments');
									}else{
										true_id=id.split('-')[1];
										s.writeAttribute('action', '/biz/bingli_infos/'+true_id+'/comments');
									}
								}
	s.select("input[type='submit']").first().disable();
	s.request({method:'post',parameters:{authenticity_token:fkey,_method:m},
	onComplete:function(r){
	s.select("img#ajax-loader").first().remove();
	s.select("input[type='submit']").first().enable();
	}
	});
	event.stop();
	})
}
function edit_comment(id)
{
	// alert($('comment-form').clone(true).innerHTML);
	$('edit-comment-'+id).insert( { bottom :$('comment-form').innerHTML.gsub('comment-form-error','comment-form-error-'+id).gsub('comment_counter','comment_'+id+"_counter").gsub('comment_id','comment_'+id) } );
	// alert($('edit-comment-'+id).outerHTML);
	var edit_form=$('edit-comment-'+id);
	placeholder(edit_form);//placeholder first register 
	var_textCounter(edit_form);// text count check first register
	// var edit_form=$('comment-form').clone().writeAttribute('id','edit-comment-'+id);
	// alert(edit_form.outerHTML);
	// alert($('edit-comment-'+id).outerHTML);
	// comment_id=id.gsub('bingli-','');
	// alert(comment_id);
	edit_form.select("input[type='submit']").first().insert({after:"<a class='edit-comment-cancel'>取消</a>"});
	edit_form.select('textarea').first().setValue(edit_form.select('div.dno').first().innerText);
	$('comment-'+id).select('.comment-text').first().addClassName('comment-form');
	edit_form.setStyle('display: block;');
	$('comment-'+id).select('td.comment-text > div').first().hide();
	
	edit_form.select('.edit-comment-cancel').first().observe('click',function(){
	edit_form.hide();
	edit_form.select('table').first().remove();
	$('comment-'+id).select('.comment-text').first().removeClassName('comment-form');
	$('comment-'+id).select('td.comment-text > div').first().show();
	});
	
}

