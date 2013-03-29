# -*- encoding: utf-8 -*-
class Tagging
  include DataMapper::Resource


  belongs_to :post, :key => true
  belongs_to :tag, :key => true

end

