class AddDepartmentAndBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :department, :string
    add_index :users, :department

    add_column :users, :bio, :string

  end
end
