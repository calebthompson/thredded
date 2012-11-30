class UserTopicRead < ActiveRecord::Base
  attr_accessible :page,
    :post_id,
    :posts_count,
    :topic_id,
    :user_id

  attr_accessor :viewing_page, :viewing_topic

  def self.statuses_for(user, topics)
    if user && topics
      topic_ids = topics.map { |topic| topic.id  }
      where('user_id = ?', user.id).find_all_by_topic_id(topic_ids)
    end
  end

  def self.update_read_status!(user, topic, page)
    user_id = user.nil? ? '0' : user.id
    page = page.nil? ? 1 : page.to_i
    post_id = topic.posts.each_slice(post_limit).to_a[page-1].last.id
    posts_count = [post_limit * page, topic.posts.size].min

    user_topic_read = find_by_user_id_and_topic_id(user_id, topic.id)

    if user_topic_read && page >= user_topic_read.page && user_topic_read.post_id != post_id
      user_topic_read.update_attributes(
        post_id: post_id,
        posts_count: posts_count,
        page: page
      )
    end
  end

  private

  def self.post_limit
    Post.default_per_page
  end
end
