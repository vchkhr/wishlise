class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true

  as_enum :visibility, public: 2, friends: 1, private: 0

  def full_name
    if first_name.nil?
      nil
    else
      if last_name.nil?
        first_name
      else
        "#{first_name} #{last_name}"
      end
    end
  end
end
