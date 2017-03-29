Houston::Tickets::Engine.routes.draw do

  get "tickets/:id", to: "tickets#show"
  put "tickets/:id", to: "tickets#update"
  delete "tickets/:id/close", to: "tickets#close"
  delete "tickets/:id/reopen", to: "tickets#reopen"

  scope "projects/:slug" do
    get "tickets", to: "project_tickets#index", as: :project_tickets
    get "tickets/open", to: "project_tickets#open", as: :project_open_tickets

    get "bugs", to: "project_tickets#bugs", as: :project_bugs
    get "bugs/open", to: "project_tickets#open_bugs", as: :project_open_bugs
    get "ideas", to: "project_tickets#ideas", as: :project_ideas
    get "ideas/open", to: "project_tickets#open_ideas", as: :project_open_ideas

    get "tickets/by_number/:number", to: "project_tickets#show", as: :project_ticket
    post "tickets/by_number/:number/close", to: "project_tickets#close", as: :close_ticket
    post "tickets/by_number/:number/reopen", to: "project_tickets#reopen", as: :reopen_ticket

    get "tickets/new", to: "project_tickets#new", as: :new_ticket
    post "tickets", to: "project_tickets#create"
  end

  scope "projects/:slug" do
    get "tickets/sync", to: "project_tickets_sync#show", as: :project_tickets_sync
    post "tickets/sync", to: "project_tickets_sync#create"
  end



  put "tasks/:id", :to => "tasks#update", constraints: {id: /\d+/}
  put "tasks/:id/complete", :to => "tasks#complete", constraints: {id: /\d+/}
  put "tasks/:id/reopen", :to => "tasks#reopen", constraints: {id: /\d+/}



  namespace "api" do
    namespace "v1" do
      scope "projects/:slug" do
        scope "tickets/by_number/:number" do
          get "tasks", to: "ticket_tasks#index"
          post "tasks", to: "ticket_tasks#create"
          put "tasks/:id", to: "ticket_tasks#update"
          delete "tasks/:id", to: "ticket_tasks#destroy"
        end
      end
    end
  end

end
