class Link < ActiveRecord::Base
	belongs_to :user
	# attr_accessible :title, :url
	acts_as_votable

	has_many :comments, :dependent => :destroy

end
