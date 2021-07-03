class AlterTags < ActiveRecord::Migration[6.1]
  def change
    add_index :tags, :value, unique: true
  end
end
