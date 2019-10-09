require 'rails_helper'

RSpec.describe "Events", type: :request do
  before(:all) do
    Rails.application.load_seed
  end

  after(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  describe "GET /events.json" do
    it "returns a 200 status" do
      get '/events.json'
      expect(response).to have_http_status(200)
    end
  end

  describe "when GET /events.json?from=2020-01-01 request is made" do
    it "returns exactly 1 item" do
      get '/events.json?from=2020-01-01'
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
