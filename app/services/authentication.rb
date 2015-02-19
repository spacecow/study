class Authentication
  ALPHABET = ('a'..'z').to_a

  def initialize(params, omniauth = nil)
    @params = params
    @omniauth = omniauth
  end

  def user
    @user ||= @omniauth ? user_from_omniauth : user_with_password
  end

  def authenticated?; user.present? end

  private

    def user_from_omniauth
      User.where(@omniauth.slice(:provider,:uid)).first_or_initialize.tap do |user|
        user.name = @omniauth.info.name
        user.username = @omniauth.info.nickname
        user.email = @omniauth.info.email
        user.oauth_token = @omniauth.credentials.token
        user.oauth_expires_at = Time.at(@omniauth.credentials.expires_at)
        user.password = 10.times.map{ ALPHABET.sample }.join
        user.save!
      end
    end

    def user_with_password
      user = User.find_by_username(@params[:login])
      user = User.find_by_email(@params[:login]) if user.nil?
      user && user.authenticate(@params[:password])
    end
end
