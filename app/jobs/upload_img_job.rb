# class UploadImgJob < ActiveJob::Base
#   queue_as :upload_img_to_aliyun
#
#   # after_perform do |job|
#   #   update_photos_collection(job.arguments.first)
#   # end
#
#   def perform(attachment)
#     attachment.remote_store
#   end
#
#   # private
#
#   # def update_photos_collection(obj)
#   #   if obj.respond_to?(:photos_collection) and  obj.photos_collection.present?
#   #     obj.update_photos_collection unless obj.photos_collection.first.match(/aliyun/)
#   #   end
#   # end
# end
