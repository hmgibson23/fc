require "net/http"
require "uri"

require_relative '../util/helpers'
require_relative '../globals'

class OfferAction < Cramp::Action
  # set up our view - this is a little crude but
  # comes with not using a full framework
  @@views = {}

  Dir[File.join(File.dirname(__FILE__), "../views/*.erb")].each do |f|
    @@views[File.basename(f, '.erb')] = ERB.new(File.read(f))
  end

  before_start :check_offers_template

  def check_offers_template
    file = 'offers'

    if @@views.has_key?(file)
      @template = @@views[file]
      yield
    else
      halt 404
    end
  end

  def start
    passed_params = { :uid => params[:uid],
                      :pub0 => params[:pub0],
                      :page => params[:page],
                      :timestamp => Time.now.to_i
                    }

    # merge the params and generate a hash
    complete_params = passed_params.merge(FIXED_PARAMS)
    complete_params[:hashkey] = generateHash(complete_params, API_KEY)


    # make the request and check it's valid
    request_uri = OFFER_URI + parameterize(complete_params)
    uri = URI.parse(request_uri)

    response = Net::HTTP.get_response(uri)

    valid_response = checkHash(API_KEY, response.body, response["X-Sponsorpay-Response-Signature"])

    # access denied if there's no valid response
    if !valid_response
      halt 403
    end

    @offers = JSON.parse(response.body)["offers"]

    render @template.result(binding)
    finish
  end

  def respond_with
    [200, {'Content-Type' => 'text/html'}]
  end
end
