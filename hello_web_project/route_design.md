## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  return names
  method: GET
  path: /names
  Query paramaters:
    name (string)

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:
GET /names
# Expected response status:
Response for 200 OK
```

```
# Request:
GET /names
# Expected response body:
"Julia, Mary, Karim"
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb
require "spec_helper"
describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }
  context "GET /names" do
    it 'returns a list of names OK' do
      # Assuming names exist
      response = get('/names')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route