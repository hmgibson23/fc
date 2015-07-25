# Check out https://github.com/joshbuddy/http_router for more information on HttpRouter
def app_routes
  Rack::Builder.new do
    use Rack::Session::Cookie

    routes = HttpRouter.new do
      post('/').to(HomeAction)
      get('/(:file)').to(StaticAction)
    end

    file_server = Rack::File.new(File.join(File.dirname(__FILE__), '../public/'))
    run Rack::Cascade.new([file_server, routes])
  end
end
