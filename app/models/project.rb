class Project < ActiveRecord::Base  
  attr_accessible :url, :name
  
  has_many :notices
end
