class TopController < ApplicationController
	def index
		@user = current_user
	end
	def show
	end
end
