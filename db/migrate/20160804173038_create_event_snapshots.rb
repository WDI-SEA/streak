class CreateEventSnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :event_snapshots do |t|
      t.integer :pull_requests
      t.integer :commits
      t.datetime :last_push
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
