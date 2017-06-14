# Helpers::Errors::AuthErrors

module Helpers

  module Errors
    module AuthErrors

      class InvalidRequestError < Goliath::Validation::Error
        def initialize
          code = "605"
          message = "invalid request."
          super(code, message)
        end
      end

      class InvalidTokenError < Goliath::Validation::Error
        def initialize
          code = "603"
          message = "invalid access token."
          super(code, message)
        end
      end

      class AccessTokenExpiredError < Goliath::Validation::Error
        def initialize
          code = "601"
          message = "access token have been expired."
          super(code, message)
        end
      end

      class ResourcesNotFoundError < Goliath::Validation::Error
        def initialize
          code = "606"
          message = "resources requested is Not Found."
          super(code, message)
        end
      end

      class DontSupportGrantTypeError < Goliath::Validation::Error
        def initialize
          code = "602"
          message = "Dont support the grant type."
          super(code, message)
        end
      end

      class RequiredParamsError < Goliath::Validation::Error
        def initialize
          code = "600"
          message = "need required params."
          super(code, message)
        end
      end


    end
  end

end
