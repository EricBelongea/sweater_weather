class Users < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :api_key
      t.timestamps
    end
  end
end
