class GithubUserEvents
  def initialize(username)
    @username = username
    get_events
  end

  def get_events
    query = {
      client_id: ENV['GITHUB_ID'],
      client_secret: ENV['GITHUB_SECRET']
    }
    url = "https://api.github.com/users/#{@username}/events"

    @data = HTTParty.get(url, :query => query)
  end

  def of_type(event_type)
    @data.select { |event| event['type'] == event_type }
  end

  def opened_pull_requests
    self.of_type('PullRequestEvent').count do |event|
      event['payload']['action'] == 'opened'
    end
  end

  def commits
    self.of_type('PushEvent').inject(0) do |total, event|
      total + event['payload']['size']
    end
  end

  def last_push_date
    last_push_event = self.of_type('PushEvent').max do |a, b|
      last_date = DateTime.parse(a['created_at'])
      next_date = DateTime.parse(b['created_at'])
      last_date <=> next_date
    end
    if last_push_event
      DateTime.parse(last_push_event['created_at'])
    else
      nil
    end
  end
end

