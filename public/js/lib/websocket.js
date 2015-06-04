define(function() {
  var targets;
  targets = {
    TEST: function(json) {
      if (false) {
        return alert(json.msg);
      }
    }
  };
  $.get('/json/wskey', function(dat) {
    var connection, host;
    window.WebSocket = window.WebSocket || window.MozWebSocket;
    if (!window.WebSocket) {
      alert('К сожалению, Ваш браузер не поддерживает Websocket');
      return;
    }
    host = window.location.hostname;
    connection = new WebSocket('ws://' + host + ':4011/');
    connection.onmessage = function(message) {
      var json, target;
      json = JSON.parse(message.data);
      target = json.target;
      if (target === 'wscheck') {
        connection.send(JSON.stringify({
          wskey: dat
        }));
        return;
      }
      if (typeof targets[target] !== 'function') {
        return;
      }
      return targets[target](json);
    };
    return connection.onclose = function() {
      if (confirm('Соединение с сервером прервалось. Перезагрузить страницу для восстановления?')) {
        return window.top.location.reload();
      }
    };
  });
  return targets;
});
