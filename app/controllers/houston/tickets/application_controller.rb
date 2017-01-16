module Houston::Tickets
  class ApplicationController < ::ApplicationController
    layout "houston/tickets/application"

    rescue_from Github::Unauthorized do |exception|
      session["user.return_to"] = request.referer
      if request.xhr?
        head 401, "X-Credentials" => "Oauth", "Location" => main_app.oauth_consumer_path(id: "github")
      else
        redirect_to main_app.oauth_consumer_path(id: "github")
      end
    end

  end
end
