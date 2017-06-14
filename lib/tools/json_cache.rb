module Tools
  module JsonCache

    # cache for api
    # example:
    #
    # @posts, @pageset = if params[:s] and !params[:s].strip.blank?
    #   cache [@project, "posts", "search"], expires_in: 1.minutes do
    #     @project.project_posts.search(params[:s], target: :project, target_ids: @project.id, page: params[:page], limit: 10)
    #   end
    # end

    def cache(name = [], options = {}, &block)
      # # perform_caching?为判断是否支持缓存的一个自定义方法
      # if perform_caching?
      #   fragment_for(fragment_key(name), options, &block)
      # else
      #   yield
      # end
    end

    def cache_if(condition, name = [], options = {}, &block)
      if condition
        cache(name, options, &block)
      else
        yield
      end
    end

    def cache_unless(condition, name = [], options = {}, &block)
      cache_if !condition, name, options, &block
    end

  private

    def fragment_key(name)
      name = Array(name) unless name.is_a?(Array)
      name[0] = name[0].cache_key if name[0].respond_to?(:cache_key)
      Digest::MD5.hexdigest(name.join("/"))
    end

    def fragment_for(name, options={}, &block)
      read_fragment_for(name) || write_fragment_for(name, options, &block)
    end

    # 读缓存
    def read_fragment_for(name)
      # cache.fetch(name) rescue nil
    end

    # 写缓存
    def write_fragment_for(name, options={})
      content = yield
      # cache.write(name, content, options)
      options[:env].logger.info "--- write name: #{name.inspect} finished" if options[:env]
      return content
    end

  end
end
