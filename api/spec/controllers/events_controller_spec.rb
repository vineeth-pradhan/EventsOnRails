require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  it "responds with 200 status" do
    get :index
    expect(response.status).to eq(200)
  end
end
