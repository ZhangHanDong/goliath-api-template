module Helpers
  module Jbuilder

    def render_template(template)
      env['api.template'] = template
    end

    def render_errors(message={})
      ::Jbuilder.encode do |json|
        if message.blank?
          json.status -1
        else
          json.status -1
          json.error {json.(message, :code, :message)}
        end
      end
    end

    def render_options(options={})
      ::Jbuilder.encode do |json|
        options.each {|k, v| json.set!(k, v)}
      end
    end

  end
end
