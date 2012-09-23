require 'spec_helper'

describe Preference do

  it { should belong_to :user }

  it { should have_db_column(:notify_on_mention) }
  it { should have_db_column(:notify_on_message) }
  it { should have_db_column(:notify_on_new_thread) }
  it { should have_db_column(:notify_on_new_post) }
  it { should have_db_column(:send_daily_digest) }

  it { should allow_mass_assignment_of(:notify_on_mention) }
  it { should allow_mass_assignment_of(:notify_on_message) }
  it { should allow_mass_assignment_of(:notify_on_new_thread) }
  it { should allow_mass_assignment_of(:notify_on_new_post) }
  it { should allow_mass_assignment_of(:send_daily_digest) }

  it { should_not allow_mass_assignment_of(:user_id) }

  it { should have_db_index(:user_id) }

  describe "#create" do 
    it "should associate between preference and user" do
      @pref = Preference.new
      @shaun = create(:user, preference: @pref)
      @shaun.preference.notify_on_new_thread.should be false
      @shaun.preference.notify_on_new_post.should be false
    end
  end

end
