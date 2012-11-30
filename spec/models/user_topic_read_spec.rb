require 'spec_helper'

describe UserTopicRead do
  it { should have_db_column(:user_id) }
  it { should have_db_column(:topic_id) }
  it { should have_db_column(:post_id) }
  it { should have_db_column(:posts_count) }
  it { should have_db_column(:page) }

  it { should have_db_index(:user_id) }
  it { should have_db_index(:topic_id) }
  it { should have_db_index(:post_id) }
  it { should have_db_index(:posts_count) }
  it { should have_db_index(:page) }
end

describe UserTopicRead, '.update_read_status!' do
  describe '5 post pagination. Was page 1, 3 posts.' do
    before do
      Post.paginates_per 5
      @user = create(:user)
      @topic = create(:topic, with_posts: 3)
      @page = 1
      @old_read = create(:user_topic_read, topic_id: @topic.id, user_id: @user.id,
        post_id: @topic.posts.last.id, posts_count: 3, page: @page)
    end

    it 'back on page 1, still 3 posts - does nothing' do
      UserTopicRead.stubs(:find_by_user_id_and_topic_id).returns(@old_read)
      UserTopicRead.update_read_status!(@user, @topic, @page)

      @old_read.should have_received(:update_attributes).never
    end

    it 'now on page 1, 7 posts total - sets to page 1, 5th post' do
      4.times { @topic.posts << create(:post) }
      UserTopicRead.update_read_status!(@user, @topic, @page)
      new_read = @old_read.reload
      fifth_post = @topic.posts[4]

      new_read.post_id.should == fifth_post.id
      new_read.page.should == 1
      new_read.posts_count.should == 5
    end

    it 'now on page 2, 7 posts total - sets to page 2, 7th post' do
      @page = 2
      4.times { @topic.posts << create(:post) }
      UserTopicRead.update_read_status!(@user, @topic, @page)
      new_read = @old_read.reload
      seventh_post = @topic.posts[6]

      new_read.post_id.should == seventh_post.id
      new_read.page.should == 2
      new_read.posts_count.should == 7
    end
  end

  describe '5 post pagination. Was page 2, 7 posts.' do
    before do
      Post.paginates_per 5
    end

    it 'goes back to page 1, 7 posts total - stays page 2, 7 posts.' do
      user = create(:user)
      topic = create(:topic, with_posts: 7)
      old_read = create(:user_topic_read, topic_id: topic.id, user_id: user.id, post_id: topic.posts.last.id, posts_count: 7, page: 2)

      UserTopicRead.stubs(:find_by_user_id_and_topic_id).returns(old_read)
      UserTopicRead.update_read_status!(user, topic, 1)

      @old_read.should have_received(:update_attributes).never
    end
  end
end
