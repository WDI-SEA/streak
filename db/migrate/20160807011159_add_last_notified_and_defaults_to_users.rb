class AddLastNotifiedAndDefaultsToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :last_notified, :datetime
    change_column :users, :admin, :boolean, default: false
    change_column :users, :active, :boolean, default: false
    change_column :users, :subscribed, :boolean, default: false
  end

  def down
    remove_column :users, :last_notified
    change_column :users, :admin, :boolean, :default => nil
    change_column :users, :active, :boolean, :default => nil
    change_column :users, :subscribed, :boolean, :default => nil
  end
end
