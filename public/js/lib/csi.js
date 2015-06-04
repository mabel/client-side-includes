define(['css', 'cms'], function(loadCss, loadMd) {
  var createMenu, createPath, dataIsTrue, loadSection, queueSection, setActive, toLoad;
  toLoad = [];
  dataIsTrue = function(div, attr) {
    var ok;
    ok = $(div).data(attr);
    return ok === true || ok === 'true';
  };
  createPath = function(id) {
    return '/csi/' + id + '/main.js';
  };
  $('[data-csi]').each(function() {
    var id, path;
    id = $(this).data('csi');
    $(this).attr('id', id);
    if ($(this).is('nav') || (dataIsTrue(this, 'csi-preload'))) {
      path = createPath(id);
      return toLoad.push(path);
    }
  });
  setActive = function(anch) {
    $('.navbar-collapse li').removeClass('active');
    return $(anch).closest('.navbar-collapse > ul > li').addClass('active');
  };
  queueSection = function(id) {
    var path;
    id = id.substring(1);
    $('<section>').attr('id', id).attr('data-csi', id).appendTo($('main'));
    path = createPath(id);
    return toLoad.push(path);
  };
  createMenu = function(sect) {
    var $sect, hash;
    $sect = $(sect);
    $sect.find('[href^=#index-], [href^=#cabinet-], [href^=#admin-]').click(function() {
      var id;
      $('section[data-csi]').each(function() {
        if ($(this).not('[data-csi-preload=true]')) {
          $(this).addClass('hidden');
        }
        if ($(this).not('[data-csi-preload=true]').not('[data-csi-cached=true]')) {
          return $(this).empty();
        }
      });
      $('section.jumbotron').addClass('hidden').empty();
      id = $(this).attr('href');
      queueSection(id);
      return setActive(this);
    });
    $.material.init();
    $('#spinner-wrap').remove();
    $('main').removeClass('hidden');
    hash = window.location.hash;
    if (/^#index-|#cabinet-|^#admin-/.test(hash)) {
      return queueSection(hash);
    }
  };
  loadSection = function(path) {
    var id, index;
    index = toLoad.indexOf(path);
    toLoad.splice(index, 1);
    loadCss(path.replace(/js$/, 'css'));
    id = /(^\/csi\/)([^\/]+)(\/main\.js$)/.exec(path)[2];
    return $('#' + id).load(path.replace(/js$/, 'html?r=' + Math.random()), function() {
      loadMd(this);
      if ($(this).is('nav')) {
        createMenu(this);
      }
      return $(this).removeClass('hidden');
    });
  };
  setInterval(function() {
    return toLoad.forEach(function(path) {
      if (!require.defined(path)) {
        return require([path]);
      } else {
        return loadSection(path);
      }
    });
  }, 100);
  return function(id) {
    return toLoad.push(id);
  };
});
