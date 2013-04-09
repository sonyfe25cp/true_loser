# -*- encoding: utf-8 -*-
class Pair
  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :base_id, Integer
  property :pk_id, Integer

  has n, :pk_results

end

