class PagesController < ApplicationController
	def home
	end

	def menu
	end

	def beans
	end

	def blog
		@posts = Post.all.order(id: :desc).page params[:page]
	end
end
