class CreateJoinTableLineGramm < ActiveRecord::Migration[5.0]
  def change
    create_join_table :lines, :gramms do |t|
      # t.index [:line_id, :gramm_id]
      # t.index [:gramm_id, :line_id]
    end
  end
end
