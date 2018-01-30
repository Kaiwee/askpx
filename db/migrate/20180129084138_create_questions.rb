class CreateQuestions < ActiveRecord::Migration[5.1]
	def change
		create_table :questions do |t|
			t.belongs_to :user, index: true, foreign_key: true, on_delete: :cascade
			t.string :title
			t.text :description
			t.timestamps
		end
	end
end
