class Task < ActiveRecord::Base
    attr_accessible :description, :begin, :duration
    
    belongs_to :user
    
    before_create :add_user_id
    
    def add_user_id
      self.user = current_user
    end
end
