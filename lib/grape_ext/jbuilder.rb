module Grape
  module Formatter

    class Renderer
      def initialize(view_path, template)
        @view_path, @template = view_path, template
      end

      def render(scope, locals = {})
        engine = ::Tilt.new file, nil, view_path: view_path
        engine.render scope, locals
      end

      private

      attr_reader :view_path, :template

      def file
        File.join view_path, "#{template}.jbuilder"
      end
    end

    class Jbuilder
      attr_reader :env, :endpoint, :object

      def self.call(object, env)
        new(object, env).call
      end

      def initialize(object, env)
        @object, @env = object, env
        @endpoint     = env['api.endpoint']
      end

      def call
        # return Grape::Formatter::Json.call(object, env) unless template?
        return object unless template?
        route_info = env['rack.routing_args'][:route_info]
        # puts "========= route_info: #{route_info.inspect}"
        namespace = if route_info.route_namespace == '/'
                      ''
                    else
                      route_info.route_namespace.split(/\//).last
                    end
        view_path = "#{Goliath.root}/app/views/#{namespace}/"
        # puts "---------- namespace: #{namespace}"
        # puts "---------- view_path: #{view_path}"
        Renderer.new(view_path, template).render(endpoint, {})
      end

      def template
        env['api.template'] || endpoint.options.fetch(:route_options, {})[:action]
      end

      def template?
        !!template
      end
    end
  end
end
