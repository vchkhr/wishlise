module EmojisHelper
  def get_emoji_code(name)
    code = case name
    when :birthday_cake
      '&#127874;'
    end

    code.html_safe
  end

  def get_emoji_image(name)
    code = case name
    when :birthday_cake
      'birthday-cake.png'
    end

    return "icons/#{code}"
  end
end
