class CreateExpressions < ActiveRecord::Migration
  def self.up
    create_table :expressions do |t|
      t.timestamps
      t.column :title,    :string
      t.column :form,     :string
      t.column :date,     :string
      t.column :language, :string
      t.column :comment,  :string
      t.column :work_id,  :integer # foreign key for the work this expresses
    end

  end

  def self.down
    drop_table :expressions
  end
end
