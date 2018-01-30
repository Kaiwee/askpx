class AnswersController < ApplicationController
	def index
	end

	def create
		# to find the question_id bcoz the route to create is /questions/:question_id/answers
		@question = Question.find(params[:question_id])
		@answer = current_user.answers.new(answer_params)
		@answer.question = @question # not understand(to insert question_id to database,but how?)
		if @answer.save
			redirect_to @question
		end
	end

	def destroy
		@answer = Answer.find(params[:id])
		@question = Question.find_by(id: @answer.question_id)
		@answer.destroy
		redirect_to @question
	end

	private
	def answer_params
		params.require(:answer).permit(:description)
	end
end
