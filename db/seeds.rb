#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Node.create([{name: 'music'},{name: 'life'},{name: 'others'},{name: 'book'}])
Author.create([{name: 'wendywang'},{name: 'spacevisitor'},{name: 'unknow'}])
Article.create([{name: "似水年华",uauthor: 'spacevisitor',utag: 'life', body: "<br/> 年华似水，每个人在这时光的灌溉下，懂得了些道理，形成了些习惯，收获了些快乐。某个时刻，我忽然又认识到，似水年华不经意地流走了二十几年，而最初梦想的种子还未破土而出，懒惰、无耐力的顽疾依然消磨着忙碌的身心。而这似水年华不仅是我的，也是你的，还是他的，每个人都在这时光的浪潮里航行着。浪淘沙，会发现什么，留下什么。
      <br/> 即使在这似水年华中，个人渺小如浪潮中的一粒沙子，我们也可以发现更精彩的世界和自己，用生命刻下一些痕迹。
      <br/> 在这里，我们记下些思绪，分享些知识。", music_script: "<embed src='http://www.xiami.com/widget/13261581_20526/singlePlayer.swf' type='application/x-shockwave-flash' width='257' height='33' wmode='transparent'></embed>
      "}])
