module WishlistsHelper
  PUBLICITY_NAMES = {
    hidden: "Private",
    by_link: "Only by link",
    listed: "Public"
  }

  PUBLICITY_TITLES = {
    hidden: "Visible only to you",
    by_link: "Available only by link",
    listed: "Listed on your profile"
  }

  PUBLICITY_ICONS = {
    hidden: "bi bi-lock",
    by_link: "bi bi-share",
    listed: "bi bi-globe"
  }

  class CollectPublicities
    def call
      Wishlist.publicities.collect{ |name, num| [PUBLICITY_NAMES[name.to_sym], name] }
    end
  end
end
