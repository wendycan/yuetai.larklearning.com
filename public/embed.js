var TinySou = window.TinySou || {};
TinySou.root_url = TinySou.root_url || "//api.TinySou.com";

TinySou.loadScript = function(url, callback) {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.async = true;
  script.src = url;

  var entry = document.getElementsByTagName('script')[0];
  entry.parentNode.insertBefore(script, entry);

  script.addEventListener('load', callback, false);
};

TinySou.loadStylesheet = function(url) {
  var link = document.createElement('link');
  link.rel = 'stylesheet';
  link.type = 'text/css';
  link.href = url;
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(link);
};

TinySou.loadSupportingFiles = function() {
  TinySou.loadScript("http://localhost:3000/hogan-3.0.1.js");
  TinySou.loadScript("http://localhost:3000/hashchange.js");
  TinySou.loadScript("http://localhost:3000/tinysou.js");
  TinySou.loadScript("http://localhost:3000/jquery.modal.js");
  TinySou.loadStylesheet("http://localhost:3000/tinysou.css");
  };

TinySou.loadSupportingFiles(function(){});
