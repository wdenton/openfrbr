class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.timestamps
      t.column :title,   :string
      t.column :form,    :string
      t.column :date,    :string
      t.column :comment, :string
    end

  end

  def self.down
    drop_table :works
  end
end
