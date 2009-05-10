module RoomsHelper
  
  def fields_for_rate(rate, &block)
    prefix = rate.new_record? ? 'new' : 'existing'
    fields_for("room[#{prefix}_rate_attributes][]", rate, &block)
  end

  def add_rate_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_rate, :partial => 'rate', :object => Rate.new 
    end 
  end
  
end
