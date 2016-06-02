require "faraday"
require 'json'

BASE_URL = "http://localhost:3000"
API_KEY = "d3603b291dad86fd61ceab1c09af513c3b69802387a0f013c11365813ae8a70"

conn = Faraday.new(url: BASE_URL) do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

response = conn.get "/api/v1/campaigns?api_key=#{API_KEY}"

campaigns = JSON.parse(response.body)

campaigns.each do |campaign|
  puts campaign["title"]
end
