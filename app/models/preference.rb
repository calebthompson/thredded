class Preference < ActiveRecord::Base
  attr_accessible :notify_on_mention, :notify_on_message
end
