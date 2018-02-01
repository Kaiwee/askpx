class QuestionsController < ApplicationController

	before_action :find_question, only: [:show, :edit, :update]
	before_action :check_current_question, only: [:edit, :update]

	def index
		@questions = current_user.questions.all.order("created_at DESC")
	end

	def show
		@answers = @question.answers.order("created_at DESC")
		@answer = Answer.new
		@user_answers = @question.answers.order("created_at DESC")
	end

	def new
		@question = Question.new
	end

	def edit
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

	def find_question
		if @question = Question.find_by(id: params[:id])
			return @question
		else
			redirect_to '/', notice: "Question does not exists"
		end	
	end

	def check_current_question
		@user = User.find_by(id: @question.user_id)
		if logged_in? and current_user.id != @user.id
			redirect_to "/", notice: "This is not your question"
		elsif !logged_in?
			redirect_to "/", notice: "You need to log in first"
		end
	end

	def question_params
		params.require(:question).permit(:title, :description)
	end

end
