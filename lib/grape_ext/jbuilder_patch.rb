require 'tools/json_cache'

class Jbuilder
  include ::Tools::JsonCache

  def json_cache(key=[], options={}, &block)
    # # perform_caching?方法需要自定义，此方法是判断你是否开启缓存
    # if perform_caching?
    #   value = cache(key, options) do
    #     _scope { yield self }
    #   end
    #   merge! value
    # else
    #   yield
    # end
  end

end
