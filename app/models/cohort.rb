class Cohort < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true, length: { in: 5..40 }
  validates :description, presence: true

  def users_by_last_push
    users.includes(:event_snapshot).order('event_snapshots.last_push DESC NULLS LAST')
  end
end
