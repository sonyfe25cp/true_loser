# -*- encoding: utf-8 -*-
class PkResult
  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :result, Enum[:win, :lose]
  property :user_id, Integer

  belongs_to :pair

end
