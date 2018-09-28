class API::TicketsController < ApplicationController
  def show
    @ticket = Ticket.find(params[:id])
    authorize @ticket
    format.json  { render json: @ticket }
  end
end
