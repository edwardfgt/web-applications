# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  POST
  /albums
  body parameters:
  title:
  release_year:
  artist_id:

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 
_


```

## 3. Write Examples


```
# Request:

POST /albums

with body parameters:
title: "Blue Slide Park":
release_year: 2011
artist_id="5"


# Expected response:

Response for 200 OK
No content, create new album in database


## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it 'returns 200 OK' do
      response = post('/albums', title: 'Blue Slide Park', release_year: '2011', artist_id = '5')
      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
