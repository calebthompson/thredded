class Preference < ActiveRecord::Base
  belongs_to :user

  attr_accessible :notify_on_mention, :notify_on_message, :notify_on_new_thread,
    :notify_on_new_post, :send_daily_digest
end
