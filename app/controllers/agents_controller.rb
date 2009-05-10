class AgentsController < ApplicationController

  before_filter :login_required, :except => [:new, :create]

  # GET /agents
  # GET /agents.xml
  def index
    @agents = session[:company].agents

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agents }
    end
  end

  # GET /agents/1
  # GET /agents/1.xml
  def show
    @agent = Agent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agent }
    end
  end

  # GET /agents/new
  # GET /agents/new.xml
  def new
    @agent = Agent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agent }
    end
  end

  # GET /agents/1/edit
  def edit
    @agent = Agent.find(params[:id])
  end

  # POST /agents
  # POST /agents.xml
  def create
    cookies.delete :auth_token
    
    @agent = Agent.new(params[:agent])
    
    @agent.active = false
        
    if @agent.company_id && Agent.find_by_company_id(@agent.company_id.to_s).blank?
      # First user created for this company on the system
      # will be the company admin
      @agent.role = "admin"
			
      # As this is the admin we can just authorise straight away
      @agent.active = true
    elsif !@agent.company_id.nil?
      # We will want to email admin asking for authorisation
      MailMe.deliver_signup(@agent.email, Agent.find_by_role('admin', :conditions => {:company_id => @agent.company_id}).email)
    elsif Agent.find_by_role('super-admin').blank? 
      @agent.role = 'super-admin'
      @agent.active = true
    end

    respond_to do |format|
      if @agent.save
        flash[:notice] = 'Agent was successfully created. The administrator has been contacted, who will active your account.'
        
        #EmailNotifications.signup(@agent.email) unless @agent.role == 'admin'
        
        format.html { redirect_to(:controller => "sessions", :action => "new") }
        format.xml  { render :xml => @agent, :status => :created, :location => @agent }
      else
        flash.now[:error] = "Agent creation Failed."
        format.html { render :action => "new" }
        format.xml  { render :xml => @agent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agents/1
  # PUT /agents/1.xml
  def update
    @agent = Agent.find(params[:id])

    respond_to do |format|
      if @agent.update_attributes(params[:agent])
        flash[:notice] = 'Agent was successfully updated.'
        format.html { redirect_to(@agent) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.xml
  def destroy
    @agent = Agent.find(params[:id])
    @agent.destroy

    respond_to do |format|
      format.html { redirect_to(agents_url) }
      format.xml  { head :ok }
    end
  end
end
