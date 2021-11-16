class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE user_roles AS ENUM ('admin', 'manager', 'popug');
    SQL

    add_column :users, :role, :user_roles, null: false, default: 'popug'
  end

  def down
    remove_column :users, :role

    execute <<-SQL
      DROP TYPE user_roles;
    SQL
  end
end
