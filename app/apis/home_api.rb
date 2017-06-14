class HomeApi < Grape::API
  # do_not_route_head!
  # 用于接负载均衡
  get do
    status 200
  end

end
