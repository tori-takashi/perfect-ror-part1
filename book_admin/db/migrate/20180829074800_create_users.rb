class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :admin
      t.string :boolean

      t.timestamps
    end
  end
end
