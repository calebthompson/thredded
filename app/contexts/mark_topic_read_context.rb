class MarkTopicReadContext
  def self.call(user, topic, page)
    UserTopicRead.find_or_create_by_user_and_topic(user, topic, page)
  end
end
