require_relative '../github_user_events'

namespace :github do

  desc "Create leaderboard entries based on recent commits"
  task leaderboard: :environment do
    puts "Creating leaderboard from user events..."

    User.where(active: true, subscribed: true).each do |user|
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

    day_threshold = ENV['PUSH_DAYS_THRESHOLD'].to_i.days
    User.where(active: true, subscribed: true).each do |user|
      last_push_date = user.last_snapshot.last_push
      if last_push_date < day_threshold.ago
        UserMailer.commit_alert(user).deliver_now
      end
    end

    puts "Done"
  end
end
