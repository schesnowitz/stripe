class Google < ApplicationRecord
  validates :title, uniqueness: true
  # paginates_per 2
  def self.search(term)
    if term
      where('title ILIKE ? OR source ILIKE ?', "%#{term}%", "%#{term}%").order('id DESC')
    else
      order('id DESC') 
    end
  end
end
