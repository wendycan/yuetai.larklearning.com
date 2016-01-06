// <ul class="caret social-share">
//   <li><a title="分享到微信" href="#" class="bds_weixin article-share-weixin" data-share-target="wechat"></a></li>
//   <li><a title="分享到新浪微博" href="#" class="bds_tsina article-share-sinaweibo" data-share-target="sinaweibo"></a></li>
//   <li><a title="分享到QQ好友" href="#" class="bds_sqq article-share-qq" data-share-target="qq"></a></li>
//   <li><a title="分享到腾讯微博" href="#" class="bds_tqq article-share-txweibo" data-share-target="qweibo"></a></li>
//   <li><a title="分享到QQ空间" href="#" class="bds_qzone article-share-qqzone" data-share-target="qzone"></a></li>
//   <li><a title="分享到百度贴吧" href="#" class="bds_tieba article-share-tie" data-share-target="baidutieba"></a></li>
// </ul>
;
(function ($) {
  $.fn.share = function ($options) {
    var $image = $(document).find('img:first').prop('src');

    var $defaults = {
      url: window.location.href,
      site_url: window.location.origin,
      source: $(document.head).find('[name="site"]').attr('content') || $(document.head).find('[name="Site"]').attr('content') || document.title,
      title: $(document.head).find('[name="title"]').attr('content') || $(document.head).find('[name="Title"]').attr('content') || document.title,
      description: $(document.head).find('[name="description"]').attr('content') || $(document.head).find('[name="Description"]').attr('content'),
      image: $image ? $image : '',
      wechatQrcodeTitle: '微信扫一扫：分享',
      wechatQrcodeHelper: '<p>微信里点“发现”，扫一下</p><p>二维码便可将本文分享至朋友圈。</p>',
    };

    var $globals = $.extend(true, $defaults, $options);

    var $templates = {
      qzone: 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={{URL}}&title={{TITLE}}&desc={{DESCRIPTION}}&summary={{DESCRIPTION}}&site={{SOURCE}}',
      qq: 'http://connect.qq.com/widget/shareqq/index.html?url={{URL}}&title={{TITLE}}&source={{SOURCE}}&desc={{DESCRIPTION}}',
      tencent: 'http://share.v.t.qq.com/index.php?c=share&a=index&title={{TITLE}}&url={{URL}}&pic={{IMAGE}}',
      sinaweibo: 'http://service.weibo.com/share/share.php?url={{URL}}&title={{TITLE}}&pic={{IMAGE}}',
      wechat: 'javascript:;',
      douban: 'http://shuo.douban.com/!service/share?href={{URL}}&name={{TITLE}}&text={{DESCRIPTION}}&image={{IMAGE}}&starid=0&aid=0&style=11',
      diandian: 'http://www.diandian.com/share?lo={{URL}}&ti={{TITLE}}&type=link',
      linkedin: 'http://www.linkedin.com/shareArticle?mini=true&ro=true&title={{TITLE}}&url={{URL}}&summary={{DESCRIPTION}}&source={{SOURCE}}&armin=armin',
      facebook: 'https://www.facebook.com/sharer/sharer.php?u={{URL}}',
      twitter: 'https://twitter.com/intent/tweet?text={{TITLE}}&url={{URL}}&via={{SITE_URL}}',
      google: 'https://plus.google.com/share?url={{URL}}',
    };

    this.each(function () {
      var $data = $.extend({}, $globals, $(this).data() || {});
      $data.description = $data.description || $data.title;
      var $container = $(this);
      var $links = $container.find('a');
      $links.each(function () {
        var target = $(this).data('share-target');
        var url = makeUrl(target, $data);
        $(this).attr('href', url);
      });
    });

    function createWechat($container, $data) {
      var $wechat = $container.find('a.icon-wechat');

      $wechat.append('<div class="wechat-qrcode"><h4>' + $data.wechatQrcodeTitle + '</h4><div class="qrcode"></div><div class="help">' + $data.wechatQrcodeHelper + '</div></div>');
      $wechat.find('.qrcode').qrcode({
        render: 'image',
        size: 100,
        text: $data.url
      });
    }

    function makeUrl($name, $data) {
      var $template = $templates[$name];
      var $key;
      if (!$template) {
        return '';
      }

      for ($key in $data) {
        var $camelCaseKey = $name + $key.replace(/^[a-z]/, function ($str) {
          return $str.toUpperCase();
        });

        var $value = encodeURIComponent($data[$camelCaseKey] || $data[$key]);
        $template = $template.replace(new RegExp('{{' + $key.toUpperCase() + '}}', 'g'), $value);
      }

      return $template;
    }

    function runningInWeChat() {
      var ua = navigator.userAgent.toLowerCase();

      return ua.match(/MicroMessenger/i) == 'micromessenger';
    }

    function isMobileScreen() {
      return $(window).width() <= 768;
    }
  };

  $(function () {
    $('.social-share').share();
  });
})(jQuery);
