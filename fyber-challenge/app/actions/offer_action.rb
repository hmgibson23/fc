require "net/http"
require "uri"
require 'digest/sha1'


# the constants
OFFER_URI="http://api.sponsorpay.com/feed/v1/offers.json?"
API_KEY="b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
FIXED_PARAMS = { :appid => 157,
                 :format => "json",
                 :device_id => "2b6f0cc904d137be2e1730235f5664094b83",
                 :locale => "de",
                 :ip => "109.235.143.113",
                 :offer_types => 112
               }

# helper function to generate the url params
def parameterize(params)
  URI.escape(params.sort.collect{|k,v| "#{k}=#{v}"}.join('&'))
end

# helper to generate the hash
def generateHash(params)
  complete = parameterize(params) + '&' + API_KEY
  Digest::SHA1.hexdigest complete
end

class OfferAction < Cramp::Action
  def start
    passed_params = { :uid => params[:uid],
                      :pub0 => params[:pub0],
                      :page => params[:page],
                      :timestamp => Time.now.to_i
                    }

    complete_params = passed_params.merge(FIXED_PARAMS)
    complete_params[:hashkey] = generateHash(complete_params)

    request_uri = OFFER_URI + parameterize(complete_params)

    res = { :req_uri =>  request_uri }.to_json
    render res
    finish
  end

  def respond_with
    [200, {'Content-Type' => 'application/json'}]
  end
end
