class Admin::MessageboardsController < ApplicationController
  load_and_authorize_resource
  before_filter :messageboard, :only => :show
  
  def index
    redirect_to new_user_session_url(:host => site.cached_domain) unless can? :read, site
  end

  def edit
    @messageboard = Messageboard.find(params[:id])
  end

  def update
    messageboard.update_attributes(params[:messageboard])
    redirect_to edit_admin_site_messageboard_path(site.id, messageboard.id)
  end
  # ======================================

end