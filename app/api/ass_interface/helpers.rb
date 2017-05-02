# encoding: utf-8

module AssInterface
  module Helpers
    def warden
      env['warden']
    end

    # topic helpers
    def max_page_size
      100
    end

    def default_page_size
      15
    end

    def page_size
      size = params[:size].to_i
      [size.zero? ? default_page_size : size, max_page_size].min
    end

    def current_user
      username, password = params[:username].to_s, params[:password].to_s
      @current_user = User.find_for_database_authentication(login: username)
      auth = false
      auth = true if @current_user && @current_user.valid_password?(password)
      auth ? @current_user : nil
    end

    def authenticate!
      error!({ success: false, desc: '帐号或密码错误!'}, 200) unless current_user
    end

    def generate_token!
      @current_user.generate_access_token
      @current_user.timestamp_at = params[:timestamp].to_time
      @current_user.expires_at = @current_user.timestamp_at + 12.hours
      @current_user.save
      @current_user
    end

    def authenticate_token!
      @user ||= User.where(access_token: params[:token].to_s).try(:first)

      if @user.blank?
        error!({ success: false, desc: 'token is not found!' }, 200)
      elsif @user.expires_at < Time.now
        error!({ success: false, desc: 'token is expired!' }, 200)
      else
        @user
      end
    end

  end
end
