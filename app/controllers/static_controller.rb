class StaticController < ApplicationController

	def index
		@questions = Question.all
	end

	def about
	end

	def contact_us
	end

	def medical_news
		response = RestClient.get 'https://newsapi.org/v2/everything?sources=medical-news-today&apiKey=496ceca1e06d41c48e18cc3bc721f988'
		response.body
		hash = JSON.parse(response.body)
		@news = hash["articles"]
	end
end