module SearchesHelper
  
  def get_client_select
    clients ||= Client.find(:all).collect{|c| [c.last_name, c.id] }
    
    return clients
  end
  
  def get_agent_select
    agents ||= Agent.find(:all).collect{|a| [a.last_name, a.id] }
    
    return agents
  end
  
  def get_service_select
    services ||= Service.find(:all).collect{|s| [s.operator, s.id] }
    
    return services
  end
  
end
