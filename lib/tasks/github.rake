require_relative '../github_user_events'

namespace :github do

  desc "Create leaderboard entries based on recent commits"
  task leaderboard: :environment do
    puts "Creating leaderboard from user events..."

    User.subscribed.each do |user|
      return unless user.username?

      events = GithubUserEvents.new(user.username)

      user.snapshot.delete if user.snapshot
      user.create_event_snapshot(
        pull_requests: events.opened_pull_requests,
        commits: events.commits,
        last_push: events.last_push_date
      )
    end

    puts "Done"
  end

  desc "Sends weekly emails to active and subscribed Github users"
  task notify: :environment do
    puts "Sending weekly emails to active and subscribed users"

    User.subscribed.each do |user|
      send_weekly_alert = user.snapshot &&
                          !user.snapshot.last_push.nil? &&
                          user.snapshot.last_push > 1.week.ago

      if send_weekly_alert
        UserMailer.weekly_update(user).deliver_now
      else
        UserMailer.commit_alert(user).deliver_now
      end

      user.update(last_notified: DateTime.now)
    end

    puts "Done"
  end
end
