require "sinatra"
require "json"
require "net/http"

post '/' do
  requested_number = JSON.parse(request.body.read)["request"]["intent"]["slots"]["number"]["value"]
  puts requested_number
  number_facts_uri = URI("http://numbersapi.com/#{requested_number.to_i}")
  number_fact = Net::HTTP.get(number_facts_uri)
  {
    version: "1.0",
    response: {
      outputSpeech: {
        type: "SSML",
        # ssml: "<speak> You know what! <amazon:effect name='whispered'>#{number_fact}</amazon:effect> </speak>"
        ssml: "<speak> #{number_fact} </speak>"
      }
    }
  }.to_json
end
