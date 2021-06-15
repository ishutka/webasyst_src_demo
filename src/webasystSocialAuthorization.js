export default () => {
  $('div.wa-auth-adapters a').click(function() {
    const left = (screen.width - 600) / 2;
    const top = (screen.height - 500) / 2;
    window.open(
      $(this).attr('href'),
      'oauth',
      `width=600,height=500,left=${left},top=${top},status=no,toolbar=no,menubar=no`,
    );
    return false;
  });
};
