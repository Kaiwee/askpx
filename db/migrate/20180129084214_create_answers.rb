class CreateAnswers < ActiveRecord::Migration[5.1]
	def change
		create_table :answers do |t|
			t.belongs_to :user, index: true, foreign_key: true
			t.belongs_to :question, index: true, foreign_key: true
			t.text :description
			t.timestamps
		end
	end
end
