document.observe("dom:loaded", function() {
	add_outerHTML_and_innerText_for_firefox();
	if(window.init)init();
	message_bar();
});
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
