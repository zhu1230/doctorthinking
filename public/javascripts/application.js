document.observe("dom:loaded", function() {

	add_outerHTML_and_innerText_for_firefox();
	add_form_ajax_loader($$('html').first());//form first register for loader image
	if(window.init)init($$('html').first());
	placeholder($$('html').first());//placeholder first register 
	message_bar();
	textCounter($$('html').first());// text count check first register


});
function later_register(form)
{
	add_form_ajax_loader(form);//form first register for loader image
	if(window.init)init(form);
	placeholder(form);//placeholder first register 
	textCounter(form);// text count check first register
}
function later_add_form_ajax_loader(form) {
	var_add_form_ajax_loader(form);
}
function later_placeholder(form) {
	form.select('[placeholder]').each(function(input){
		var_placeholder(input);
	})
}
function later_textCounter(form) {
	
}


function placeholder(o) {
	
	var PLACEHOLDER_SUFFIX = '_placeholder'; // used for password inputs

    o.select('[placeholder]').each(function (input) {
		var_placeholder(input);
    });
}
var var_placeholder=function(input){
	var label, placeholder,
        placeholder_text = input.readAttribute('placeholder');

    if (input.readAttribute('type') == 'password') {
        placeholder = input.clone();
        placeholder.type = 'text'; // not "password"
        placeholder.value = placeholder_text;
        placeholder.addClassName('placeholder');

        if (input.id) {
            // update input id and label
            placeholder.id += PLACEHOLDER_SUFFIX;
            label = $$('label[for="' + input.id + '"]')
            label.invoke('writeAttribute', 'for', input.id +
                    PLACEHOLDER_SUFFIX);
        }

        input.writeAttribute({ 'accesskey': '', 'tabindex': '' });
        input.hide().insert({ 'before': placeholder });

        // when placeholder input gains focus,
        // hide it and show "real" password input
        Event.observe(placeholder, 'focus', function () {
            this.hide();
            input.show();
            Form.Element.focus(input);
        });

        // when "real" password input loses focus,
        // if it's empty, hide it and show placeholder input
        Event.observe(input, 'blur', function () {
            if (this.value === '') {
                this.hide();
                placeholder.show();
            }
        });
    } else {
        // insert placeholder text
		var ob=input;
        if(ob.value === ''){
		ob.addClassName('placeholder');
	ob.setValue(placeholder_text);
	}else
	{
	
		ob.removeClassName('placeholder');
	}

        Event.observe(input, 'focus', function () {
            if (this.hasClassName('placeholder')) {
                this.clear().removeClassName('placeholder');
            }
        });
        Event.observe(input, 'blur', function () {
            if (this.value === '') {
                this.addClassName('placeholder').value = placeholder_text;
            }
        });
    }
}
function add_form_ajax_loader(o) {
	o.select("form:not([class='in_place_editor_form'])").each(
		function(s){
		var_add_form_ajax_loader(s);
			});
}
var var_add_form_ajax_loader=function(s){
	s.observe('submit',function(event){
		s.select("input[type='submit']").first().insert({'after':$('ajax-loader').outerHTML})
		s.select('[placeholder]').each(function(v){
	if(v.getValue()==v.readAttribute('placeholder'))v.clear();
	});
		
	});

}

