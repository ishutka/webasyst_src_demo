export default (() => {
    jQuery(document).ready(() => {
        if (jQuery('.wa-form').length) {
            jQuery('.wa-form')
                .find('form')
                .addClass('form-horizontal');
            jQuery('.wa-field').each(function (i, e) {
                jQuery(e).addClass('form-group');
                let wa_name = jQuery(e).find('.wa-name');
                wa_name.replaceWith(
                    '<label class="control-label wa-name tr col-xs-4 col-sm-4 col-md-2 col-lg-2">' +
                    wa_name.html() +
                    '</label>',
                );
                let wa_value = jQuery(e).find('.wa-value');
                wa_value
                    .find(
                        'input[type="text"],input[type="email"],input[type="password"],select, textarea',
                    )
                    .addClass('form-control');
                wa_value
                    .find('input[type="submit"]')
                    .removeClass('form-control')
                    .addClass('btn btn-success');
                if (
                    jQuery(e).find('.wa-captcha').length ||
                    jQuery(e).find('input[type="submit"]').length
                ) {
                    wa_value.replaceWith(
                        '<div class="col-xs-8 col-sm-8 col-md-5 col-lg-5 col-xs-offset-4 col-sm-offset-4 col-md-offset-2 col-lg-offset-2 wa-value">' +
                        wa_value.html() +
                        '</div>',
                    );
                } else {
                    wa_value.replaceWith(
                        '<div class="col-xs-8 col-sm-8 col-md-5 col-lg-5 wa-value">' +
                        wa_value.html() +
                        '</div>',
                    );
                }
            });
        }
    })
})();