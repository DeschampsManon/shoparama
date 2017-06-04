class UserMailer < ApplicationMailer
  def welcome(user, password)
    @user = user
    @password = password
    mail(
        to: @user.email,
        from: "deschamps.manon.91@gmail.com",
        subject: "Welcome #{@user.first_name}"
    )
  end
end
