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