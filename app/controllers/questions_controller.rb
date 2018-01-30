class QuestionsController < ApplicationController
	def index
		@questions = current_user.questions.all
	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers
		@answer = Answer.new
		@username = @question.user.name
		@user = User.find_by(id: current_user.id)
	end

	def new
		@question = Question.new
	end

	def edit
		@question = Question.find(params[:id])
	end

	def create
		@question = current_user.questions.new(question_params)
		if @question.save
			redirect_to @question
		else
			render "new"
		end
	end

	def update
		@question = Question.find(params[:id])
		@question.update(question_params)
		redirect_to @question
	end

	def destroy
		@question = Question.find(params[:id])
		@question.destroy
		redirect_to questions_path
	end

	private
	def question_params
		params.require(:question).permit(:title, :description)
	end

end
