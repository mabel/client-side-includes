(function($) {
  $.fn.crutchLabel = function(type, text, time) {
    var ref;
    if (arguments.length < 2) {
      return;
    }
    $(this).html("<span class=\"label label-" + type + "\">" + text + "</span>");
    if (!time) {
      return;
    }
    if (time) {
      setTimeout(function() {
        return $(this).empty();
      }, (ref = time < 1000) != null ? ref : time * {
        1000: time
      });
    }
    return this;
  };
  $.fn.crutchAlert = function(type, head, body, time) {
    var $alert, alerts, j, len, obj, ref, ref1, setDiv, t;
    if (!$(this).data('alerts')) {
      obj = {};
      setDiv = function(t) {
        return obj[t] = $('<div class="alert alert-dismissable">').addClass("alert-" + t).append('<button type="button" class="close" data-dismiss="alert">×</button>').append('<h4>').append('<p>');
      };
      ref = ['warning', 'danger', 'success', 'info'];
      for (j = 0, len = ref.length; j < len; j++) {
        t = ref[j];
        setDiv(t);
      }
      $(this).data('alerts', obj);
    }
    if (!arguments || !arguments.length) {
      return;
    }
    $(this).empty();
    alerts = $(this).data('alerts');
    $alert = alerts[type];
    $alert.find('h4').text(head);
    $alert.find('p').text(body);
    $alert.appendTo(this);
    if (time) {
      setTimeout(function() {
        return $alert.remove();
      }, (ref1 = time < 1000) != null ? ref1 : time * {
        1000: time
      });
    }
    return this;
  };
  $.fn.crutchRadioSet = function(selector, options) {
    var $root, classPrefix, createRadio, dat, div, i, j, len, ref, setChecked, todo, val;
    $root = $(this);
    classPrefix = 'mdi-toggle-radio-button-';
    setChecked = function(div) {
      var val;
      val = $(div).data('radioValue');
      return $root.find('i').each(function() {
        var yo;
        yo = $(this).closest('.crutch-checkbox').data('radioValue') === val;
        $(this).removeClass(classPrefix + (yo ? 'off' : 'on')).addClass(classPrefix + (yo ? 'on' : 'off'));
        if (yo) {
          return $root.data('radioValue', val);
        }
      });
    };
    if (!options || typeof options !== 'object') {
      todo = selector;
      val = options;
      switch (todo) {
        case 'reset':
          $root.find('.crutch-checkbox i').each(function() {
            return $(this).removeClass(classPrefix + 'on').addClass(classPrefix + 'off');
          });
          $root.data('radioValue', null);
          break;
        case 'setValue':
          $root.find('.crutch-checkbox').each(function() {
            if (val === $(this).data('radioValue')) {
              return setChecked(this);
            }
          });
          return;
        case 'getValue':
          dat = $root.data('radioValue');
          return dat;
      }
      return;
    }
    createRadio = function(div, i) {
      var $bh, $i, $l, $lh, params;
      params = options[i];
      $(div).addClass('crutch-checkbox');
      $bh = $('<div>').addClass('crutch-checkbox-box').appendTo(div);
      $lh = $('<div>').addClass('crutch-checkbox-label').appendTo(div);
      $i = $('<i>').addClass(classPrefix + (params.checked ? 'on' : 'off')).appendTo($bh);
      $l = $('<label>').text(params.label).appendTo($lh);
      $(div).data('radioValue', params.value);
      return $(div).click(function() {
        setChecked(this);
      });
    };
    ref = $root.find(selector);
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      div = ref[i];
      createRadio(div, i);
    }
    return this;
  };
  return $.fn.crutchCheckbox = function(arg1, arg2) {
    var $bh, $div, $h, $lh, defaults, setChecked, settings;
    $div = $(this);
    defaults = {
      checked: false,
      checkedStyle: 'mdi-toggle-check-box',
      uncheckedStyle: 'mdi-toggle-check-box-outline-blank',
      label: '',
      checkedLabel: '',
      uncheckedLabel: ''
    };
    setChecked = function(ch) {
      var $h, $i, $l, fn, settings;
      settings = $div.data('settings');
      ch = ch === true || ch === 'true';
      $i = $div.find('i');
      $l = $div.find('label');
      $h = $div.find('input');
      $i.removeClass(settings.checkedStyle);
      $i.removeClass(settings.uncheckedStyle);
      if (ch) {
        $i.addClass(settings.checkedStyle);
        $l.text(settings.checkedLabel);
      } else {
        $i.addClass(settings.uncheckedStyle);
        $l.text(settings.uncheckedLabel);
      }
      $h.val(ch);
      $div.data('checked', ch);
      fn = $div.data('change');
      if (typeof fn === 'function') {
        return fn(ch);
      }
    };
    if (typeof arg1 === 'undefined') {
      arg1 = {};
    }
    if (typeof arg1 === 'object') {
      settings = $.extend(defaults, arg1);
      if (settings.label) {
        settings.checkedLabel = settings.label;
        settings.uncheckedLabel = settings.label;
      }
      $div.data('settings', settings);
      $div.data('checked', settings.checked);
      $div.addClass('crutch-checkbox');
      $bh = $('<div>').addClass('crutch-checkbox-box').appendTo($div);
      $lh = $('<div>').addClass('crutch-checkbox-label').appendTo($div);
      $('<i>').appendTo($bh);
      $('<label>').appendTo($lh);
      $h = $('<input type="hidden">').appendTo($div);
      if (settings.name) {
        $h.attr('name', settings.name);
      }
      $div.click(function() {
        return setChecked(!$div.data('checked'));
      });
      setChecked(settings.checked);
      if (typeof settings.change === 'function') {
        $div.data('change', settings.change);
      }
      return this;
    }
    switch (arg1) {
      case 'setChecked':
        return setChecked(arg2);
      case 'isChecked':
        return $div.data('checked');
    }
  };
})(this.jQuery);
