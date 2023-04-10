module Api
  module V1
    class AccountsController < ApiController

      before_action :set_account, only: %i[ balance ]

      def index
        @accounts = @current_user.accounts
        render json: {User: @current_user.as_json.merge( accounts: @accounts)}
      end

      def balance
        latest_transactions = @account.latest_transactions
        render json: {Account: @account.as_json(except: [:created_at, :updated_at, :id, :user_id]).merge( Transactions: latest_transactions.as_json(except: [:id, :sender_id, :recipient_id, :updated_at]))}
      end


      def create
        begin
          @account = Account.new(account_params)
          if @account.save
            render json: {Account: @account.as_json.merge(user: @current_user)}, status: :created
          else
            render json: @account.errors, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { error: e }
        end
      end

      def destroy
        @account.destroy
      end

      private

      def set_account
        @account = Account.includes(:recipient_transactions, :sender_transactions).find_by(account_number: params[:account_number])
      end

      def account_params
        params.permit(:user_id, :account_type, :account_number, :balance).merge(user_id: @current_user.id)
      end
    end
  end
end


