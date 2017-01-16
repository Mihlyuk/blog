class CreateGramms < ActiveRecord::Migration[5.0]
  def change
    create_table :gramms do |t|
      t.timestamps
    end
  end
end
