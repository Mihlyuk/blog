class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :question
      t.string :answer
      t.integer :level
      t.integer :task_id

      t.timestamps
    end
  end
end
