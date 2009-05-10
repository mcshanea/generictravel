module ClientsHelper
  def fields_for_location(location, &block)
    prefix = location.new_record? ? 'new' : 'existing'
    fields_for("booking[#{prefix}_location_attributes][]", location, &block)
  end

  def add_location_link(name) 
    link_to_function name do |page| 
      page.insert_html :bottom, :locations, :partial => 'location', :object => Location.new 
    end 
  end 
  
end
