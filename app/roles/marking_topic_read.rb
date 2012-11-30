module MarkingTopicRead
  def find_or_create_user_topic_read(user, topic, page)
    if user
      user_topic_read = find_by_user_id_and_topic_id(user.id, topic.id)

      if user_topic_read.blank?
        posts_count = [post_limit * (page - 1), topic.posts.size].min
        last_post = topic.posts.each_slice(post_limit).to_a[page - 1].first

        user_topic_read = create(
          user_id: user.id,
          topic_id: topic.id,
          post_id: last_post.id,
          posts_count: posts_count,
          page: page
        )
      end

      user_topic_read
    else
      NullTopicRead.new
    end
  end

  private

  def self.post_limit
    Post.default_per_page
  end
end
