module TweetHelper
  require 'uri'
  require 'net/http'

  # URL
  SITE = 'https://arcane-ravine-29792.herokuapp.com'

  # 認可エンドポイント
  POST_PATH = '/api/tweets'

  def post_tweet
    uri = URI.parse(SITE+POST_PATH)
    http = Net::HTTP.new(uri.host, uri.port)
    
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Authorization"] = "bearer #{session[:unifa_token]['access_token']}"
    req["Content-Type"] = "application/json"
    
    data = {
      text: params[:text],
      url: request.base_url+params[:url]
    }.to_json
    
    req.body = data
    res = http.request(req)
    
    puts res.code, res.msg, res.body
  end
end