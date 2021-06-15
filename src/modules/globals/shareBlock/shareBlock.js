const uri_page_to_social = jQuery('.social_buttons').data('url');
window.VK = {};
window.VK.Share = {};
window.VK.Share.count = function(index, count) {
  jQuery('.social_buttons .li_vk').css('display', 'inline-block');
  jQuery('.social_buttons .social_count.vk').text(count);
};

window.ODKL = {};
window.ODKL.updateCount = function(index, count) {
  jQuery('.social_buttons .li_ok').css('display', 'inline-block');
  jQuery('.social_buttons .social_count.ok').text(count);
};

function social_buttons_init() {
  if (jQuery('.social_buttons').length > 0) {
    jQuery('.li_fb a').click(function() {
      $(this)
        .find('.social_count')
        .text(
          parseInt(
            $(this)
              .find('.social_count')
              .text(),
          ) + 1,
        );
      window.open(
        `http://facebook.com/sharer/sharer.php?u=${uri_page_to_social}`,
        'Facebook',
        'width=640,height=300',
      );
      return false;
    });

    jQuery(document).on('click', '.li_tw a', function() {
      $(this)
        .find('.social_count')
        .text(
          parseInt(
            $(this)
              .find('.social_count')
              .text(),
          ) + 1,
        );
      window.open(
        `http://twitter.com/share?url=${uri_page_to_social}`,
        'Twitter',
        'width=640,height=300',
      );
      return false;
    });

    jQuery('.social_buttons .social_count.tw').text(
      jQuery.twitter_followers_count,
    );

    const loadScript = function(scriptUrl) {
      return jQuery.ajax({
        timeout: 1000,
        url: scriptUrl,
        dataType: 'script',
      });
    };

    const vkScriptUrl = `//vk.com/share.php?act=count&index=1&url=${uri_page_to_social}&format=json`;

    loadScript(vkScriptUrl).then(() => {
      jQuery(document).on('click', '.li_vk a', function() {
        jQuery(this)
          .find('.social_count')
          .text(
            parseInt(
              $(this)
                .find('.social_count')
                .text(),
            ) + 1,
          );
        window.open(
          `http://vk.com/share.php?url=${uri_page_to_social}`,
          'Vk.com',
          'width=640,height=300',
        );
        return false;
      });
    });

    const okScriptUrl = `//connect.ok.ru/dk?st.cmd=extLike&uid=odklcnt0&ref=${uri_page_to_social}&format=json`;

    loadScript(okScriptUrl).then(() => {
      jQuery(document).on('click', '.li_ok a', function() {
        jQuery(this)
          .find('.social_count')
          .text(
            parseInt(
              $(this)
                .find('.social_count')
                .text(),
            ) + 1,
          );
        window.open(
          `http://odnoklassniki.ru/dk?st.cmd=addShare&st.s=1&st._surl=${uri_page_to_social}`,
          'Одноклассники',
          'width=640,height=300',
        );
        return false;
      });
    });
  }
}

if (jQuery('.social_buttons').length > 0) {
  jQuery('.social_buttons').hide();
  let socialButtonsIsInited = false;
  window.addEventListener(
    'scroll',
    () => {
      if (socialButtonsIsInited === false) {
        socialButtonsIsInited = true;
        setTimeout(() => {
          jQuery.ajax({
            url: `/checkkz/?uri=${uri_page_to_social}`,
            dataType: 'json',
            async: true,
            cache: true,
            success: function(result) {
              jQuery('.social_buttons').show();
              jQuery.twitter_followers_count =
                result.data.twitter_followers_count;
              social_buttons_init();
            },
          });
        }, 2500);
      }
    },
    { once: true },
  );
}
