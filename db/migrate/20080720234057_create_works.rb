class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.timestamps
      t.column :title,   :string
      t.column :form,    :string
      t.column :date,    :date
      t.column :comment, :string
    end

    Work.create :title => "Harry Potter and the Philosopher's Stone", :form => "", :date => "1997", :comment => "First book"
    Work.create :title => "Harry Potter and the Chamber of Secrets", :form => "", :date => "1998", :comment => " Second book"
    Work.create :title => "Harry Potter and the Prisoner of Azkaban", :form => "", :date => "1999", :comment => "Third book"
    Work.create :title => "Harry Potter and the Goblet of Fire", :form => "", :date => "2000", :comment => "Fourth book"
    Work.create :title => "Harry Potter and the Order of the Phoenix", :form => "", :date => "2003", :comment => "Fifth book"
    Work.create :title => "Harry Potter and the Half-Blood Prince", :form => "", :date => "2005", :comment => "Sixth book"
    Work.create :title => "Harry Potter and the Deathly Hallows", :form => "", :date => "2007", :comment => "Seventh book"
  end

  def self.down
    drop_table :works
  end
end
