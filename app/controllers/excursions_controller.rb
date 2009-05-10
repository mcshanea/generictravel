class ExcursionsController < ApplicationController
  before_filter :login_required

  # GET /excursions
  # GET /excursions.xml
  def index
    @excursions = session[:company].excursions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @excursions }
    end
  end

  # GET /excursions/1
  # GET /excursions/1.xml
  def show
    @excursion = Excursion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @excursion }
    end
  end

  # GET /excursions/new
  # GET /excursions/new.xml
  def new
    @excursion = Excursion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @excursion }
    end
  end

  # GET /excursions/1/edit
  def edit
    @excursion = Excursion.find(params[:id])
  end

  # POST /excursions
  # POST /excursions.xml
  def create
    @excursion = Excursion.new(params[:excursion])

    respond_to do |format|
      if @excursion.save
        flash[:notice] = 'Excursion was successfully created.'
        format.html { redirect_to(@excursion) }
        format.xml  { render :xml => @excursion, :status => :created, :location => @excursion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @excursion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /excursions/1
  # PUT /excursions/1.xml
  def update
    @excursion = Excursion.find(params[:id])

    respond_to do |format|
      if @excursion.update_attributes(params[:excursion])
        flash[:notice] = 'Excursion was successfully updated.'
        format.html { redirect_to(@excursion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @excursion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /excursions/1
  # DELETE /excursions/1.xml
  def destroy
    @excursion = Excursion.find(params[:id])
    @excursion.destroy

    respond_to do |format|
      format.html { redirect_to(excursions_url) }
      format.xml  { head :ok }
    end
  end
end
