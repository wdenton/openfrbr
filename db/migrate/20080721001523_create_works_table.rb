class CreateWorksTable < ActiveRecord::Migration
  def self.up
    create_table :works do |table|
      table.column :title, :string
      table.column :form, :string
      table.column :date, :date
      table.column :comment, :string
    end
  end

  def self.down
    drop_table :works
  end
end
