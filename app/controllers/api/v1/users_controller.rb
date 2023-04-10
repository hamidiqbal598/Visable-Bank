module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[ destroy ]

      def index
        @users = User.all
        render json: @users
      end


      def create
        begin
          @user = User.new(user_params)
          if @user.save
            render json: @user, status: :created
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { error: e }
        end
      end


      def destroy
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(:name, :email, :username, :authentication_token)
      end
    end
  end
end
