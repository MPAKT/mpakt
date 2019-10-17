class Blog < ApplicationRecord

  validates :title, :summary, presence: true

end
