const decode = str =>
  window.decodeURIComponent(window.escape(window.atob(str)));

$(document).ready(() => {
  $('a[encode_href]').each((key, a) => {
    a = $(a);
    const s = a.attr('encode_href');
    if (s) {
      const href = decode(s);

      a.attr('href', href);

      const text = a.attr('encode_text');
      if (text) a.html(decode(text));
    }
  });
});
