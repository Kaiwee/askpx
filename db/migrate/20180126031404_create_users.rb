class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|	
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.text :intro
      t.string :city
      t.string :state
      t.string :country
      t.integer :verification, default: 0
      t.string :role
      t.json :avatar
      t.json :documents

      t.timestamps null: false
    end
  end
end
