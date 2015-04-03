# Yuetai.Views.Blogs ||= {}

# class Yuetai.Views.Blogs.BlogView extends Backbone.View
#   el: $('#main-content')

#   (factory)->
#   if typeof define === 'function' && define.amd
#      define(['jquery'], factory)
#   else
#      factory(jQuery)  
#   ($)->
#   $.timeago:  (timestamp)->
#   if  timestamp instanceof Date
#     inWords(timestamp)
#   else if typeof timestamp === "string"
#     inWords($.timeago.parse(timestamp))
#   else if typeof timestamp === "number"
#     inWords(new Date(timestamp))
#   else
#     inWords($.timeago.datetime(timestamp))

#   string = refreshMillis: 60000,  
#       allowFuture: false,  
#       localeTitle: false,  
#       cutoff: 0,   
#       prefixAgo: null,  
#       prefixFromNow: null,  
#       suffixAgo: "前",  
#       suffixFromNow: "from now",  
#       seconds: "1分钟",  
#       minute: "1分钟",  
#       minutes: "%d分钟",  
#       hour: "1小时",  
#       hours: "%d小时",  
#       day: "1天",  
#       days: "%d天", 
#       month: "1月",  
#       months: "%d月",  
#       year: "1年",  
#       years: "%d年",  
#       wordSeparator: "",  
#       numbers: [],   
  
#     inWords: (distanceMillis)->
#       $l = this.settings.strings
#       prefix = $l.prefixAgo
#       suffix = $l.suffixAgo
#       if this.settings.allowFuture
#         if distanceMillis < 0
#           prefix = $l.prefixFromNow  
#           suffix = $l.suffixFromNow
     
#       seconds = Math.abs(distanceMillis) / 1000  
#       minutes = seconds / 60  
#       hours = minutes / 60  
#       days = hours / 24  
#       years = days / 365   
      
#     substitute: (stringOrFunction, number)->
#       string = $.isFunction(stringOrFunction) ? stringOrFunction(number, distanceMillis) : stringOrFunction  
#       value = ($l.numbers && $l.numbers[number]) || number 
#       string.replace(/%d/i, value)
#       words = seconds < 45 && substitute($l.seconds, Math.round(seconds)) ||  
#           seconds < 90 && substitute($l.minute, 1) ||  
#           minutes < 45 && substitute($l.minutes, Math.round(minutes)) ||  
#           minutes < 90 && substitute($l.hour, 1) ||  
#           hours < 24 && substitute($l.hours, Math.round(hours)) ||  
#           hours < 42 && substitute($l.day, 1) ||  
#           days < 30 && substitute($l.days, Math.round(days)) ||  
#           days < 45 && substitute($l.month, 1) ||  
#           days < 365 && substitute($l.months, Math.round(days / 30)) ||  
#           years < 1.5 && substitute($l.year, 1) ||  
#           substitute($l.years, Math.round(years))
#       separator = $l.wordSeparator || ""
#       if  $l.wordSeparator === undefined
#           separator = " "
#           $.trim([prefix, words, suffix].join(separator))
    
#     parse: (iso8601)->
#       s = $.trim(iso8601)  
#       s = s.replace(/\.\d+/,"") 
#       s = s.replace(/-/,"/").replace(/-/,"/")  
#       s = s.replace(/T/," ").replace(/Z/," UTC")  
#       s = s.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2")
#       return new Date(s)  
    
#     datetime: (elem)-> 
#       iso8601 = $t.isTime(elem) ? $(elem).attr("datetime") : $(elem).attr("title")  
#       return $t.parse(iso8601)  

#     isTime: (elem)-> 
#       # // jQuery's `is()` doesn't play well with HTML5 in IE  
#       return $(elem).get(0).tagName.toLowerCase() === "time"    
    
#     functions()->
#       init: ()->
#         refresh_el = $.proxy(refresh, this)
#         refresh_el()
#         $s = $t.settings
#         if $s.refreshMillis > 0
#           setInterval(refresh_el, $s.refreshMillis)
#       update: (time)-> 
#       $(this).data('timeago', { datetime: $t.parse(time) })  
#       updateFromDOM: ()->
#         $(this).data('timeago', { datetime: $t.parse( $t.isTime(this) ? $(this).attr("datetime") : $(this).attr("title") ) })
#         refresh.apply(this)

#     $.fn.timeago: (action, options)->
#       fn = action ? functions[action] : functions.init 
#       if !fn
#         throw new Error("Unknown function name '"+ action +"' for timeago")
 
#   refresh:()-> 
#     data = prepareData(this) 
#     $s = $t.settings  
#     if !isNaN(data.datetime) 
#       if $s.cutoff == 0 || distance(data.datetime) < $s.cutoff  
#         $(this).text(inWords(data.datetime)) 
#       	return this;  
  
#   prepareData:(element)->   
#     element = $(element);  
#     if !element.data("timeago"  
#       element.data("timeago", { datetime: $t.datetime(element) })  
#       text = $.trim(element.text())  
#       if $t.settings.localeTitle  
#         element.attr("title", element.data('timeago').datetime.toLocaleString())
#       else if (text.length > 0 && !($t.isTime(element) && element.attr("title"))) 
#         element.attr("title", text)   
#         return element.data("timeago")   
  
#   inWords: (date)->  
#     return $t.inWords(distance(date))
  
#   distance: (date)-> 
#     return (new Date().getTime() - date.getTime()) 
  
#   # // fix for IE6 suckage  
#   document.createElement("abbr") 
#   document.createElement("time")    