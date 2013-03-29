# -*- encoding: utf-8 -*-
class Tag

  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :content, String

  has n, :taggings
  has n, :posts, :through => :taggings

end
