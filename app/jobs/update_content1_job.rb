# class UpdateContent1Job < ActiveJob::Base
#   queue_as :default
#
#   def perform(comment, content_1, post_photo_ids)
#
#     if post_photo_ids and post_photo_ids.split(",").size > 0
#       post_photo_ids.split(",").each do |post_photo_id|
#         post_photo = PostPhoto.find post_photo_id
#         post_photo.remote_store unless post_photo.storage.match(/aliyun/)
#       end
#     end
#     content = Comment.content_to_html(content_1, post_photo_ids)
#     comment.update_attributes(content_1: content.join)
#   end
# end
