require 'spec_helper'

describe MarkTopicReadContext, '#call' do
  let(:user) { create(:user) }

  it 'returns a null topic if user is nil' do
    topic = build_stubbed(:topic)
    status = MarkTopicReadContext.call(nil, topic, '1')

    status.should be_an_instance_of(NullTopicRead)
  end

  it 'finds an existing record' do
    user = build_stubbed(:user)
    topic = build_stubbed(:topic)
    existing_topic_read = create(:user_topic_read, topic_id: topic.id, user_id: user.id)
    user_topic_read = MarkTopicReadContext.call(user, topic, '1')

    user_topic_read.should == existing_topic_read
  end

  describe 'creating new read status for a 5 post pagination on a 7 post topic' do
    before do
      Post.paginates_per 5
    end

    it 'sets it to the 1st post on page 1' do
      page = '1'
      topic = create(:topic, with_posts: 7)
      first_post = topic.posts[0]
      user_topic_read = MarkTopicReadContext.call(user, topic, page)

      user_topic_read.post_id.should == first_post.id
      user_topic_read.posts_count.should == 0
      user_topic_read.page.should == 1
    end

    it 'sets it to the 7th post in total, 1st post on that page, in page 2' do
      page = '2'
      topic = create(:topic, with_posts: 7)
      sixth_post = topic.posts[5]
      user_topic_read = MarkTopicReadContext.call(user, topic, page)

      user_topic_read.post_id.should == sixth_post.id
      user_topic_read.posts_count.should == 5
      user_topic_read.page.should == 2
    end
  end
end

