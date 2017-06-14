module Engine
  module Apis

    class Attachments < Grape::API
      prefix 'attachments'
      version 'v2', using: :accept_version_header, strict: true

      content_type :json, "application/json;charset=UTF-8"
      format :json
      formatter :json, Grape::Formatter::Jbuilder

      mount ::AttachmentsApi
    end
  end
end
