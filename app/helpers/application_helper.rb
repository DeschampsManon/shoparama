module ApplicationHelper
  def is_admin(admin=nil)
    icon_class = "ios-close-outline"
    icon_color = "red-text"
    if admin == true
      icon_class = "ios-checkmark-outline"
      icon_color = "green-text"
    end
    return raw "<span class='hidden'>#{admin}</span><i class='ion ion-#{icon_class} #{icon_color}'></i>"
  end

  def is_favorite(product=nil)
    icon_class = "ion-ios-heart"
    type = "favorite"
    product.favorited_by.each do |user|
      if user == current_user
        icon_class = "ion-heart-broken"
        type = "unfavorite"
      end
    end
    return link_to raw("<i class='ion #{icon_class}'></i>"), favorite_product_path(product, type: type), class: "red-text red-border", method: :put
  end
end
