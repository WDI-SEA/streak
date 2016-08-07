require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "commit_alert" do
    let(:mail) { UserMailer.commit_alert }

    it "renders the headers" do
      expect(mail.subject).to eq("Commit alert")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "weekly_update" do
    let(:mail) { UserMailer.weekly_update }

    it "renders the headers" do
      expect(mail.subject).to eq("Weekly update")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
