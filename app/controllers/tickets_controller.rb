class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
    authorize @ticket, :create?
    @ticket.attachments.build
  end

  def show
    authorize @ticket
    @comment = @ticket.comments.new(state_id: @ticket.state_id)
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    # TODO: this blows up if not logged in - use 'Null Object'
    @ticket.author = current_user
    authorize @ticket

    if @ticket.save
      flash[:notice] = "Ticket has been successfully created."
      redirect_to [@project, @ticket]
    else
      flash.now[:alert] = "Ticket has not been created."
      render 'new'
    end
  end

  def edit
    authorize @ticket, :update?
  end

  def update
    authorize @ticket

    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been updated."
      render 'edit'
    end
  end

  def destroy
    authorize @ticket
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."

    redirect_to @project
  end

  private

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description, :tag_names,
                                   attachments_attributes: %i[file file_cache])
  end
end
