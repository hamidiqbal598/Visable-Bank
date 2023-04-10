module Api
  module V1
    class ApiController < ApplicationController

      before_action :authenticate_user

      private

      def authenticate_user
        #Please send tokens and username in Headers to set the user
        @current_user = User.includes(:accounts).get_user(request.headers['username'],request.headers['tokens'])
        if @current_user.empty?
          # return error message with 403 HTTP status if there's no such user
          return render(json: return_error_formatted_json('Invalid User' ), status: 404)
        end
        @current_user = @current_user.first
      end

      def return_error_formatted_json(data)
        #That's our error response as per document
        { errors: [{code: "not_found", detail: data}] }
      end

    end
  end
end
