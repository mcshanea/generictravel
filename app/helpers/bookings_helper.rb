module BookingsHelper
  
  def refresh_clients(name)
    link_to_function name do |page|
      page.replace_html :clients, :partial => 'show_clients', :locals => { :clients => Booking.find(@booking.id).clients }
    end 
  end 
  
  def fields_for_itinerary(itinerary, &block)
    prefix = itinerary.new_record? ? 'new' : 'existing'
    fields_for("booking[#{prefix}_itinerary_attributes][]", itinerary, &block)
  end

  def add_air_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_item, :partial => 'itinerary', :object => Itinerary.new, :locals => {:itin_type => "AIR"} 
    end 
  end 
  
  def add_hotel_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_item, :partial => 'itinerary', :object => Itinerary.new, :locals => {:itin_type => "HOTEL"} 
    end 
  end
  
  def add_car_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_item, :partial => 'itinerary', :object => Itinerary.new, :locals => {:itin_type => "CAR"} 
    end 
  end
  
  def fields_for_excursion(excursion, &block)
    prefix = excursion.new_record? ? 'new' : 'existing'
    fields_for("booking[#{prefix}_excursion_attributes][]", excursion, &block)
  end

  def add_excursion_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_item, :partial => 'excursion', :object => Excursion.new 
    end 
  end

  def fields_for_payment(payment, &block)
    prefix = payment.new_record? ? 'new' : 'existing'
    fields_for("booking[#{prefix}_payment_attributes][]", payment, &block)
  end

  def add_payment_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_item, :partial => 'payment', :object => Payment.new 
    end 
  end 

  def fields_for_comment(comment, &block)
    prefix = comment.new_record? ? 'new' : 'existing'
    fields_for("booking[#{prefix}_comment_attributes][]", comment, &block)
  end

  def add_comment_link(name) 
    link_to_function name do |page| 
      page.insert_html :top, :new_item, :partial => 'comment', :object => Comment.new 
    end 
  end 
  
  def getRowStyle(booking)
    output = ""
    
    if booking.payments.find_by_processed_date(:conditions => "payments.processed_date is not null")
      if booking.processed_date.nil? || 
          booking.excursions.find_by_booking_reference(:conditions => "excursions.booking_reference is not null").count != booking.excursions.count || 
          booking.itineraries.find_by_booking_reference(:conditions => "itineraries.booking_reference is not null") != booking.itineraries.count
        output += "style=\"background-color:#FFC125;\""
      else
        output += "style=\"background-color:#228B22;\""
      end
    else
      output += "style=\"background-color:#FF3030;color:#FFFFFF;\""
    end
    
    return output
  end
  
  def getLeadClientName(id)
    if id
      client = Client.find(id)
      client.first_name[0,1] + ' ' + client.last_name
    end
  end
  
  def getReminders(booking)
   if booking.payments.find_by_processed_date(:conditions => "payments.processed_date is not null")
      if booking.itineraries.find_by_booking_reference(:conditions => "itineraries.booking_reference is not null") != booking.itineraries.count
        flash.now[:notice] = "Outstanding Itineraries"
      elsif booking.excursions.find_by_booking_reference(:conditions => "excursions.booking_reference is not null").count != booking.excursions.count
        flash.now[:notice] = "Outstanding Excursions"
      elsif booking.processed_date
        flash.now[:notice] = "Details not Sent"
      end
    else
      flash.now[:notice] = "Outstanding Payments"
    end 
  end
  
  def getPaymentTotal(booking)
    return BookingInvoice.bookingPaymentTotal(booking)
  end
  
  def add_hotel_choice(id) 
    render :update do |page| 
      page.replace_html id, :partial => 'comment', :locals => { :city => ad }
      #page.insert_html :top, :new_item, "test"
    end 
  end
  
  def rand_with_range(values = nil)
    if values.respond_to? :sort_by
      values.sort_by { rand }.first
    else
      rand(values)
    end
  end
end
