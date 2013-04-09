# -*- encoding: utf-8 -*-
class Comment

  include DataMapper::Resource
  include DataMapper::Searcher


  property :id, Serial
  property :content, Text
  property :created_at, DateTime, default: Time.new
  property :username, String
  property :user_id, Integer
  property :user_img, String, default: 'default-img.png'
  property :user_weibo, String

  belongs_to :post


end
