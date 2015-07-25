require "net/http"
require "uri"

API_KEY="b07a12df7d52e6c118e5d47d3f9e60135b109a1f"

# helper function to generate the url params
def parameterize(params)
  URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
end

FIXED_PARAMS = { :appid => 157,
                 :format => "json",
                 :device_id => "2b6f0cc904d137be2e1730235f5664094b83",
                 :locale => "de",
                 :ip => "109.235.143.113",
                 :offer_types => 112
               }


# use string interpolation to build an initial request uri
OFFER_URI="http://api.sponsorpay.com/feed/v1/offers.json?"

class OfferAction < Cramp::Action
  def start
    passed_params = { :uid => params[:uid],
                      :pub0 => params[:pub0],
                      :page => params[:page]
                    }


    res = { :received => params,
            :req_uri => OFFER_URI + parameterize(FIXED_PARAMS) + parameterize(passed_params) }.to_json
    render res
    finish
  end

  def respond_with
    [200, {'Content-Type' => 'application/json'}]
  end
end
