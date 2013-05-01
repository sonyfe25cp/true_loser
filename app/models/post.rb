# -*- encoding: utf-8 -*-
class Post
  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :content, Text
  property :created_at, DateTime, default: Time.new

  property :username, String
  property :user_img, String


  property :status, Enum[:new, :ok, :delete], default: :new

  property :momo_count, Integer, default: 0

  has n, :comments

  has_tags_on :labels

end
