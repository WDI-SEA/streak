class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :rememberable, :trackable,
         :validatable, :omniauthable, :omniauth_providers => [:github]

  # Associations and aliases
  belongs_to :cohort
  has_many :event_snapshots
  alias_attribute :snapshots, :event_snapshots

  # Scopes
  # note that a user who is subscribed will receive emails
  # note that a user who is active will be able to view the leaderboard and other app data
  scope :subscribed, -> { where(active: true, subscribed: true) }

  # Set a default last notified date when an instance is created
  before_create do
    self.last_notified = DateTime.now if self.last_notified.blank?
  end

  # Instance methods
  def last_snapshot
    snapshots.order(created_at: :desc).first
  end

  # Omniauth methods
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.username = auth.info.nickname
      user.subscribed = true
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.github_data'] && session['devise.github_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
