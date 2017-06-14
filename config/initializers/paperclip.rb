ActiveRecord::Base.send :include, Paperclip::Glue

Paperclip::Attachment.default_options.merge!(
  :path                  => "#{Goliath.root}/public/upload/:class/:attachment/:id_partition/:id/:style.:extension",
  :url                   => "/upload/:class/:attachment/:id_partition/:id/:style.:extension",
  :default_url           => "/assets/missing/:class/:attachment/:style.png"
  # :preserve_files        => true
)

Paperclip.options[:command_path]='/usr/local/imagemagick/bin' if Goliath.env?(:production)
Paperclip.options[:command_path]='/usr/bin' if Goliath.env?(:development)

module Paperclip
  class HashieMashUploadedFileAdapter < AbstractAdapter

    def initialize(target)
      @tempfile, @content_type, @size = target.tempfile, target.type, target.tempfile.size
      self.original_filename = target.filename
    end

  end

  class Geometry
    def cropping dst, ratio, scale
      if ratio.horizontal? || ratio.square?
        "%dx%d+%d+%d" % [ dst.width, dst.height, 0, 0 ]
      else
        "%dx%d+%d+%d" % [ dst.width, dst.height, (self.width * scale - dst.width) / 2, 0 ]
      end
    end
  end


end

Paperclip.io_adapters.register Paperclip::HashieMashUploadedFileAdapter do |target|
  target.is_a? Hashie::Mash
end

Paperclip::Attachment.send(:include, Paperclip::Meta::Attachment)
