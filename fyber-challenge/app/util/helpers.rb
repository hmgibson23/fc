require "uri"
require 'digest/sha1'

# helper function to generate the url params
def parameterize(params)
  URI.escape(params.sort.collect{|k,v| "#{k}=#{v}"}.join('&'))
end

p# helper to generate the hash
def generateHash(params, key)
  complete = parameterize(params) + '&' + key
  Digest::SHA1.hexdigest complete
end

def checkHash(key, body, received)
  complete = body + key
  hashed = Digest::SHA1.hexdigest complete
  hashed == received
end
