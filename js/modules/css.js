define(function() {
  return function(href) {
    var i, len, link, links;
    links = document.getElementsByTagName("link");
    for (i = 0, len = links.length; i < len; i++) {
      link = links[i];
      if (href === link.getAttribute('href')) {
        return;
      }
    }
    link = document.createElement("link");
    link.setAttribute("rel", "stylesheet");
    link.setAttribute("type", "text/css");
    link.setAttribute("href", href);
    return document.getElementsByTagName("head")[0].appendChild(link);
  };
});
