# -*- encoding: utf-8 -*-
# 用于记录比惨的双方的胜负记录
class Pair
  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :base_id, Integer
  property :pk_id, Integer

  has n, :pk_results

end

