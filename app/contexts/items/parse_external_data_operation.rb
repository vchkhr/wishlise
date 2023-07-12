# frozen_string_literal: true

require 'open-uri'

module Items
  class ParseExternalDataOperation < ::ApplicationOperation
    def call(params)
      @attrs = yield validate(Contracts::ParseExternalData, params)

      @item = find_item
      @doc = parse_data

      @attrs[:title] = parse_title if @item.title.blank?
      @attrs[:description] = parse_description if @item.description.blank?
      @attrs[:price] = parse_price if @item.price.blank?
      parse_image if @item.image.blank?

      update_item

      update_wishlist

      Success(@item)
    end

    private

    def find_item
      Item.find(@attrs[:id])
    end

    def parse_data
      Nokogiri::HTML.parse(URI.parse(@item.url).open)
    end

    def parse_title
      title = @doc.xpath('//*[@data-name]/@data-name').first ||
              @doc.xpath("//*[@itemprop='name']//text()").first ||
              @doc.xpath("//meta[@property='og:title']/@content").first
      title.nil? ? "#{URI.parse(@item.url).host}#{URI.parse(@item.url).path}" : title.text.strip.truncate(255, separator: ' ')
    end

    def parse_description
      description = @doc.xpath("//*[@itemprop='description']//text()").first ||
                    @doc.xpath('//*[@data-description]/@data-description').first ||
                    @doc.xpath("//meta[@property='og:description']/@content").first
      description.nil? ? '' : description.text.strip.truncate(255, separator: ' ')
    end

    def parse_amount(string)
      # Remove any non-digit or non-decimal point characters
      cleaned_string = string.gsub(/[^\d.,]/, '')

      # Replace comma with dot if present
      cleaned_string.gsub!(',', '.')

      # Extract the numeric part
      match = /(\d+(?:\.\d+)?)/.match(cleaned_string)

      # Return the matched amount as a float
      match[1].to_f if match
    end

    def parse_price
      price = @doc.xpath('//*[@data-price]/@data-price').first ||
              @doc.xpath("//*[@itemprop='price']//text()").first ||
              @doc.xpath("//meta[@property='product:price:amount']/@content").first ||
              @doc.xpath("//meta[@property='product:price']/@content").first ||
              @doc.xpath("//meta[@property='price']/@content").first ||
              @doc.xpath("//*[contains(@class, 'product-price')]//text()").first
      price.nil? ? '' : parse_amount(price.text.strip)
    end

    def update_image(image, image_url)
      @item.image.attach(
        io: image,
        filename: URI.parse(image_url).path.split('/').last
      )
    end

    def parse_image
      image_url = @doc.xpath("//meta[@property='og:image']/@content").first
      image = image_url.nil? ? '' : URI.parse(image_url.text.strip).open
      update_image(image, image_url) if image.present? && image.content_type.in?(%w[image/jpeg image/png]) && image.size <= 5.megabytes
    end

    def update_item
      @item.update(@attrs.merge(is_being_parsed: false))
    end

    def update_wishlist
      @item.wishlist.update(updated_at: Time.zone.now)
    end
  end
end
