require "pdf/simpletable"

class BookingInvoice
  def self.draw(booking)
    pdf = PDF::Writer.new

    #booking.itineraries.each do |itinerary|
    #  pdf.text itinerary.departing + " " + itinerary.arriving + " " +
    #            itinerary.departure_date.to_s + " " + itinerary.arrival_date.to_s + " " +
    #            itinerary.payment_amount.to_s
    #end
    
    pdf.text "Booking Number: " + booking.id.to_s + "\n"
    
    if booking.leader_id
      lead_passenger = Client.find(booking.leader_id)
      
      pdf.text "To: " + lead_passenger.first_name + " " + lead_passenger.last_name + "\n"
    end
    
    if booking.itineraries.count != 0
      itin_table = PDF::SimpleTable.new
      itin_table.title = "Itineraries"
      itin_table.column_order.push(*%w(itin_type departing arriving departure_date arrival_date payment))

      itin_table.columns["itin_type"] = PDF::SimpleTable::Column.new("itin_type")
      itin_table.columns["itin_type"].heading = "Itinerary Type"

      itin_table.columns["departing"] = PDF::SimpleTable::Column.new("departing")
      itin_table.columns["departing"].heading = "Departing"

      itin_table.columns["arriving"] = PDF::SimpleTable::Column.new("arriving")
      itin_table.columns["arriving"].heading = "Arriving"

      itin_table.columns["departure_date"] = PDF::SimpleTable::Column.new("departure_date")
      itin_table.columns["departure_date"].heading = "Departure Date"

      itin_table.columns["arrival_date"] = PDF::SimpleTable::Column.new("arrival_date")
      itin_table.columns["arrival_date"].heading = "Arrival Date"
    
      itin_table.columns["payment"] = PDF::SimpleTable::Column.new("payment")
      itin_table.columns["payment"].heading = "Payment Amount"

      itin_table.show_lines    = :none
      itin_table.show_headings = true
      itin_table.orientation   = :center
      itin_table.position      = :center

      data = Array.new
    
        booking.itineraries.each do |itinerary|
          if itinerary.rate_id
      	    rate = Rate.find(itinerary.rate_id).amount.to_s
    	    else
    	      rate = itinerary.payment_amount.to_s
  	      end
	      
      	  data << {"itin_type"=> itinerary.itinerary_type, "departing"=> itinerary.departing, "arriving"=> itinerary.arriving, "departure_date"=> itinerary.departure_date.to_s[0..15],
      	    "arrival_date"=> itinerary.arrival_date.to_s[0..15], "payment"=> rate} # Departing row
      	end

      itin_table.data.replace data
      itin_table.render_on(pdf)
    end
    
    if booking.excursions.count != 0
      excursion_table = PDF::SimpleTable.new
      excursion_table.title = "Excursions"
      excursion_table.column_order.push(*%w(venue phone departure_date arrival_date payment))

      excursion_table.columns["itin_type"] = PDF::SimpleTable::Column.new("venue")
      excursion_table.columns["itin_type"].heading = "Venue"

      excursion_table.columns["departing"] = PDF::SimpleTable::Column.new("phone")
      excursion_table.columns["departing"].heading = "Phone Number"

      excursion_table.columns["departure_date"] = PDF::SimpleTable::Column.new("departure_date")
      excursion_table.columns["departure_date"].heading = "Departure Date"

      excursion_table.columns["arrival_date"] = PDF::SimpleTable::Column.new("arrival_date")
      excursion_table.columns["arrival_date"].heading = "Arrival Date"

      excursion_table.columns["payment"] = PDF::SimpleTable::Column.new("payment")
      excursion_table.columns["payment"].heading = "Payment Amount"

      excursion_table.show_lines    = :none
      excursion_table.show_headings = true
      excursion_table.orientation   = :center
      excursion_table.position      = :center

      data = Array.new

        booking.excursions.each do |excursion|

      	  data << {"venue"=> excursion.venue, "phone"=> excursion.phone_number, "departure_date"=> excursion.departure_date.to_s,
      	    "arrival_date"=> excursion.arrival_date.to_s, "payment"=> excursion.payment_amount.to_s} # Departing row
      	end

      excursion_table.data.replace data
      excursion_table.render_on(pdf)
    end
    
    pdf.text "\nTotal Payment"
    pdf.text bookingPaymentTotal(booking)
    
    pdf.render
  end
  
  def self.bookingPaymentTotal(booking)
    total = 0.00
    
    total = itineraryPaymentTotal(booking.itineraries, total)
    
    total = excursionPaymentTotal(booking.excursions, total)
    
    if booking.agent_percentage
      if booking.agent_percentage
        total = total % booking.agent_percentage
      end
    end
    
    return total.to_s
  end
  
  private
  
  def self.itineraryPaymentTotal(itineraries, total)
    for itinerary in itineraries
      if itinerary.payment_amount 
        total += itinerary.payment_amount
      end
      
      if itinerary.rate_id
        total += Rate.find(itinerary.rate_id).amount
      end
    end
    
    return total
  end
  
  def self.excursionPaymentTotal(excursions, total)
    for excursion in excursions
      if excursion.payment_amount
        total += excursion.payment_amount
      end
    end
    
    return total
  end
  
end