class Link < ActiveRecord::Base
	belongs_to :user
	attr_accessible :title, :url

	def link_params
    params.require(:link).permit(:title, :url)
  end

end
