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

    Expression.create :title => "Harry Potter and the Philosopher's Stone", :form => "text", :date => "1997", :language => "English", :comment => "", :work_id => 1
    Expression.create :title => "Harry Potter and the Chamber of Secrets", :form => "text", :date => "1998", :language => "English", :comment => " ", :work_id => 2
    Expression.create :title => "Harry Potter and the Prisoner of Azkaban", :form => "text", :date => "1999", :language => "English", :comment => "", :work_id => 3

  end

  def self.down
    drop_table :expressions
  end
end
