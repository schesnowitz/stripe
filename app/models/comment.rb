class Comment < ApplicationRecord
  belongs_to :world 
  belongs_to :user 
end 
