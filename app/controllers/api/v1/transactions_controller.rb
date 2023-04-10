module Api
  module V1
    class TransactionsController < ApiController

      before_action :set_transaction, only: %i[ destroy ]

      def index
        @transactions = Transaction.all
        render json: @transactions
      end

      def create
        begin
          service = CreateFundsService.new(transaction_params).call
          render json: service, status: :created
        rescue StandardError => e
          render json: { error: e }
        end
      end

      def destroy
        @transaction.destroy
      end

      private

      def set_transaction
        @transaction = Transaction.find(params[:id])
      end

      def transaction_params
        params.permit(:amount, :purpose, :sender_account_number, :recipient_account_number)
      end

    end
  end
end
