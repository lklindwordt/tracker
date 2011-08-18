class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :project_id
      t.text :note
      t.integer :user_id
      t.string :element
      t.string :position
      t.string :url

      t.timestamps
    end
  end
end
