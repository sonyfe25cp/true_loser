# -*- encoding: utf-8 -*-
class PkResult
  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :result, Enum[:win, :lose]

  belongs_to :pair

end
