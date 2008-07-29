class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.timestamps
      t.column :name,    :string
      t.column :dates,   :string
      t.column :comment, :string
    end

    Person.create :name => "J.K. Rowling", :dates => "31 July 1965 - ", :comment => ""
    Person.create :name => "William Denton", :dates => "", :comment => ""
    Person.create :name => "Jim Date", :dates => "", :comment => "Great voice actor"

    create_table :works_people, :id => false do |t|
      t.timestamps
      t.column :work_id, :integer
      t.column :person_id, :integer
    end

    # J.K. Rowling is the creator of the Harry Potter books.
    p = Person.find(1)
    Work.find(1).people << p
    Work.find(2).people << p
    Work.find(3).people << p

    create_table :expressions_people, :id => false do |t|
      t.timestamps
      t.column :expression_id, :integer
      t.column :person_id, :integer
    end

    # J.K. Rowling realized the expressions of the first three books
    Expression.find(1).people << p
    Expression.find(2).people << p
    Expression.find(3).people << p

    create_table :manifestations_people, :id => false do |t|
      t.timestamps
      t.column :manifestation_id, :integer
      t.column :person_id, :integer
    end

    create_table :items_people, :id => false do |t|
      t.timestamps
      t.column :item_id, :integer
      t.column :person_id, :integer
    end

    # I own each of the three items
    Item.find(1).people << Person.find(2)
    Item.find(2).people << Person.find(2)
    Item.find(3).people << Person.find(2)

  end

  def self.down
    drop_table :people
    drop_table :works_people
    drop_table :expressions_people
    drop_table :manifestations_people
    drop_table :items_people
  end
end
