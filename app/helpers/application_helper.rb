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
end
