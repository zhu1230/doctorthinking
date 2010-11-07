$(function() {
    if (!("placeholder" in document.createElement('input'))) {
        $(':input[placeholder]').each(function() {
            var me = $(this);
            me.addClass('placeholder').val(me.attr('placeholder')).focus(function() {
                var that = $(this);
                if (that.val() == that.attr('placeholder')) {
                    that.val('').removeClass('placeholder');
                }
            }).blur(function() {
                var that = $(this);
                if ($.trim(that.val()).length === 0) {
                    that.val(that.attr('placeholder')).addClass('placeholder');
                }
            });
        });
    }
});
function add_new_fuzhu(){
		var size=$('fuzhu_scope').childElements().size();
		var div=new Element('div',{'id':'fuzhu_'+size});
        div.addClassName('fuzhu');
		$('fuzhu_scope').insert({bottom:div.update($('fuzhu_blank').innerHTML.gsub(/fuzhu_details_attributes\]\[\d+\]/,'fuzhu_details_attributes]['+size+']'))});
		new Effect.Highlight(div);
}
function add_new_chubu() {
	var size=$('chubu').childElements().size();
	var div=new Element('div',{'id':'chubu_'+size,style:'display:block;'})
	$('chubu').insert({bottom:div.update($('chubu_blank').innerHTML.gsub(/chubu_details_attributes\]\[\d+\]/,'chubu_details_attributes]['+size+']'))});
	new Effect.Highlight(div);
}