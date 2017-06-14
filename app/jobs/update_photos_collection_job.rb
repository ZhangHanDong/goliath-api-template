# class UpdatePhotosCollectionJob < ActiveJob::Base
#   queue_as :default
#
#   def perform(obj)
#     if obj.photos_collection.present?
#       obj.update_photos_collection unless obj.photos_collection.first.match(/aliyun/)
#     end
#   end
#
# end
