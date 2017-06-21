module DashboardHelper
  def evolution_from_last_week(start_value = 0, end_value = 1)
    icon_class = ""
    text_color = ""
    substraction = end_value - start_value
    division = substraction.to_f / start_value
    evolution_percentage = division.to_f * 100
    if evolution_percentage >= 0
      icon_class = "ion-arrow-up-b"
      text_color = "green"
    else
      icon_class = "ion-arrow-down-b"
      text_color = "red"
    end
    return raw "<span class='#{text_color}-text'> <i class='ion #{icon_class}'></i> #{evolution_percentage.round(2)} % </span>"
  end
end