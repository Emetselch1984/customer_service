class AlterMessageTagLinks < ActiveRecord::Migration[6.1]
  def change
    add_index :message_tag_links, [:message_id,:tag_id], unique: true
  end
end
