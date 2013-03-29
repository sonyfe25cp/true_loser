# -*- encoding: utf-8 -*-
class Post
  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :content, Text
  property :created_at, DateTime, default: Time.new

  property :status, Enum[:new, :ok, :delete], default: :new

  has n, :comments
  has n, :taggings
  has n, :tags, :through => :taggings


end
