
var FLUSTHEFLASH = {
    delay: 3000,
    mclass: ".flashmsg",
    opacity: "0.9",
    show: function() {
        $(this.mclass).hide();
        $(this.mclass).css("opacity", this.opacity)
        $(this.mclass).fadeIn("slow").fadeTo((this.delay), 1).fadeOut("slow");
        return false;
    }
};


$(document).ready(function() {
	$('.flashmsg').livequery(function(){ 
	    FLUSTHEFLASH.show();
	});
});
