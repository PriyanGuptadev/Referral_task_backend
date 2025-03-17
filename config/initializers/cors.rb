Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change '*' to your frontend URL if needed

    resource '*',
      headers: :any,
      expose: ['access-token', 'client', 'uid'], # Expose auth headers!
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end