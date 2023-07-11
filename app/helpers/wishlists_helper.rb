# frozen_string_literal: true

module WishlistsHelper
  PUBLICITY_NAMES = {
    hidden: 'Private',
    by_link: 'Only by link',
    listed: 'Public'
  }.freeze

  PUBLICITY_TITLES = {
    hidden: 'Visible only to you',
    by_link: 'Available only by link',
    listed: 'Listed on your profile'
  }.freeze

  PUBLICITY_ICONS = {
    hidden: 'bi bi-lock',
    by_link: 'bi bi-share',
    listed: 'bi bi-globe'
  }.freeze

  class CollectPublicities
    def call
      Wishlist.publicities.collect { |name, _num| ["<i class='fs-75 #{PUBLICITY_ICONS[name.to_sym]}'></i> #{PUBLICITY_NAMES[name.to_sym]}", name] }
    end
  end
end
