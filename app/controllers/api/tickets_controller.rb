module API
  class TicketsController < ApplicationController
    before_action :set_project
    before_action :authenticate_user

    attr_reader :current_user

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

    def authenticate_user
      authenticate_with_http_token do |token|
        @current_user = User.find_by(api_key: token)
      end

      if @current_user.nil?
        render json: { 'error' => 'Unauthorized' }, status: 401
        return # blank return halts filter chain & controller actions
      end
    end

    def not_authorized
      render json: { 'error' => 'Unauthorized' }, status: 403
    end
  end
end
