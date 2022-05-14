module EmojisHelper
  def get_emoji_symbol(name)
    code = case name
    when 'birthday_cake'
      '&#127874;'
    end

    code.html_safe
  end
end
