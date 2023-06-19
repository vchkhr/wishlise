module WishlistsHelper
  PUBLICITY_NAMES = {
    hidden: "Private",
    by_link: "Only by link",
    listed: "Public"
  }

  class CollectPublicities
    def call
      Wishlist.publicities.collect{ |name, num| [PUBLICITY_NAMES[name.to_sym], name] }
    end
  end
end
