class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :gender, null: false
      t.string :mobile_number, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :mobile_number, unique: true
  end
end
