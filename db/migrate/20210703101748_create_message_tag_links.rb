class CreateMessageTagLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :message_tag_links do |t|
      t.references :message, null: false
      t.references :tag, null: false
      t.timestamps
    end
  end
end
