 document.observe('dom:loaded',function(){
    $$('span.vote-up-off').each(function(t){t.observe('click',function(){
      if(t.hasClassName('disabled'))return;
      var b=t.hasClassName('vote-up-on');
      t.toggleClassName('vote-up-on');
      t.addClassName('disabled');
      var i=t.adjacent('input[type=hidden]').first().value;
      var v=parseInt(t.adjacent('span.vote-count-post').first().innerText);   
      t.adjacent('span.vote-count-post').first().innerText=(b ? v-1 : v+1);
      if(t.adjacent('div.favoritecount b').size()==0){
      new Ajax.Request('/biz/bingli_comment/voteup'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});}
      else{
      new Ajax.Request('/biz/bingli_info/voteup'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
      }
  
  })});
  $$('span.vote-down-off').each(function(t){t.observe('click',function(){
    if(t.hasClassName('disabled'))return;
      var b=t.hasClassName('vote-down-on');
      t.toggleClassName('vote-down-on');
      t.addClassName('disabled');
      var i=t.adjacent('input[type=hidden]').first().value;
      var v=parseInt(t.adjacent('span.vote-count-post').first().innerText);   
      t.adjacent('span.vote-count-post').first().innerText=(b ? v+1 : v-1);
      if(t.adjacent('div.favoritecount b').size()==0){
        new Ajax.Request('/biz/bingli_comment/votedown'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
      }else{
      new Ajax.Request('/biz/bingli_info/votedown'+'?id='+i+'&type='+b,{method: 'get',
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
      }
  
  })});
    $$('span.star-off').each(function(t){t.observe('click',function(){
      if(t.hasClassName('disabled'))return;
      var b=t.hasClassName('star-on');
      t.toggleClassName('star-on');
       t.addClassName('disabled');
       var v=parseInt(t.adjacent('div.favoritecount b').first().innerText);
       t.adjacent('div.favoritecount b').first().innerText=b ? v-1 : v+1   
      t.adjacent('div.favoritecount b').first().toggleClassName('favoritecount-selected');
      var i=t.adjacent('input[type=hidden]').first().value;
      new Ajax.Request('/biz/bingli_info/favorite'+'?id='+i+'&type='+b,{method: 'get'
      ,
      onComplete: function(r){
        t.removeClassName('disabled');
        
      }});
  
  })});
  })
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