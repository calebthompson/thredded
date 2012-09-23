class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.boolean :notify_on_mention, :default => false, :null => false
      t.boolean :notify_on_message, :default => false, :null => false
      t.boolean :notify_on_new_thread, :default => false, :null => false
      t.boolean :notify_on_new_post, :default => false, :null => false
      t.boolean :send_daily_digest, :default => false, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    # this is why I asked if it was 1 per user
    add_index :preferences, :user_id, {:unique => true}
  end
end
