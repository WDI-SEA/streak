require_relative '../github_user_events'

namespace :github do

  desc "Create leaderboard entries based on recent commits"
  task leaderboard: :environment do
    puts "Creating leaderboard from user events..."

    User.subscribed.each do |user|
      return unless user.username?

      events = GithubUserEvents.new(user.username)

      pull_requests = events.opened_pull_requests
      commits = events.commits
      last_push = events.last_push_date

      puts "#{user.username} has #{commits} commits and #{pull_requests} PRs."
      puts "Last push: #{last_push}"

      user.snapshots.create(
        pull_requests: pull_requests,
        commits: commits,
        last_push: last_push
      )
    end

    puts "Done"
  end

  desc "Sends emails to active Github users who haven't pushed recently"
  task notify: :environment do
    puts "Sending emails to users who haven't pushed recently..."
    puts "No threshold provided" unless ENV['PUSH_DAYS_THRESHOLD']

    day_threshold = ENV['PUSH_DAYS_THRESHOLD'].to_i.days.ago
    User.subscribed.each do |user|
      last_push_date = user.last_snapshot.last_push
      recently_notified = user.last_notified > 3.days.ago if user.last_notified
      puts "#{recently_notified}"

      email_should_be_sent = last_push_date < day_threshold && !recently_notified

      if email_should_be_sent
        UserMailer.commit_alert(user).deliver_now
        user.update(last_notified: DateTime.now)
      end
    end

    puts "Done"
  end

  desc "Sends weekly emails to active Github users if they haven't been emailed recently"
  task weekly_update: :environment do
    puts "Sending weekly emails to active users who haven't been emailed recently"

    users_to_notify = User.subscribed.where('last_notified < ?', 1.week.ago)

    users_to_notify.each do |user|
      UserMailer.weekly_update(user).deliver_now
      user.update(last_notified: DateTime.now)
    end

    puts "Done"
  end
end
