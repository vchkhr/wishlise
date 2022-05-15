class List < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  as_enum :emoji, birthday_cake: 0
  as_enum :visibility, public: 3, friends: 2, by_link: 1, private: 0

  has_many :items
end
