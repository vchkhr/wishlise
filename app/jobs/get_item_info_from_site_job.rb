class GetItemInfoFromSiteJob < ApplicationJob
  queue_as :default

  def perform(item)
    return if item.url.empty?

    @item = item
    @page = MetaInspector.new(@item.url)

    image_url = @page.images.best

    parse_image
    parse_title
    parse_price

    @item.save()
  end

  private

  def parse_image
    image_url = @page.images.best
    @item.update(image_url: image_url)
  end

  def parse_title
    @page.parsed.xpath("//*[@itemprop='name']").each do |title_candidate|
      title = title_candidate.text

      unless title.empty?
        @item.update(title: title) and return
      end
    end

    title = if !@page.h1.empty?
      @page.h1[0].html_safe
    else
      @page.title.html_safe
    end

    unless title.empty?
      @item.update(title: title)
    end
  end

  def parse_price
    @page.parsed.xpath("//*[@itemprop='price']").each do |title_candidate|
      price = title_candidate.text

      unless price.empty?
        @item.update(price: price) and return
      end
    end
  end
end
