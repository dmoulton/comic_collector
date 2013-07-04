class Issue < ActiveRecord::Base
  attr_accessible :cover_image_url, :number, :price, :title, :book_id
  belongs_to :book
end
