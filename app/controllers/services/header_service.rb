module Services
  module HeaderService
    def add_robots_header
      response.headers["X-Robots-Tag"] = "noindex, nofollow"
    end

    def set_request_id
      if Rails.env.production?
        [Form, Page].each do |active_resource_model|
          active_resource_model.headers["X-Request-ID"] = request.request_id
        end
      end
    end
  end
end
