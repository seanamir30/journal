class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :category_id
      t.datetime :due_date
      t.boolean :is_done

      t.timestamps
    end
  end
end
