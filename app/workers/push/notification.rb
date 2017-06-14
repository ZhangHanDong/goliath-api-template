module Push
  class Notification
    @queue = :xmpush

    def self.perform(user_id)
      extra = {push_type: :notifications}
      user = User.cache_find user_id
      ::Notification.xmpush(user_id, "通知", "您有一条新通知！", user.android_switch, extra.merge!(user.ios_switch))
    end

  end
end
