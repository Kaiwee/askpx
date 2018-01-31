class QuestionsController < ApplicationController
	def index
		@questions = current_user.questions.all.order("created_at DESC")
	end

	def show
		@question = Question.find(params[:id])
		@answers = @question.answers.order("created_at DESC")
		@answer = Answer.new
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
		respond_to do |format|
			format.html { redirect_to questions_path }
			format.js
		end
	end

	private
	def question_params
		params.require(:question).permit(:title, :description)
	end

end
