class TopicsController < ApplicationController
  before_filter :pad_params, :only => [:create, :update]
  helper_method :messageboard, :topic

  def index
    @topics = Topic.all
  end

  def show
    @post = Post.new
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = messageboard.topics.new(params[:topic])
    p = Post.new(params[:topic][:posts_attributes]["0"])
    @topic.posts << pad_post(p)
    @topic.save!
    redirect_to messageboard_topics_path(messageboard)
  end

  def edit
  end
 
  def update
    p = Post.new(params[:post])
    topic.posts << pad_post(p)
    topic.last_user = current_user
    topic.save!
  end

  # ======================================
 
  def messageboard
    @messageboard ||= Messageboard.where(:name => params[:messageboard_id]).first
  end

  def topic
    @topic ||= Topic.find(params[:id])
  end

  def current_user_name 
    @current_user_name ||= current_user.nil? ? "anonymous commenter" : current_user.name
  end

  # ======================================

  private

    def pad_params
      params[:topic][:user] = current_user_name
      params[:topic][:last_user] = current_user_name
    end

    def pad_topic(t)
      t.last_user = current_user_name
      t.post_count += 1
    end

    def pad_post(p)
      p.user = current_user_name
      p.ip = request.remote_ip
      return p
    end

end