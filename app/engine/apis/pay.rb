module Engine
  module Apis

    class Pay < Grape::API
      prefix 'pay'
      version 'v2', using: :accept_version_header

      mount ::PayNotifyApi

    end
  end
end
