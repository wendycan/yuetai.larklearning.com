Yuetai.Views.Site ||= {}

class Yuetai.Views.Site.IndexView extends Yuetai.Views.Base
  el: $('#main-content')

  events:
    "click #last-articles" : "showArticles"
    "click #last-excerpts" : "showExcerpts"
    "click #all-tags" : "showTags"

  render: ->
    # @rm_nav()
    # @clearMsg()
    @$el.html(_.template($('#t-index').html())())
    @articles.each(@renderArticle, @)

  showArticles: ->
    @clearAll()
    @articles.each(@renderArticle, @)

  showExcerpts: ->
    @clearAll()
    @excerpts.each(@renderExcerpt, @)

  showTags: ->
    @clearAll()
    @tags.each(@renderTag, @)

  renderExcerpt: (excerpt)->
    book = @books.get(excerpt.get('book_id'))
    author = @authors.get(excerpt.get('author_id'))
    $('#items').append(_.template($('#t-excerpt-item').html())(
      {
        excerpt: excerpt.toJSON()
        book: book.toJSON()
        author: author.toJSON()
      }
    ))

  renderTag: (tag)->
    $('#tag-items').append(_.template($('#t-tag-item').html())(
      {
        tag: tag.toJSON()
      }
    ))


  renderArticle: (article)->
    snip = @strip(article.get('body'))
    snip = @limit(snip, 300)
    author = @authors.get(article.get('author_id'))
    $('#items').append(_.template($('#t-article-item').html())(
      {
        article: article.toJSON()
        article_snip: snip
        author: author.toJSON()
      }
    ))

  clearAll: ->
    $('#items').empty()
    $('#tag-items').empty()
