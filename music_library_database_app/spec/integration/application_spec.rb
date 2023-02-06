require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns all albums" do
      response = get('/albums')
      expect(response.body).to include('Ring Ring')
    end
  end

  context "POST /albums" do
    it 'returns 200 OK' do
      response = post('/albums', title: 'Blue Slide Park', release_year: '2011', artist_id: '5')
      expect(response.status).to eq(200)
      response = get('/albums')
      expect(response.body).to include("Blue Slide Park")
    end
  end

  context "GET /artists" do
    it "returns all artists" do
      response = get('/artists')
      expect(response.body).to include('ABBA')
      expect(response.body).to include('pop')
      expect(response.body).to include('Mac Miller')
    end
  end

  context "POST /artists" do
    it 'returns 200 OK' do
      response = post('/artists', name: 'Joji', genre: 'R&B')
      expect(response.status).to eq(200)
      response = get('/artists')
      expect(response.body).to include("Joji")
    end
  end
end