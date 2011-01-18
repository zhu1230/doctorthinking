function init(o) {
	o.select('form').each(function(f){
		f.observe('submit',function(event){
				f.down("input[type='submit']").disable();
			f.request({method:'post',onSuccess:function(){
				// f.reset();
			},onComplete:function(){
				f.down('#ajax-loader').remove();
				f.down("input[type='submit']").enable();
			}});
			
			event.stop();
		});
	});
	
}