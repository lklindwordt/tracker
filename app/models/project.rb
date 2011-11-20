class Project < ActiveRecord::Base
  attr_accessible :url, :name

  has_many :notices

  def self.find_by_origin origin
    if origin =~ /^http:\/\/(.+)\.(.+)\//
      origin = "#{$1}.#{$2.split('/').first}"
    end
    Project.where(["url LIKE ?", "%#{origin}%"]).first
  end
end
