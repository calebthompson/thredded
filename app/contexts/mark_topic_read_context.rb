class MarkTopicReadContext
  def self.call(user, topic, page)
    page = page.nil? ? 1 : page.to_i

    UserTopicRead.extend(MarkingTopicRead)
    UserTopicRead.find_or_create_user_topic_read(user, topic, page)
  end
end

