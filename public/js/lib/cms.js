define(function() {
  return function(div) {
    var after, cnt, id, mds;
    mds = $(div).find('[data-md]');
    cnt = mds.length;
    id = $(div).data('csi');
    after = function() {
      var fn, path;
      path = '/csi/' + id + '/main.js';
      fn = require(path);
      if (typeof fn === 'function') {
        return fn(div, id);
      }
    };
    if (!cnt) {
      after();
      return;
    }
    return $(mds).each(function() {
      var el, md;
      el = this;
      md = '/cms/' + $(this).data('md') + '.md?r=' + Math.random();
      return $.get(md, function(dat) {
        $(el).html(window.markdown.toHTML(dat.trim()));
        if (!--cnt) {
          return after();
        }
      });
    });
  };
});
