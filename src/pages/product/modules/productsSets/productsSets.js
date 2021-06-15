if (typeof productsets_params == 'undefined')
  window.productsets_params = new Array();

if (jQuery('.productsets-image').length) {
  let minHeight = 110;
  jQuery('.productsets-image img').each((i, e) => {
    if (jQuery(e).outerHeight() > 1 && jQuery(e).outerHeight() < minHeight)
      minHeight = jQuery(e).outerHeight();
  });
  jQuery('.productsets-image img').css('height', minHeight);
  let maxHeight = 0;
  jQuery('.productsets-name').each((i, e) => {
    if (jQuery(e).outerHeight() > maxHeight)
      maxHeight = jQuery(e).outerHeight();
  });
  jQuery('.productsets-name').css('height', maxHeight);
}
if (typeof jQuery === 'undefined')
  alert(
    'Для корректной работы плагина "Продажа комплектов" подключите библиотеку jQuery (For correct work of the plugin "Product sets with discount" use the jQuery library)',
  );
else {
  (function($) {
    $.productsets = {
      url: productsets_params.url,
      locale: productsets_params.locale,
      currency: productsets_params.currency,
      ruble: productsets_params.ruble,
      translate: function(message) {
        if (
          typeof this.messages[this.locale] !== 'undefined' &&
          this.messages[this.locale][message]
        )
          return this.messages[this.locale][message];

        return message;
      },
      dialog: {
        show: function(btn) {
          $('body')
            .children('.productsets-custom-form')
            .remove();
          btn = $(btn);
          const productSet = btn.closest('.productsets-set');
          const wrap = productSet.find('.productsets-custom-form').clone();
          wrap
            .appendTo('body')
            .show()
            .find('.productsets-body')
            .wrap(
              `<form action='about:blank' class='productsets-form s-set-${productSet.data(
                'id',
              )}' onsubmit='return false;' data-id='${productSet.data(
                'id',
              )}'></form>`,
            );
          $("<div class='productsets-total-overlay'></div>")
            .click(function() {
              $('body > .productsets-custom-form').fadeOut(function() {
                $(this).remove();
              });
              $(this).fadeOut(function() {
                $(this).remove();
              });
            })
            .appendTo('body');
          const pWrap = wrap.find('.productsets-wrap');
          pWrap.data('height', pWrap.height());
          $.productsets.autoHeight(wrap);
        },
        hide: function(btn) {
          btn = $(btn);
          btn.parents('.productsets-custom-form').fadeOut(function() {
            $(this).remove();
          });
          $('.productsets-total-overlay').fadeOut(function() {
            $(this).remove();
          });
        },
      },
      autoHeight: function(elem) {
        const productsets = elem.find('.productsets-wrap');
        const height = productsets.data('height');
        const windowHeight = $(window).height();
        if (height > windowHeight)
          productsets
            .find('.productsets-body')
            .css('height', `${windowHeight - 100}px`);
        else
          productsets
            .find('.productsets-body')
            .css('height', `${height - 100}px`);

        productsets.center();
      },
      currencyFormat: function(number, no_html) {
        let i, j, kw, kd, km;
        let decimals = $.productsets.currency.frac_digits;
        let dec_point = $.productsets.currency.decimal_point;
        let thousands_sep = $.productsets.currency.thousands_sep;
        if (isNaN((decimals = Math.abs(decimals)))) decimals = 2;

        if (dec_point == undefined) dec_point = ',';

        if (thousands_sep == undefined) thousands_sep = '.';

        i = `${parseInt((number = (+number || 0).toFixed(decimals)))}`;
        if ((j = i.length) > 3) j = j % 3;
        else j = 0;

        km = j ? i.substr(0, j) + thousands_sep : '';
        kw = i.substr(j).replace(/(\d{3})(?=\d)/g, `$1${thousands_sep}`);
        kd =
          decimals && number - i
            ? dec_point +
              Math.abs(number - i)
                .toFixed(decimals)
                .replace(/-/, 0)
                .slice(2)
            : '';
        var number = km + kw + kd;
        const s = no_html
          ? $.productsets.currency.sign
          : $.productsets.currency.sign_html;
        if (!this.currency.sign_position)
          return s + $.productsets.currency.sign_delim + number;

        return number + $.productsets.currency.sign_delim + s;
      },
      updatePrice: function(form) {
        let price = 0;
        form
          .find('.productsets-items.add-items .productsets-item')
          .each(function() {
            price += parseFloat($(this).data('price'));
          });
        form
          .find('.productsets-total span')
          .html(this.currencyFormat(price, $.productsets.ruble !== 'html'));
        return price;
      },
    };
    $(document).on('click', '.productsets-button.s-buyset', function() {
      const btn = $(this);
      const form = btn.closest('.productsets-set');
      btn
        .removeClass('s-buyset')
        .append("<i class='productsets-pl loader'></i>");
      $.post(
        $.productsets.url,
        {
          id: form.data('id'),
          product_id: form.find('.f-productsets-include').val(),
          type: 1,
        },
        response => {
          if (typeof response.errors !== 'undefined') alert(response.errors);
          else if (response.status == 'ok') {
            alert(
              $.productsets.translate(
                'You have successfully added product set to cart!',
              ),
            );
            location.reload();
          } else alert($.productsets.translate('Something wrong'));

          btn.addClass('s-buyset');
        },
        'json',
      );
    });
    $(document).on('click', '.productsets-button.userbuyset', function() {
      const btn = $(this);
      const form = btn.closest('.productsets-form');
      const skuIds = [];
      const includeProduct = form.find('.f-productsets-avail-include');
      const cancelBuying = function(btn) {
        btn
          .addClass('userbuyset')
          .find('.loader')
          .remove();
      };
      btn
        .removeClass('userbuyset')
        .append("<i class='productsets-pl loader'></i>");
      form
        .find('.productsets-items.add-items .productsets-item')
        .each(function() {
          if ($(this).attr('rel')) skuIds.push($(this).attr('rel'));
        });
      if (!includeProduct.length && !skuIds.length) {
        alert($.productsets.translate("You didn't choose any product!"));
        cancelBuying(btn);
        return false;
      }
      if (
        form.find('.empty-holder').length &&
        !confirm(
          $.productsets.translate('Set is not full. Do you want to continue?'),
        )
      ) {
        cancelBuying(btn);
        return false;
      }
      $.post(
        $.productsets.url,
        {
          id: form.data('id'),
          product_id: includeProduct.val(),
          sku_ids: skuIds,
          type: 2,
        },
        response => {
          if (typeof response.errors !== 'undefined') alert(response.errors);
          else if (response.status == 'ok') {
            alert(
              $.productsets.translate(
                'You have successfully added product set to cart!',
              ),
            );
            location.reload();
          } else alert($.productsets.translate('Something wrong'));

          cancelBuying(btn);
        },
        'json',
      );
    });
    $(document).on('click', '.productsets-move-item .f-add', function() {
      const that = $(this);
      const item = that.closest('.productsets-item');
      const form = item.closest('.productsets-form');
      const holder = form.find('.empty-holder').first();
      const clone = item.clone();
      if (holder.length) {
        clone
          .appendTo(holder.removeClass('empty-holder'))
          .find('.f-remove')
          .show()
          .prev()
          .hide();
        const setPrice = $.productsets.updatePrice(form);
        const discountBlock = form.find('.productsets-discount-price');
        if (!form.find('.empty-holder').length) {
          const discount = discountBlock.data('discount');
          const currency = discountBlock.data('currency');
          let discountPrice = 0;
          if (currency == '%') discountPrice = setPrice * (1 - discount / 100);
          else discountPrice = setPrice - discount;

          if (discountPrice < 0) discountPrice = 0;

          discountPrice = $.productsets.currencyFormat(
            discountPrice,
            $.productsets.ruble !== 'html',
          );
          discountBlock
            .css('display', 'inline-block')
            .find('span')
            .html(discountPrice);
          discountBlock.prev().css('textDecoration', 'line-through');
        } else {
          discountBlock.hide();
          discountBlock.prev().css('textDecoration', 'none');
        }
        item.hide();
      } else alert($.productsets.translate('Set is full!'));
    });
    $(document).on('click', '.productsets-move-item .f-remove', function() {
      const that = $(this);
      const item = that.closest('.productsets-item');
      const form = item.closest('.productsets-form');
      form
        .find(`.create-items .productsets-item[rel='${item.attr('rel')}']`)
        .show();
      item.parent().addClass('empty-holder');
      item.remove();
      $.productsets.updatePrice(form);
      form
        .find('.productsets-discount-price')
        .hide()
        .prev()
        .css('textDecoration', 'none');
    });
    $(window).resize(() => {
      $.productsets.autoHeight($('body > .productsets-custom-form'));
    });
  })(jQuery);
  jQuery.fn.center = function() {
    this.css('marginTop', `${-1 * Math.max(0, $(this).outerHeight() / 2)}px`);
    this.css('marginLeft', `${-1 * Math.max(0, $(this).outerWidth() / 2)}px`);
    return this;
  };
}
(function($) {
  $.productsets.messages = {
    en_US: {
      'You have successfully added product set to cart!':
        'You have successfully added product set to cart!',
      Reloading: 'Reloading',
      'Something wrong': 'Something wrong',
      "You didn't choose any product!": "You didn't choose any product!",
      'Set is not full. Do you want to continue?':
        'Set is not full. Do you want to continue?',
      'Set is full!': 'Set is full!',
    },
    ru_RU: {
      'You have successfully added product set to cart!':
        'Комплект успешно добавлен в корзину!',
      Reloading: 'Перезагрузка',
      'Something wrong': 'Произошла ошибка',
      "You didn't choose any product!": 'Вы не выбрали ни одного товара!',
      'Set is not full. Do you want to continue?':
        'Комплект не собран. Вы желаете продолжить покупку?',
      'Set is full!': 'Комплект собран!',
    },
    YOUR_LOCALE: {
      'You have successfully added product set to cart!':
        'You have successfully added product set to cart!',
      Reloading: 'Reloading',
      'Something wrong': 'Something wrong',
      "You didn't choose any product!": "You didn't choose any product!",
      'Set is not full. Do you want to continue?':
        'Set is not full. Do you want to continue?',
      'Set is full!': 'Set is full!',
    },
  };
})(jQuery);
