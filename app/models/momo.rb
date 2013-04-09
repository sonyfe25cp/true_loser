class Momo

  include DataMapper::Resource
  include DataMapper::Searcher

  property :id, Serial
  property :user_id, Integer
  property :post_id, Integer

end
