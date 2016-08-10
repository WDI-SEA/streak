class Cohort < ApplicationRecord
  has_many :users

  def users_by_last_push
    users.includes(:event_snapshot).order('event_snapshots.last_push DESC NULLS LAST')
  end
end
