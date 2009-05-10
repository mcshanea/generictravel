require 'active_record'

class ActiveRecord::Base
  def self.formatted_time_accessor(*names)
    names.each do |name|
      define_method("formatted_#{name}") do
        self[name].strftime('%d/%m/%Y %H:%M') if self[name]
      end
      define_method("formatted_#{name}=") do |value|
        self[name] = DateTime.strptime(value, '%d/%m/%Y %H:%M').to_time
      end
    end
  end
end 

