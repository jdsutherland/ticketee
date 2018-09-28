require "rails_helper"

RSpec.describe "Tickets API" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:state) { FactoryGirl.create(:state, name: "Open") }
  let(:ticket) do
    FactoryGirl.create(:ticket, project: project, state: state)
  end

  before do
    assign_role!(user, :manager, project)
    user.generate_api_key
  end

  context "as an authenticated user" do
    let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end

    it "retrieves a ticket's information" do
      get api_project_ticket_path(project, ticket, format: :json), {}, headers

      expect(response.status).to eq 200
      expect(response.body).to eq TicketSerializer.new(ticket).to_json
    end

    context "without permission to view the project" do
      before do
        user.roles.delete_all
      end

      it "responds with a 403" do
        get api_project_ticket_path(project, ticket, format: "json"),
            {}, headers

        expect(response.status).to eq 403
        error = { "error" => "Unauthorized" }
        expect(JSON.parse(response.body)).to eq error
      end
    end
  end

  context "as an unauthenticated user" do
    it "responds with a 401" do
      get api_project_ticket_path(project, ticket, format: :json)

      expect(response.status).to eq 401
      error = { 'error' => 'Unauthorized' }
      expect(JSON.parse(response.body)).to eq error
    end
  end
end
