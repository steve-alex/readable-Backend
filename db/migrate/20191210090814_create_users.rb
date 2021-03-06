class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fullname
      t.boolean :fullnameviewable
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :gender
      t.string :city
      t.boolean :cityviewable
      t.string :about

      t.timestamps
    end
  end
end
