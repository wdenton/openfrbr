module ApplicationHelper

  def generate_group2_entity_link_list(entities)
    # Pass in @work.creators or @item.owners etc. and this
    # will generate a list of all people, familes, and corporate
    # bodies involved, and link them.
    #
    # I assume there's some way to collapse the three possible
    # kinds of classes into one statement.
    list = "<ul>\n"
    entities.each do |e|
      puts e.class
      if e.class.to_s == "Person" 
        list += ("<li>") + (link_to e.name, 
                  :controller => "people", 
                  :action => "show",
                  :id => e.id)
      elsif e.class.to_s == "Family" 
        list += ("<li>") + (link_to e.name, 
                  :controller => "families", 
                  :action => "show",
                  :id => e.id)
      elsif e.class.to_s == "CorporateBody" 
        list += ("<li>") + (link_to e.name, 
                  :controller => "corporate_bodies", 
                  :action => "show",
                  :id => e.id)
      end     
    end
    list += "</ul>\n"
    return list
  end

end
