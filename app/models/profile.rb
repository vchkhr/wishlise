class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true

  as_enum :visibility, public: 2, friends: 1, private: 0
end
