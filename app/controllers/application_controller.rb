#---
# Excerpted from "Agile Web Development with Rails 7",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/rails7 for more book information.
#---
class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  # ...
  before_action :authorize

    # ...

  protected

    def authorize
      if [Mime[:html], Mime[:turbo_stream]].include? request.format
        unless User.find_by(id: session[:user_id])
          redirect_to login_url, notice: "Please log in"
        end
      else
        authenticate_or_request_with_http_basic do |username, password|
          user = User.find_by(name: username)
          user && user.authenticate(password)
        end
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = 
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
end