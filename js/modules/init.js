define(['spinlib', 'css'], function(Spinner, loadCss) {
  var getActiveSectionId, loadSection, page, postNav, setActiveSection, spinOpts, spinner;
  spinOpts = {
    lines: 13,
    length: 20,
    width: 10,
    radius: 30,
    corners: 1,
    rotate: 0,
    direction: 1,
    color: '#000',
    speed: 1,
    trail: 60,
    shadow: false,
    hwaccel: false,
    className: 'spinner',
    zIndex: 2e9,
    top: '50%',
    left: '50%'
  };
  page = 'index';
  if (/cabinet/.test(window.top.location)) {
    page = 'cabinet';
  }
  if (/admin/.test(window.top.location)) {
    page = 'admin';
  }
  getActiveSectionId = function() {
    var hash;
    hash = window.location.hash.trim().replace(/csi-/, '');
    if (!hash || !$("" + hash).length) {
      hash = $('nav li.active a').attr('href').replace(/csi-/, '');
    }
    return hash.substring(1);
  };
  setActiveSection = function(id) {
    var $anch;
    $('nav .navbar-collapse > ul > li').removeClass('active');
    $anch = $("nav a[href=#csi-" + id + "]");
    $anch.closest('nav .navbar-collapse > ul > li').addClass('active');
    return $("#" + id).removeClass('hidden');
  };
  loadSection = function(id, after) {
    var $sect, prefix;
    prefix = "/csi/" + page + "-" + id + "/main.";
    loadCss(prefix + "css");
    if (id === 'nav') {
      $sect = $('nav');
    } else {
      $sect = $("#" + id);
    }
    if ($sect.length === 0) {
      $sect = $('<section>').attr('id', id).addClass('hidden').appendTo($('main'));
    }
    return $sect.load(prefix + "html?" + (Math.random()), function() {
      return require([prefix + "js"], function(func) {
        if (typeof func === 'function') {
          func($sect, id);
        }
        if (typeof after === 'function') {
          return after($sect, id);
        }
      });
    });
  };
  postNav = function() {
    var id;
    $.material.init();
    $(".select").dropdown({
      "autoinit": ".select"
    });
    spinner.stop();
    $('nav, main').removeClass('hidden');
    $('section').addClass('hidden').data('csi-cached', true);
    $('section[data-csi-autoload=true]').each(function() {
      var id;
      id = $(this).attr('id');
      if (id === getActiveSectionId()) {
        return;
      }
      return loadSection(id);
    });
    $('nav a[href^=#csi-]').click(function() {
      var $sect, id;
      $('section').addClass('hidden').each(function() {
        if (!$(this).data('csi-cached')) {
          return $(this).empty();
        }
      });
      id = $(this).attr('href').replace(/#csi-/, '');
      $sect = $("#" + id);
      if ($sect.data('csi-cached') && $sect.is(':not(:empty)')) {
        setActiveSection(id);
        return;
      }
      return loadSection(id, function() {
        return setActiveSection(id);
      });
    });
    id = getActiveSectionId();
    return loadSection(id, function() {
      return setActiveSection(id);
    });
  };
  spinner = new Spinner(spinOpts).spin(document.body);
  $('nav, main').addClass('hidden');
  window.cssBundles[page].forEach(function(el) {
    return loadCss(el);
  });
  loadSection("nav", postNav);
  return null;
});
