class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string, :length => 1 , :default => 'N'# (Male - M/Female - F/ Do not wish to specify - N)
  end
end
