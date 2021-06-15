
var defaults = {
spytarget: window,
scrolltopoffset: 0,
scrollbehavior: 'smooth',
scrollduration: 500,
highlightclass: 'selected',
enableprogress: '',
mincontentheight: 30,
};
var isiOS = /iPhone|iPad|iPod/i.test(navigator.userAgent);
function inrange(el, range, field) {
var rangespan = range[1] - range[0],
	fieldspan = field[1] - field[0];
if (range[0] - field[0] >= 0 && range[0] - field[0] < fieldspan) {
	return true;
} else {
	if (range[0] - field[0] <= 0 && range[0] + rangespan > field[0]) {
	return true;
	}
}
return false;
}

$.fn.ddscrollSpy = function(options) {
    var $window = $(window);
    var $body = window.opera
      ? document.compatMode == 'CSS1Compat' ? $('html') : $('body')
      : $('html,body');
    return this.each(function() {
      var o = $.extend({}, defaults, options);
      o.enableprogress = isiOS ? '' : o.enableprogress;
      var targets = [],
        curtarget = '';
      var cantscrollpastindex = -1;
      var $spytarget = $(o.spytarget).eq(0);
      var spyheight = $spytarget.outerHeight();
      var spyscrollheight =
        o.spytarget == window
          ? $body.get(0).scrollHeight
          : $spytarget.get(0).scrollHeight;
      var $menu = $(this);
      var totaltargetsheight = 0;
      function spyonmenuitems($menu) {
        var $menuitems = $menu.find('a[href^="#"]');
        targets = [];
        curtarget = '';
        totaltargetsheight = 0;
        $menuitems.each(function(i) {
          var $item = $(this);
          var $target = $($item.attr('href'));
          var target = $target.get(0);
          var $progress = null;
          if ($target.length == 0) return true;
          $item.off('click.goto').on('click.goto', function(e) {
            if (
              o.spytarget == window &&
              (o.scrollbehavior == 'jump' || !history.pushState)
            )
              window.location.hash = $item.attr('href');
            if (o.scrollbehavior == 'smooth' || o.scrolltopoffset != 0) {
              var $scrollparent = o.spytarget == window ? $body : $spytarget;
              var addoffset = 1;
              if (
                o.scrollbehavior == 'smooth' &&
                (history.pushState || o.spytarget != window)
              ) {
                $scrollparent.animate(
                  { scrollTop: targets[i].offsettop + addoffset },
                  o.scrollduration,
                  function() {
                    if (o.spytarget == window && history.pushState) {
                      history.pushState(null, null, $item.attr('href'));
                    }
                  },
                );
              } else {
                $scrollparent.prop(
                  'scrollTop',
                  targets[i].offsettop + addoffset,
                );
              }
              e.preventDefault();
            }
          });
          if (o.enableprogress) {
            if ($item.find('div.' + o.enableprogress).length == 0) {
              $item.css({ position: 'relative', overflow: 'hidden' });
              $(
                '<div class="' +
                  o.enableprogress +
                  '" style="position:absolute; left: -100%" />',
              ).appendTo($item);
            }
            $progress = $item.find('div.' + o.enableprogress);
          }
          var targetoffset =
            o.spytarget == window
              ? $target.offset().top
              : target.offsetParent == o.spytarget
                ? target.offsetTop
                : target.offsetTop - o.spytarget.offsetTop;
          targetoffset += o.scrolltopoffset;
          var targetheight =
            parseInt($target.data('spyrange')) > 0
              ? parseInt($target.data('spyrange'))
              : $target.outerHeight() || o.mincontentheight;
          var offsetbottom = targetoffset + targetheight;
          if (
            cantscrollpastindex == -1 &&
            offsetbottom > spyscrollheight - spyheight
          ) {
            cantscrollpastindex = i;
          }
          targets.push({
            $menuitem: $item,
            $des: $target,
            offsettop: targetoffset,
            height: targetheight,
            $progress: $progress,
            index: i,
          });
        });
        if (targets.length > 0)
          totaltargetsheight =
            targets[targets.length - 1].offsettop +
            targets[targets.length - 1].height;
      }
      function highlightitem() {
        if (targets.length == 0) return;
        var prevtarget = curtarget;
        var scrolltop = $spytarget.scrollTop();
        var cantscrollpasttarget = false;
        var shortlist = targets.filter(function(el, index) {
          return inrange(
            el,
            [el.offsettop, el.offsettop + el.height],
            [scrolltop, scrolltop + spyheight],
          );
        });
        if (shortlist.length > 0) {
          curtarget = shortlist.shift();
          if (prevtarget && prevtarget != curtarget)
            prevtarget.$menuitem.removeClass(o.highlightclass);
          if (!curtarget.$menuitem.hasClass(o.highlightclass))
            curtarget.$menuitem.addClass(o.highlightclass);
          if (
            curtarget.index >= cantscrollpastindex &&
            scrolltop >= spyscrollheight - spyheight
          ) {
            if (o.enableprogress) {
              for (var i = 0; i < targets.length; i++) {
                targets[i].$menuitem
                  .find('div.' + o.enableprogress)
                  .css('left', 0);
              }
            }
            curtarget.$menuitem.removeClass(o.highlightclass);
            curtarget = targets[targets.length - 1];
            if (!curtarget.$menuitem.hasClass(o.highlightclass))
              curtarget.$menuitem.addClass(o.highlightclass);
            return;
          }
          if (o.enableprogress) {
            var scrollpct =
              (scrolltop - curtarget.offsettop) / curtarget.height * 100;
            curtarget.$menuitem
              .find('div.' + o.enableprogress)
              .css('left', -100 + scrollpct + '%');
            for (var i = 0; i < targets.length; i++) {
              if (i < curtarget.index) {
                targets[i].$menuitem
                  .find('div.' + o.enableprogress)
                  .css('left', 0);
              } else if (i > curtarget.index) {
                targets[i].$menuitem
                  .find('div.' + o.enableprogress)
                  .css('left', '-100%');
              }
            }
          }
        } else if (scrolltop > totaltargetsheight) {
          if (o.enableprogress) {
            curtarget.$menuitem.removeClass(o.highlightclass);
            for (var i = 0; i < targets.length; i++) {
              targets[i].$menuitem
                .find('div.' + o.enableprogress)
                .css('left', 0);
            }
          }
        }
      }
      function updatetargetpos() {
        if (targets.length == 0) return;
        var $menu = targets[0].$menu;
        spyheight = $spytarget.outerHeight();
        spyscrollheight =
          o.spytarget == window
            ? $body.get(0).scrollHeight
            : $spytarget.get(0).scrollHeight;
        totaltargetsheight = 0;
        cantscrollpastindex = -1;
        for (var i = 0; i < targets.length; i++) {
          var $target = targets[i].$des;
          var target = $target.get(0);
          var targetoffset =
            o.spytarget == window
              ? $target.offset().top
              : target.offsetParent == o.spytarget
                ? target.offsetTop
                : target.offsetTop - o.spytarget.offsetTop;
          targetoffset += o.scrolltopoffset;
          targets[i].offsettop = targetoffset;
          targets[i].height =
            parseInt($target.data('spyrange')) > 0
              ? parseInt($target.data('spyrange'))
              : $target.outerHeight() || o.mincontentheight;
          if (o.enableprogress) {
            var offsetbottom = targetoffset + targets[i].height;
            if (
              cantscrollpastindex == -1 &&
              offsetbottom > spyscrollheight - spyheight
            ) {
              cantscrollpastindex = i;
            }
          }
        }
        totaltargetsheight =
          targets[targets.length - 1].offsettop +
          targets[targets.length - 1].height;
      }
      spyonmenuitems($menu);
      $menu.on('updatespy', function() {
        spyonmenuitems($menu);
        highlightitem();
      });
      $spytarget.on('scroll resize', function() {
        highlightitem();
      });
      highlightitem();
      $window.on('load resize', function() {
        updatetargetpos();
      });
    });
  }