# README


# Setup

Fork and Clone this Repo

Once on your local, `bundle install`.

In your terminal:
- Run `bundle exec rspec` to make sure all of your tests are passing.
- `rails db:{drop,create,seed,migrate}`

### Testing

- `bundle exec rspec` will run all of the tests at once 
- If you want to run only a specific file use the following syntax: `bundle exec rspec spec/facades/geolocation_facade_spec.rb`
  -  Add `:11` to the end of the previous line if you only want to run the test starting on line 11. 
- If you are creating new requests to your local host delete the older vcr_cassettes to have more accurate responses. `spec/fixtures/vcr_cassettes` right click and delete `vcr_cassettes`.
- For the SimpleCov coverage report in the terminal run `open coverage/index.html`

<br>

# APIs

[![WeatherAPI](https://cdn.weatherapi.com/v4/images/weatherapi_logo.png)](https://www.weatherapi.com/)
[![MapQuest](image-1.png)](https://developer.mapquest.com/)
[![Yelp Developer API](image-3.png)](https://www.yelp.com/)

<br>

# Gems and testing 
- [Faraday](https://github.com/lostisland/faraday) gem to interact with APIs
- [JSONAPI Serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) gem for formatting JSON responses
- [Pry](https://github.com/pry/pry) gem for debugging
- [Rspec-Rails](https://github.com/rspec/rspec-rails) Base of all testing in this Repo
- [Launchy](https://github.com/copiousfreetime/launchy) gem for inspection and debugging
- [Capybara](https://github.com/morris-lab/Capybara) gem for end to end testing 
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) gem for testing assertions
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem for code coverage tracking
- [VCR](https://github.com/vcr/vcr) / [Webmock](https://github.com/bblimke/webmock) to stub HTTP requests in tests to simulate API interactions
- [Postman](https://www.postman.com/) to check API endpoints

<br>

# Postman Suite <a href="https://www.postman.com/" title="Postman"> ![Alt text](image-2.png)</a>

The entire Postman suite is linked [Here](https://www.postman.com/workspace/558c3e53-ddb4-4057-a00c-5e7fd3e90047/collection/31390544-82f83717-91b3-46b3-9647-2eae6e64861c). Follow along to test the returns from the external APIs and the reponses that you are getting from your localhost API calls. 

<br>

# Learning Goals

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
- Implementing the pillars of OOP.
- Creating a Postman suite boasting Happy and Sad path testing.
- Thorough testing of Controllers, Facades, Services, Serializers, and exposed API endpoints.