function add_outerHTML_and_innerText_for_firefox() {
	if(window.HTMLElement) {
	    HTMLElement.prototype.__defineSetter__("outerHTML",function(sHTML){
	        var r=this.ownerDocument.createRange();
	        r.setStartBefore(this);
	        var df=r.createContextualFragment(sHTML);
	        this.parentNode.replaceChild(df,this);
	        return sHTML;
	        });

	    HTMLElement.prototype.__defineGetter__("outerHTML",function(){
	     var attr;
	        var attrs=this.attributes;
	        var str="<"+this.tagName.toLowerCase();
	        for(var i=0;i<attrs.length;i++){
	            attr=attrs[i];
	            if(attr.specified)
	                str+=" "+attr.name+'="'+attr.value+'"';
	            }
	        if(!this.canHaveChildren)
	            return str+">";
	        return str+">"+this.innerHTML+"</"+this.tagName.toLowerCase()+">";
	        });

	 HTMLElement.prototype.__defineGetter__("canHaveChildren",function(){
	  switch(this.tagName.toLowerCase()){
	            case "area":
	            case "base":
	         case "basefont":
	            case "col":
	            case "frame":
	            case "hr":
	            case "img":
	            case "br":
	            case "input":
	            case "isindex":
	            case "link":
	            case "meta":
	            case "param":
	            return false;
	        }
	        return true;

	     });
	}
	
	if(typeof(HTMLElement)!="undefined" && !window.opera)   
	 {   

	  HTMLElement.prototype.__defineGetter__("innerText",function () { 
	    return this.textContent;
	   }
	  ); 

	  HTMLElement.prototype.__defineSetter__("innerText",function (setValue) { 
	    this.textContent = setValue;    
	  });
	 }
	
}


// <!-- Dynamic Version by: Nannette Thacker -->
// <!-- http://www.shiningstar.net -->
// <!-- Original by :  Ronnie T. Moore -->
// <!-- Web Site:  The JavaScript Source -->
// <!-- Use one function for multiple text areas on a page -->
// <!-- Limit the number of characters per textarea -->
// <!-- Begin
var count=function(s,s1){
	var l=s.getValue().strip().length;
	var show= s1 || $(s.id+'_counter')
	if(l < s.readAttribute('minlimit'))
	{
		var left=s.readAttribute('minlimit')-l;
		show.update("最少"+s.readAttribute('minlimit')+"字符，还需"+left+"字符");
	}
	else if(l > s.readAttribute('maxlimit'))
	{
		// s.value=$(s).getValue().substr(0,s.readAttribute('maxlimit'));
		var left=s.readAttribute('maxlimit')-l;
		show.update("最多"+s.readAttribute('maxlimit')+"字符,超出了 "+left+" 个字符。");
	}
	else
	{
		var left=s.readAttribute('maxlimit')-l;
		show.update("还可输入"+left+"字符");
	}
};
// function register_textcounter_and_length_check(f){
// 	s=f.select('textarea').first();
// 	s1=f.select('div.text-counter').first();
// 	s.observe('keyup',function(){count(s,s1);});
//     s.observe('keydown',function(){count(s,s1);});
// 
// }
function textCounter(o) {
	// o.select('iframe').each(function(f){
	// 	alert(f);
	// var real=$(f.id.gsub('-editor',''));
	// alert(real.outerHTML);
	// f.writeAttribute('minlimit',real.readAttribute('minlimit'));
	// f.writeAttribute('maxlimit',real.readAttribute('maxlimit'))
	// });
	o.select('form').each(function(f){
	var_textCounter(f);
		});

// if (field.value.length > maxlimit) // if too long...trim it!
// field.value = field.value.substring(0, maxlimit);
// // otherwise, update 'characters left' counter
// else
// cntfield.value = maxlimit - field.value.length;
}
var var_textCounter=function(f){
		f.select('[minlimit]').each(function(s){
		s.observe('keyup',function(){count(s);});
	    s.observe('keydown',function(){count(s);});
			
		});
}
// helper method:
function blank_ajax_value(s){
		s.select('[placeholder]').each(function(v){
	if(v.getValue()==v.readAttribute('placeholder'))v.clear();
});
}
function check_form_length(f) {
	var b=true;
	f.select("input[minlimit]","textarea[minlimit]").each(function(s){
		if(b==false)return;
		var min=s.readAttribute('minlimit') || 0;
		var max=s.readAttribute('maxlimit') || 100000;
		var l=$F(s).trim().length;
		var div=$(s.id+'_counter');
		if(l < min || l > max)
		{
		div.setOpacity(1.0);
		Effect.Pulsate(div,{from:0,pulses: 1, duration: 0.3 });
		b= false;
		}
	
	});
	return b;
}
function iframeload(){
	// alert($('bingli_comment_content_editor').outerHTML);
	
}

