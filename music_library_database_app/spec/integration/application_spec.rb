require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums/new" do
    it "returns the page with form" do
      response = get('/albums/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an album</h1>')
      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end

  context "GET /albums/:id" do
    it "returns html containing album information" do
      response = get('/albums/1')
      expect(response.body).to include ('Doolittle')
      expect(response.body).to include ('Release year: 1989')
      expect(response.body).to include ('Artist: Pixies')
    end
  end

  context "GET /albums" do
    it "returns all albums and links to individual albums" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Albums</h1>')
      expect(response.body).to include ('Title: Surfer Rosa')
      expect(response.body).to include ('Released: 1988')  
      expect(response.body).to include ('<a href="/albums/3')
      expect(response.body).to include ('<a href="/albums/6')
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
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include('Taylor Swift')
      expect(response.body).to include('<a href="/artists/1')
      expect(response.body).to include('<a href="/artists/3')
    end
  end

  context "POST /artists" do
    it 'returns 200 OK' do
      response = post('/artists', name: 'Joji', genre: 'R&B')
      expect(response.status).to eq(200)
      get_response = get('/artists')
      expect(get_response.body).to include("Joji")
    end

    it "creates a new artist and redirects to the artists page" do
      response = post(
        "/artists",
        name: "Erik Satie",
        genre: "classical"
      )
      expect(response.status).to eq(200)
      response = get('/artists')
      expect(response.body).to include("Erik Satie")
    end
  end

  context "GET /artists/new" do
    it "returns the page with form" do
      response = get('/artists/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an artist</h1>')
      expect(response.body).to include('<form action="/artists" method="POST">')
    end
  end

  context "GET /artists/:id" do
    it "returns html containing artist information" do
      response = get('/artists/2')
      expect(response.body).to include ('ABBA')
      expect(response.body).to include ('Pop')
    end
  end
end