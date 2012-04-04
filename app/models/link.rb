class Link < ActiveRecord::Base
  
  belongs_to :affiliate
  has_many :clicks
  
end
