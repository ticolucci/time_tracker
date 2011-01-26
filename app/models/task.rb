class Task < ActiveRecord::Base
    attr_accessible :description, :begin, :duration, :user_id
    
    belongs_to :user
end
