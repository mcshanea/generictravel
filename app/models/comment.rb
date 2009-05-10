class Comment < ActiveRecord::Base
  belongs_to :booking
  belongs_to :agent
  
  validates_presence_of :booking
end
