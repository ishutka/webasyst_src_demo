exports.showErrors = (form, errors) =>{
    for (var name in errors) {
        jQuery('[name=' + name + ']', form)
        .after(jQuery('<em class="errormsg"></em>').text(errors[name]))
        .addClass('error');
    }
}
exports.clear = (form, clear_inputs)  =>{
        var clear_inputs = typeof clear_inputs === 'undefined' ? true : clear_inputs;
    jQuery('.errormsg', form).remove();
    jQuery('.error', form).removeClass('error');
    jQuery('.wa-captcha-refresh', form).click();
    if (clear_inputs) {
        jQuery('input[name=captcha], textarea', form).val('');
        jQuery('input[name=rate]', form).val(0);
        jQuery('input[name=title]', form).val('');
        jQuery('.rate', form).trigger('clear');
    }
}
