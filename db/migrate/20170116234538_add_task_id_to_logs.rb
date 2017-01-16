class AddTaskIdToLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :task_id, :string
  end
end
