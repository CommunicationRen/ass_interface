# encoding: utf-8

module AssInterface
  class API < Grape::API
    format :json

    helpers AssInterface::Helpers

    # 认证模块
    mount AssInterface::V1::Authenticate

    # 地区模块
    mount AssInterface::V1::Area

  end
end
