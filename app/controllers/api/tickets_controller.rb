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

    private

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
