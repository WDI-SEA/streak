# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/commit_alert
  def commit_alert
    UserMailer.commit_alert
  end

  # Preview this email at http://localhost:3000/rails/mailers/user/weekly_update
  def weekly_update
    UserMailer.weekly_update
  end

end
