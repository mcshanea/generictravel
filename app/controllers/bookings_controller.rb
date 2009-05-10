class BookingsController < ApplicationController
  before_filter :login_required
  
  # GET /bookings
  # GET /bookings.xml
  def index
    if params[:booking] && params[:booking][:status_select]
      @bookings = session[:company].bookings.find_all_by_status(params[:booking][:status_select])
    elsif params[:agent_id]
      @bookings = session[:company].agents.find(params[:agent_id]).bookings
    elsif params[:client_id]
      @bookings = session[:company].clients.find(params[:client_id]).bookings
    else
      @bookings = session[:company].bookings
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.xml
  def show
    @booking = Booking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
      format.pdf do
        send_data BookingInvoice.draw(@booking), :filename => 'inventory_'+@booking.id.to_s+'.pdf', :type => 'application/pdf', :disposition => 'inline' 
      end
    end
  end

  # GET /bookings/new
  # GET /bookings/new.xml
  def new
    @booking = Booking.new

    @booking.company_id = current_user.company_id
    
    @booking.agent_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  # POST /bookings
  # POST /bookings.xml
  def create
    @booking = Booking.new(params[:booking])

    respond_to do |format|
      if @booking.save
        flash[:notice] = 'Booking was successfully created.'
        format.html { redirect_to(:action => "edit", :id => @booking.id) }
        format.xml  { render :xml => @booking, :status => :created, :location => @booking }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.xml
  def update
    params[:booking][:existing_itinerary_attributes] ||= {}
    
    @booking = Booking.find(params[:id])

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        flash[:notice] = 'Booking was successfully updated.'
        format.html { redirect_to(:action => "edit", :id => @booking.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.xml
  def destroy
    @booking = Booking.find(params[:id])
    #@booking.destroy
    
    # We want to mark this booking as deleted
    # as opposed to deleting it altogether
    @booking.status = 'DELETED'
    
    @booking.save

    respond_to do |format|
      format.html { redirect_to(bookings_url) }
      format.xml  { head :ok }
    end
  end
  
  # custom advanced search
  # the criteria for this search may fall outside
  # booking information i.e. they can search on most things
  def advanced_search
    
  end
  
  def refresh_booking_client
    @booking = Booking.find(params[:booking_id])
    
    render :partial => 'show_clients.html.erb', :locals => {:clients => @booking.clients}
  end

  def make_leader
    booking = Booking.find(params[:booking_id])
    
    booking.leader_id = params[:leader_id]
    
    booking.save
    
    refresh_booking_client
  end
  
  def update_hotel_options
    render :partial => 'hotel_picker_id', :locals => {:city => params[:city], :i => params[:div_id]}
  end

  def update_room_options
    render :partial => 'hotel_picker_room', :locals => {:hotel_id => params[:hotel_id]}
  end
  
  def refresh_hotel_rate
    #begin
    #  start_date = Date.parse(params[:departure_date]).to_s
    #  end_date = Date.parse(params[:arrival_date]).to_s
    
    #  rate = Rate.find_by_room_id(:all,params[:room_id])
      #                    :conditions => ["start_date >= " + start_date + 
      #                                    " and " + end_date + "<= end_date"])
    #rescue
    #end
    
    rates = Rate.find_all_by_room_id(params[:room_id])
    
    response = "<b>Rates:</b><br />"
    
    if rates.nil?
      response = "Rate not found. Try entering a date range."
    else
      rates.each do |rate|
        response += "<input type=\"radio\" id=\"itinerary_hotel_rate_id\" name=\"itinerary[rate_id]\" value=\"#{rate.id.to_s}\" onclick=\"setHotelValues(this.value);\" />" +
        rate.amount.to_s + " " + rate.start_date.to_s + " " + rate.end_date.to_s + "</input><br />"
      end
    end
    
    render :text => response
  end
  
    # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy_client
    @client = Client.find(params[:id])
    @client.destroy

    refresh_booking_client
  end
end
