Yuetai.Views.Tags ||= {}

class Yuetai.Views.Tags.ShowView extends Yuetai.Views.Base
  el: $('#main-content')

  render: ->
    # @rm_nav()
    # @clearMsg()
    @render_nav(@opts.section)
    tag = @tags.get(@opts.tag_id)
    @$el.html(_.template($('#t-tag-show').html())(tag: tag.toJSON()))
    articles = tag.articles()
    articles.each(@renderArticle, @)

  renderArticle: (article)->
    snip = @strip(article.get('body'))
    snip = @limit(snip, 300)
    $('#tag-articles').append(_.template($('#t-tag-article').html())({
      article: article.toJSON()
      article_snip: snip
    }))
