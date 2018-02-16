class Tec < ApplicationRecord
  # validates :title, uniqueness: true
  validates_uniqueness_of :title, case_sensitive: false
  # paginates_per 2
  def self.search(term)
    if term
      where('title ILIKE ? OR source ILIKE ?', "%#{term}%", "%#{term}%").order('id DESC')
    else
      order('id DESC') 
    end
  end
end
