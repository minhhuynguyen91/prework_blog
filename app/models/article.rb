class Article < ApplicationRecord

  
  def self.search(search)
    if search
      where("title ILIKE ?", "%#{search}%") 
    else
      where
    end
  end
  is_impressionable

  def comments
    Comment.where({ source_id: self.id, source_type: "Article" })
  end

end
