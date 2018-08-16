class CommentsController < ApplicationController
  before_action :set_ticket

  def create
    @comment = @ticket.comments.new(whitelist_params)
    @comment.author = current_user
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to project_ticket_path(@ticket.project, @ticket)
    else
      flash.now[:alert] = "Comment has not been created."
      @project = @ticket.project
      render 'tickets/show'
    end
  end

  private

  def whitelist_params
    whitelisted_params = comment_params
    unless policy(@ticket).change_state?
      whitelisted_params.delete(:state_id)
    end
    whitelisted_params
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id)
  end
end
