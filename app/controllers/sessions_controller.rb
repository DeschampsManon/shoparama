class SessionsController < Devise::SessionsController
	after_filter :after_login, only: :create

	def after_login
		UserLogin.create!(user_id: current_user.id, user_ip: current_user.current_sign_in_ip)
	end
end