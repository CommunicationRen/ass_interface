# encoding: utf-8

module AssInterface
  module V1
    class Authenticate < Grape::API
      version 'v1', using: :path

      resource :auth2 do
        # 获取token
        # URL: /interface/v1/auth2/access_token.json
        # 请求方式: POST
        # 参数: username  String  必须
        #      password  String  必须
        #      timestamp String  必须
        #      sign      String  必须
        # 返回类型: json
        #          expires_time: 失效时间.
        #          {"token":"b9cd4466-ebe2-11e4-9493-10ddb1fffe72","expires_at":"2015-04-27 15:06:14"}
        desc '授权获取Access Token.'
        params do
          requires :username,  type: String, desc: "username."
          requires :password,  type: String, desc: "password."
          requires :timestamp, type: String, desc: "当前调用时间."
          requires :sign,      type: String, desc: "签名."
        end
        post :access_token do
          sign_str = params[:username].to_s + params[:password].to_s + params[:timestamp].to_s + params[:password].to_s
          sign = OpenSSL::Digest.new('MD5').update(sign_str).hexdigest
          error!({ success: false, desc: 'sign验证失败!'}, 200) unless params[:sign].to_s == sign
          authenticate!
          generate_token!
          { success: true, desc: 'refresh_new_token!', access_token: @current_user.access_token, expires_at: @current_user.expires_at.strftime('%Y-%m-%d %H:%M:%S') }
        end

      end

    end
  end
end