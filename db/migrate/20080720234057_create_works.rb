class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.timestamps
      t.column :title,   :string
      t.column :form,    :string
      t.column :date,    :string
      t.column :comment, :string
    end

    Work.create :title => "Harry Potter and the Philosopher's Stone", :form => "novel", :date => "1997", :comment => "First book"
    Work.create :title => "Harry Potter and the Chamber of Secrets", :form => "novel", :date => "1998", :comment => " Second book"
    Work.create :title => "Harry Potter and the Prisoner of Azkaban", :form => "novel", :date => "1999", :comment => "Third book"

  end

  def self.down
    drop_table :works
  end
end
