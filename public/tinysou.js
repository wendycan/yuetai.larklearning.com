(function ($) {
  var queryParser = function (a) {
      var i, p, b = {};
      if (a === "") {
        return {};
      }
      for (i = 0; i < a.length; i += 1) {
        p = a[i].split('=');
        if (p.length === 2) {
          b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
        }
      }
      return b;
    };
  $.queryParams = function () {
    return queryParser(window.location.search.substr(1).split('&'));
  };
  $.hashParams = function () {
    return queryParser(window.location.hash.substr(1).split('&'));
  };


  var ident = 0;

  window.Swiftype = window.Swiftype || {};
  Swiftype.root_url = Swiftype.root_url || 'https://api.swiftype.com';
  Swiftype.pingUrl = function(endpoint, callback) {
    var to = setTimeout(callback, 350);
    var img = new Image();
    img.onload = img.onerror = function() {
      clearTimeout(to);
      callback();
    };
    img.src = endpoint;
    return false;
  };
  Swiftype.pingSearchResultClick = function (engineKey, docId, callback) {
    var params = {
      t: new Date().getTime(),
      engine_key: engineKey,
      doc_id: docId,
      q: Swiftype.currentQuery
    };
    var url = Swiftype.root_url + '/api/v1/public/analytics/pc?' + $.param(params);
    Swiftype.pingUrl(url, callback);
  };

  Swiftype.pingAutoSelection = function(engineKey, docId, value, callback) {
    var params = {
      t: new Date().getTime(),
      engine_key: engineKey,
      doc_id: docId,
      prefix: value
    };
    var url = Swiftype.root_url + '/api/v1/public/analytics/pas?' + $.param(params);
    Swiftype.pingUrl(url, callback);
  };

  Swiftype.findSelectedSection = function() {
    var sectionText = $.hashParams().sts;
    if (!sectionText) { return; }

    function normalizeText(str) {
      var out = str.replace(/\s+/g, '');
      out = out.toLowerCase();
      return out;
    }

    sectionText = normalizeText(sectionText);

    $('h1, h2, h3, h4, h5, h6').each(function(idx) {
      $this = $(this);
      if (normalizeText($this.text()).indexOf(sectionText) >= 0) {
        this.scrollIntoView(true);
        return false;
      }
    });
  };

  Swiftype.htmlEscape = Swiftype.htmlEscape || function htmlEscape(str) {
    return String(str).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  };

  $.fn.swiftypeSearch = function (options) {
    var options = $.extend({}, $.fn.swiftypeSearch.defaults, options);

    return this.each(function () {
      var $this = $(this);
      var config = $.meta ? $.extend({}, options, $this.data()) : options;

      $this.data('swiftype-config-search', config);
      $this.selectedCallback = function (data) {
        return function (e) {
          var $el = $(this);
          e.preventDefault();
          Swiftype.pingSearchResultClick(config.engineKey, data['id'], function() {
            window.location = $el.attr('href');
          });
        };
      };

      $this.selectedAtcCallback = function(data) {
        return function() {
          var value = $this.val(),
            callback = function() {
              config.onComplete(data, value);
            };
          Swiftype.pingAutoSelection(config.engineKey, data['id'], value, callback);
        };
      };

      $this.registerResult = function ($element, data) {
        $element.data('swiftype-item', data);
        $('a', $element).click($this.selectedCallback(data));
      };

      $this.registerActResult = function($element, data) {
        $element.data('swiftype-item', data);
        $element.click($this.selectedAtcCallback(data)).mouseover(function () {
          $this.listResults().removeClass(config.activeItemClass);
          $element.addClass(config.activeItemClass);
        });
      };

      $this.abortCurrent = function() {
        if ($this.currentRequest) {
          $this.currentRequest.abort();
        }
      };

      $this.showList = function() {
        if (handleFunctionParam(config.disableAutocomplete) === false) {
          $listContainer.show();
        }
      };

      $this.hideList = function(sync) {
        if (sync) {
          $listContainer.hide();
        } else {
          setTimeout(function() { $listContainer.hide(); }, 10);
        }
      };

      $this.focused = function() {
        return $this.is(':focus');
      };

      $this.submitting = function() {
        $this.submitted = true;
      };

      $this.listResults = function() {
        return $(config.resultListSelector, $list);
      };

      $this.activeResult = function() {
        return $this.listResults().filter('.' + config.activeItemClass).first();
      };

      $this.prevResult = function() {
        var list = $this.listResults(),
          currentIdx = list.index($this.activeResult()),
          nextIdx = currentIdx - 1,
          next = list.eq(nextIdx);
        $this.listResults().removeClass(config.activeItemClass);
        if (nextIdx >= 0) {
          next.addClass(config.activeItemClass);
        }
      };

      $this.nextResult = function() {
        var list = $this.listResults(),
          currentIdx = list.index($this.activeResult()),
          nextIdx = currentIdx + 1,
          next = list.eq(nextIdx);
        $this.listResults().removeClass(config.activeItemClass);
        if (nextIdx >= 0) {
          next.addClass(config.activeItemClass);
        }
      };
      $this.styleDropdown = function() {
        $listContainer.css(config.dropdownStylesFunction($this));
      };

      $(window).resize(function (event) {
        $this.styleDropdown();
      });
      $this.isEmpty = function(query) {
        return $.inArray(normalize(query), this.emptyQueries) >= 0;
      };

      $this.addEmpty = function(query) {
        $this.emptyQueries.unshift(normalize(query));
      };
      $this.getContentCache = function () {
        return $('#' + contentCacheId);
      };

      var $resultContainer;

      if (config.renderStyle == 'inline') {
        $resultContainer = $(config.resultContainingElement);
      } else if (config.renderStyle == 'new_page') {
        $resultContainer = $(config.resultContainingElement);
        var url = window.location.toString().split('#')[0];
        if (url == config.resultPageURL) {
          config.renderStyle = 'inline';
        }
      } else {
        $('body').append("<div id='st-results-container' style='display: none;'></div>");
        $resultContainer = $('#st-results-container');
      }
      var initialContentOfResultContainer = $resultContainer.html(),
        contentCacheId = 'st-content-cache',
        $contentCache = $this.getContentCache();

      var setSearchHash = function (query, page) {
          location.hash = "stq=" + encodeURIComponent(query) + "&stp=" + page;
        };

      var submitSearch = function (query, options) {
          options = $.extend({
            page: 1
          }, options);
          var params = {};

          if (!$contentCache.length) {
            $resultContainer.after("<div id='" + contentCacheId + "' style='display: none;'></div>");
            $contentCache.html(initialContentOfResultContainer).hide();
          }
          config.loadingFunction(query, $resultContainer);

          Swiftype.currentQuery = query;
          params['q'] = query;
          params['engine_key'] = config.engineKey;
          params['page'] = options.page;
          params['per_page'] = config.perPage;

          function handleFunctionParam(field) {
            if (field !== undefined) {
              var evald = field;
              if (typeof evald === 'function') {
                evald = evald.call();
              }
              return evald;
            }
            return undefined;
          }

          params['search_fields'] = handleFunctionParam(config.searchFields);
          params['fetch_fields'] = handleFunctionParam(config.fetchFields);
          params['facets'] = handleFunctionParam(config.facets);
          params['filters'] = handleFunctionParam(config.filters);
          params['document_types'] = handleFunctionParam(config.documentTypes);
          params['functional_boosts'] = handleFunctionParam(config.functionalBoosts);
          params['sort_field'] = handleFunctionParam(config.sortField);
          params['sort_direction'] = handleFunctionParam(config.sortDirection);
          params['spelling'] = handleFunctionParam(config.spelling);

          $.getJSON(Swiftype.root_url + "/api/v1/public/engines/search.json?callback=?", params).success(renderSearchResults);
        };

      $(window).hashchange(function () {
        var params = $.hashParams();
        if (params.stq) {
          submitSearch(params.stq, {
            page: params.stp
          });
        } else {
          var $contentCache = $this.getContentCache();
          if ($contentCache.length) {
            $resultContainer.html($contentCache.html());
            $contentCache.remove();
          }
        }
      });

      var $containingForm = $this.parents('form');
      if ($containingForm) {
        $containingForm.bind('submit', function (e) {
          e.preventDefault();
          var searchQuery = $this.val();
          setSearchHash(searchQuery, 1);
        });
      }

      $(document).on('click', '[data-hash][data-page]', function (e) {
        e.preventDefault();
        var $this = $(this);
        setSearchHash($.hashParams().stq, $this.data('page'));
      });

      $(document).on('click', '[data-hash][data-spelling-suggestion]', function (e) {
        e.preventDefault();
        var $this = $(this);
        setSearchHash($this.data('spelling-suggestion'), 1);
      });

      var renderSearchResults = function (data) {
        if (typeof config.preRenderFunction === 'function') {
          config.preRenderFunction.call($this, data);
        }

        config.renderResultsFunction($this.getContext(), data);

        if (typeof config.postRenderFunction === 'function') {
          config.postRenderFunction.call($this, data);
        }
      };

      $this.getContext = function () {
        return {
          config: config,
          resultContainer: $resultContainer,
          registerResult: $this.registerResult
        };
      };

      $this.getActContext = function() {
        return {
          config: config,
          list: $list,
          registerActResult: $this.registerActResult
        };
      };
      $this.attr('autocomplete', 'off');
      $this.data('swiftype-config-autocomplete', config);
      $this.submitted = false;
      $this.cache = new LRUCache(10);
      $this.emptyQueries = [];

      var styles = config.dropdownStylesFunction($this);
      var $swiftypeWidget = $('<div class="swiftype-widget" />');
      var $listContainer = $('<div />').addClass(config.suggestionListClass).appendTo($swiftypeWidget).css(styles).hide();
      $swiftypeWidget.appendTo(config.autocompleteContainingElement);
      var $list = $('<' + config.suggestionListType + ' />').appendTo($listContainer);

      $this.data('swiftype-list', $list);
      var typingDelayPointer;
      var suppressKey = false;
      $this.lastValue = '';
      //bind event listener
      $this.keyup(function (event) {
        if (suppressKey) {
          suppressKey = false;
          return;
        }

        // ignore arrow keys, shift
        if (((event.which > 36) && (event.which < 41)) || (event.which == 16)) return;

        if (config.typingDelay > 0) {
          clearTimeout(typingDelayPointer);
          typingDelayPointer = setTimeout(function () {
            processInput($this);
          }, config.typingDelay);
        } else {
          processInput($this);
        }
      });
      $this.keydown(function (event) {
        $this.styleDropdown();
        // enter = 13; up = 38; down = 40; esc = 27
        var $active = $this.activeResult();
        switch (event.which) {
        case 13:
          if (($active.length !== 0) && ($list.is(':visible'))) {
            event.preventDefault();
            $this.selectedAtcCallback($active.data('swiftype-item'))();
          } else if ($this.currentRequest) {
            $this.submitting();
          }
          $this.hideList();
          suppressKey = true;
          break;
        case 38:
          event.preventDefault();
          if ($active.length === 0) {
            $this.listResults().last().addClass(config.activeItemClass);
          } else {
            $this.prevResult();
          }
          break;
        case 40:
          event.preventDefault();
          if ($active.length === 0) {
            $this.listResults().first().addClass(config.activeItemClass);
          } else if ($active != $this.listResults().last()) {
            $this.nextResult();
          }
          break;
        case 27:
          $this.hideList();
          suppressKey = true;
          break;
        default:
          $this.submitted = false;
          break;
        }
      });

      // opera wants keypress rather than keydown to prevent the form submit
      $this.keypress(function (event) {
        if ((event.which == 13) && ($this.activeResult().length > 0)) {
          event.preventDefault();
        }
      });
      // stupid hack to get around loss of focus on mousedown
      var mouseDown = false;
      var blurWait = false;
      $(document).bind('mousedown.swiftype' + ++ident, function () {
        mouseDown = true;
      });
      $(document).bind('mouseup.swiftype' + ident, function () {
        mouseDown = false;
        if (blurWait) {
          blurWait = false;
          $this.hideList();
        }
      });
      $this.blur(function () {
        if (mouseDown) {
          blurWait = true;
        } else {
          $this.hideList();
        }
      });
      $this.focus(function () {
        setTimeout(function() { $this.select(); }, 10);
        if ($this.listResults().filter(':not(.' + config.noResultsClass + ')').length > 0) {
          $this.showList();
        }
      });
      $(window).hashchange(); // if the swiftype query hash is present onload (maybe the user is pressing the back button), submit a query onload
    });
  };

  var renderPagination = function (ctx, resultInfo) {
    var maxPagesType, maxPages = -1,
      config = ctx.config;
    $.each(resultInfo, function(documentType, typeInfo) {
      if (typeInfo.num_pages > maxPages) {
        maxPagesType = documentType;
        maxPages = typeInfo.num_pages;
      }
    });
    var currentPage = resultInfo[maxPagesType].current_page,
      totalPages = resultInfo[maxPagesType].num_pages;

    $(config.renderPaginationForType(maxPagesType, currentPage, totalPages)).appendTo(ctx.resultContainer);
  };


  var normalize = function (str) {
      return $.trim(str).toLowerCase();
    };

  function htmlEscape(str) {
    return String(str).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  }

  var callRemote = function ($this, term) {
    $this.abortCurrent();

    var params = {},
      config = $this.data('swiftype-config-autocomplete');

    params['q'] = term;
    params['engine_key'] = config.engineKey;
    params['search_fields'] = handleFunctionParam(config.searchFields);
    params['fetch_fields'] = handleFunctionParam(config.fetchFields);
    params['filters'] = handleFunctionParam(config.filters);
    params['document_types'] = handleFunctionParam(config.documentTypes);
    params['functional_boosts'] = handleFunctionParam(config.functionalBoosts);
    params['sort_field'] = handleFunctionParam(config.sortField);
    params['sort_direction'] = handleFunctionParam(config.sortDirection);
    params['per_page'] = config.resultLimit;

    var endpoint = Swiftype.root_url + '/api/v1/public/engines/suggest.json';
    $this.currentRequest = $.ajax({
      type: 'GET',
      dataType: 'jsonp',
      url: endpoint,
      data: params
    }).success(function(data) {
      var norm = normalize(term);
      if (data.record_count > 0) {
        $this.cache.put(norm, data.records);
      } else {
        $this.addEmpty(norm);
        $this.data('swiftype-list').empty();
        $this.hideList();
        return;
      }
      processData($this, data.records, term);
    });
  };

  var getResults = function($this, term) {
    var norm = normalize(term);
    if ($this.isEmpty(norm)) {
      $this.data('swiftype-list').empty();
      $this.hideList();
      return;
    }
    var cached = $this.cache.get(norm);
    if (cached) {
      processData($this, cached, term);
    } else {
      callRemote($this, term);
    }
  };
  // private helpers
  var processInput = function ($this) {
      var term = $this.val();
      if (term === $this.lastValue) {
        return;
      }
      $this.lastValue = term;
      if ($.trim(term) === '') {
        $this.data('swiftype-list').empty();
        $this.hideList();
        return;
      }
      if (typeof $this.data('swiftype-config-autocomplete').engineKey !== 'undefined') {
        getResults($this, term);
      }
    };

  var processData = function ($this, data, term) {
    var $list = $this.data('swiftype-list'),
      config = $this.data('swiftype-config-autocomplete');

    $list.empty();
    $this.hideList(true);

    config.renderActResultsFunction($this.getActContext(), data);

    var totalItems = $this.listResults().length;
    if ((totalItems > 0 && $this.focused()) || (config.noResultsMessage !== undefined)) {
      if ($this.submitted) {
        $this.submitted = false;
      } else {
        $this.showList();
      }
    }
  };

  var defaultRenderResultsFunction = function (ctx, data) {
    var $resultContainer = ctx.resultContainer,
      config = ctx.config;

    $resultContainer.html('');

    $.each(data.records, function (documentType, items) {
      $.each(items, function (idx, item) {
        ctx.registerResult($(config.renderFunction(documentType, item)).appendTo($resultContainer), item);
      });
    });

    renderPagination(ctx, data.info);
    if (!config.renderStyle) {
      $('#st-results-container').appendTo('body').modal();
    } else if (config.renderStyle == 'new_page') {
      var url = config.resultPageURL + window.location.hash;
      window.location.replace(url);
      config.renderStyle = 'inline';
      config.resultContainingElement = '#st-results-container';
    }
  };

  var defaultRenderFunction = function (document_type, item) {
      return '<div class="st-result"><h3 class="title"><a href="' + item['url'] + '" class="st-search-result-link">' + htmlEscape(item['title']) + '</a></h3></div>';
    };

  var defaultLoadingFunction = function(query, $resultContainer) {
      $resultContainer.html('<p class="st-loading-message">loading...</p>');
    };

  var defaultPostRenderFunction = function(data) {
    var totalResultCount = 0;
    var $resultContainer = this.getContext().resultContainer;
    var spellingSuggestion = null;

    if (data['info']) {
      $.each(data['info'], function(index, value) {
        totalResultCount += value['total_result_count'];
        if ( value['spelling_suggestion'] ) {
          spellingSuggestion = value['spelling_suggestion']['text'];
        }

      });
    }

    if (totalResultCount === 0) {
      $resultContainer.html("<div id='st-no-results' class='st-no-results'>No results found.</div>");
    }

    if (spellingSuggestion !== null) {
      $resultContainer.append('<div class="st-spelling-suggestion">Did you mean <a href="#" data-hash="true" data-spelling-suggestion="' + spellingSuggestion + '">' + spellingSuggestion + '</a>?</div>');
    }
  };

  var defaultRenderPaginationForType = function (type, currentPage, totalPages) {
      var pages = '<div class="st-page">',
        previousPage, nextPage;
      if (currentPage != 1) {
        previousPage = currentPage - 1;
        pages = pages + '<a href="#" class="st-prev" data-hash="true" data-page="' + previousPage + '">&laquo; previous</a>';
      }
      if (currentPage < totalPages) {
        nextPage = currentPage + 1;
        pages = pages + '<a href="#" class="st-next" data-hash="true" data-page="' + nextPage + '">next &raquo;</a>';
      }
      pages += '</div>';
      return pages;
    };

  var defaultRenderActResultsFunction = function(ctx, results) {
    var $list = ctx.list,
      config = ctx.config;

    $.each(results, function(document_type, items) {
      $.each(items, function(idx, item) {
        ctx.registerActResult($('<li>' + config.renderActFunction(document_type, item) + '</li>').appendTo($list), item);
      });
    });
  };

  var defaultRenderActFunction = function(document_type, item) {
    return '<p class="title">' + Swiftype.htmlEscape(item['title']) + '</p>';
  };

  var defaultOnComplete = function(item, prefix) {
    window.location = item['url'];
  };

  var defaultDropdownStylesFunction = function($this) {
    var config = $this.data('swiftype-config-autocomplete');
    var $attachEl = config.attachTo ? $(config.attachTo) : $this;
    var offset = $attachEl.offset();
    var styles = {
      'position': 'absolute',
      'z-index': 9999,
      'top': offset.top + $attachEl.outerHeight() + 1,
      'left': offset.left
    };
    if (config.setWidth) {
      styles['width'] = $attachEl.outerWidth() - 2;
    }
    return styles;
  };
  var handleFunctionParam = function(field) {
    if (field !== undefined) {
      var evald = field;
      if (typeof evald === 'function') {
        evald = evald.call();
      }
      return evald;
    }
    return undefined;
  };
  // simple client-side LRU Cache, based on https://github.com/rsms/js-lru

  function LRUCache(limit) {
    this.size = 0;
    this.limit = limit;
    this._keymap = {};
  }

  LRUCache.prototype.put = function (key, value) {
    var entry = {
      key: key,
      value: value
    };
    this._keymap[key] = entry;
    if (this.tail) {
      this.tail.newer = entry;
      entry.older = this.tail;
    } else {
      this.head = entry;
    }
    this.tail = entry;
    if (this.size === this.limit) {
      return this.shift();
    } else {
      this.size++;
    }
  };

  LRUCache.prototype.shift = function () {
    var entry = this.head;
    if (entry) {
      if (this.head.newer) {
        this.head = this.head.newer;
        this.head.older = undefined;
      } else {
        this.head = undefined;
      }
      entry.newer = entry.older = undefined;
      delete this._keymap[entry.key];
    }
    return entry;
  };

  LRUCache.prototype.get = function (key, returnEntry) {
    var entry = this._keymap[key];
    if (entry === undefined) return;
    if (entry === this.tail) {
      return entry.value;
    }
    if (entry.newer) {
      if (entry === this.head) this.head = entry.newer;
      entry.newer.older = entry.older;
    }
    if (entry.older) entry.older.newer = entry.newer;
    entry.newer = undefined;
    entry.older = this.tail;
    if (this.tail) this.tail.newer = entry;
    this.tail = entry;
    return returnEntry ? entry : entry.value;
  };

  LRUCache.prototype.remove = function (key) {
    var entry = this._keymap[key];
    if (!entry) return;
    delete this._keymap[entry.key];
    if (entry.newer && entry.older) {
      entry.older.newer = entry.newer;
      entry.newer.older = entry.older;
    } else if (entry.newer) {
      entry.newer.older = undefined;
      this.head = entry.newer;
    } else if (entry.older) {
      entry.older.newer = undefined;
      this.tail = entry.older;
    } else {
      this.head = this.tail = undefined;
    }

    this.size--;
    return entry.value;
  };

  LRUCache.prototype.clear = function () {
    this.head = this.tail = undefined;
    this.size = 0;
    this._keymap = {};
  };

  if (typeof Object.keys === 'function') {
    LRUCache.prototype.keys = function () {
      return Object.keys(this._keymap);
    };
  } else {
    LRUCache.prototype.keys = function () {
      var keys = [];
      for (var k in this._keymap) keys.push(k);
      return keys;
    };
  }
  $.fn.swiftypeSearch.defaults = {
    attachTo: undefined,
    documentTypes: undefined,
    facets: undefined,
    filters: undefined,
    engineKey: undefined,
    searchFields: undefined,
    functionalBoosts: undefined,
    sortField: undefined,
    sortDirection: undefined,
    fetchFields: undefined,
    renderStyle: undefined,
    resultPageURL: undefined,
    resultContainingElement: undefined,
    preRenderFunction: undefined,
    postRenderFunction: defaultPostRenderFunction,
    loadingFunction: defaultLoadingFunction,
    renderResultsFunction: defaultRenderResultsFunction,
    renderFunction: defaultRenderFunction,
    renderPaginationForType: defaultRenderPaginationForType,
    perPage: 10,
    spelling: 'strict',
    //autocomplete
    activeItemClass: 'active',
    noResultsClass: 'noResults',
    noResultsMessage: undefined,
    onComplete: defaultOnComplete,
    renderActResultsFunction: defaultRenderActResultsFunction,
    renderActFunction: defaultRenderActFunction,
    dropdownStylesFunction: defaultDropdownStylesFunction,
    resultLimit: undefined,
    suggestionListType: 'ul',
    suggestionListClass: 'autocomplete',
    resultListSelector: 'li',
    setWidth: true,
    typingDelay: 80,
    disableAutocomplete: false,
    autocompleteContainingElement: 'body'
  };
})(jQuery);
