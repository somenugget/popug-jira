class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :assignee, null: true, foreign_key: { to_table: :users }
      t.string :public_id, null: false
      t.string :status
      t.integer :price
      t.string :title

      t.timestamps
    end
  end
end
