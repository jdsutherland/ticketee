module API
  class TicketsController < API::ApplicationController
    before_action :set_project

    def show
      @ticket = @project.tickets.find(params[:id])
      authorize @ticket
      render json: @ticket
    end

    def create
      @ticket = @project.tickets.new(ticket_params)
      authorize @ticket
      if @ticket.save
        render json: @ticket, status: 201
      else
        render json: { errors: @ticket.errors.full_messages }, status: 422
      end
    end

    private

    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
  end
end
