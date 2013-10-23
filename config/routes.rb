# -*- encoding: utf-8 -*-
RedmineApp::Application.routes.draw do
  get 'projects/:project_id/take_up_issues/new', :to => 'take_up_issues#new'
  get 'projects/:project_id/take_up_issues/:id', :to => 'take_up_issues#show'
end
