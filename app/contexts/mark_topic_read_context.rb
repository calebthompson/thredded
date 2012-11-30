class MarkTopicReadContext
  def self.call(user, topic, page)
    new(user, topic, page).call
  end

  def initialize(user, topic, page)
    @user = user
    @topic = topic
    @page = page.nil? ? 1 : page.to_i
  end

  def call
    find_or_create_user_topic_read
  end

  private

  def find_or_create_user_topic_read
    if @user
      user_topic_read = UserTopicRead.find_by_user_id_and_topic_id(@user.id, @topic.id)

      if user_topic_read.blank?
        posts_count = [post_limit * (@page - 1), @topic.posts.size].min
        last_post = @topic.posts.each_slice(post_limit).to_a[@page - 1].first

        user_topic_read = UserTopicRead.create(
          user_id: @user.id,
          topic_id: @topic.id,
          post_id: last_post.id,
          posts_count: posts_count,
          page: @page
        )
      end

      user_topic_read
    else
      NullTopicRead.new
    end
  end

  def post_limit
    Post.default_per_page
  end
end
