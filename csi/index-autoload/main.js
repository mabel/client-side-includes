(function() {
  define(function() {
    var firstTime;
    firstTime = true;
    return function($sect, id) {
      var firtTime, ta;
      ta = $sect.find('textarea');
      if (firstTime) {
        ta.val('This text is preloaded automaticaly\nwhether it was be active or not.');
        alert('first time');
        return firtTime = false;
      }
    };
  });

}).call(this);
