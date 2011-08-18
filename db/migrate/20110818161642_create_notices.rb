class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :project_id
      t.text :notice

      t.timestamps
    end
  end
end
