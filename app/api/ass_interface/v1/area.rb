# encoding: utf-8

module AssInterface
  module V1
    class Area < Grape::API
      version 'v1', using: :path

      resource :area do
        # 获取provinces
        # URL: /interface/v1/area/provinces.json
        # 请求方式: POST
        # 参数: token  String  必须
        # 返回类型: json
        #          {"北京市":"110000","天津市":"120000"}
        desc '获取provinces.'
        params do
          requires :token,  type: String, desc: "access token."
        end
        post :provinces do
          authenticate_token!
          result = ::Area.provinces.map {|x| { x.name.to_s => x.id.to_s }}.inject(&:merge)
          { success: true, desc: '查询成功!', result: result }
        end

        # 获取cities
        # URL: /api/v1/area/cities.json
        # 请求方式: POST
        # 参数: token  String  必须
        #       id    String  必须
        # 返回类型: json
        #          {"北京市":"110000","天津市":"120000"}
        desc '获取cities.'
        params do
          requires :token,  type: String, desc: "access token."
          requires :id,     type: String, desc: "province_id."
        end
        post :cities do
          authenticate_token!
          province = ::Area.find_by(id: params[:id])
          return { success: false, desc: '1级省会不存在!', result: {} } if province.blank?
          result = province.children.published.map {|x| { x.name.to_s => x.id.to_s }}.inject(&:merge)
          { success: true, desc: '查询成功!', result: result }
        end

        # 获取counties
        # URL: /interface/v1/area/getCounty.json
        # 请求方式: POST
        # 参数: token  String  必须
        #       id    String  必须
        # 返回类型: json
        #          {"北京市":"110000","天津市":"120000"}
        desc '获取getCounty.'
        params do
          requires :token,  type: String, desc: "access token."
          requires :id,     type: String, desc: "city_id."
        end
        post :getCounty do
          authenticate_token!
          city = ::Area.find_by(id: params[:id])
          return { success: false, desc: '2级城市不存在!', result: {} } if city.blank?
          result = city.children.published.map {|x| { x.name.to_s => x.id.to_s }}.inject(&:merge)
          { success: true, desc: '查询成功!', result: result }
        end

      end

    end
  end
end
