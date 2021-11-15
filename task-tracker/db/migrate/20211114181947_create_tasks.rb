class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :public_id, null: false
      t.references :assignee, null: true, foreign_key: { to_table: :users }
      t.string :status
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
