class Comment < ApplicationRecord
  acts_as_votable
  
  belongs_to :world 
  belongs_to :user 
end 
