var TinySou = window.TinySou || {};
TinySou.root_url = TinySou.root_url || "//api.TinySou.com";

TinySou.loadScript = function(url, callback) {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.async = true;
  script.src = url;

  var entry = document.getElementsByTagName('script')[0];
  entry.parentNode.insertBefore(script, entry);
};

TinySou.loadStylesheet = function(url) {
  var link = document.createElement('link');
  link.rel = 'stylesheet';
  link.type = 'text/css';
  link.href = url;
  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(link);
};

TinySou.loadSupportingFiles = function(callback) {
  TinySou.loadScript("http://yuetai.wendycan.org/hashchange.js", undefined);
  TinySou.loadScript("http://yuetai.wendycan.org/tinysou.js", callback);
  TinySou.loadStylesheet("http://yuetai.wendycan.org/tinysou.css");
};

TinySou.loadSupportingFiles(function(){});
