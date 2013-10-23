# -*- encoding: utf-8 -*-

require 'redmine_take_up_issue'

Redmine::Plugin.register :redmine_take_up_issue do
  name 'Redmine Take Up Issue plugin'
  author 'OZAWA Yasuhiro'
  description 'Popup viewing issues.'
  version '0.0.1a'
  url 'https://github.com/ameya86/redmine_take_up_issue'
  author_url 'https://github.com/ameya86'

  # Copy from Redmine 2.3.0 lib/redmine.rb line:243-244
  menu :project_menu, :new_issue2,
                      { :controller => 'take_up_issues', :action => 'new', :copy_from => nil },
                      :param => :project_id,
                      :caption => :label_issue_new,
                      :after => :new_issue,
                      :html => {
                        :accesskey => Redmine::AccessKeys.key_for(:new_issue),
                        'data-remote' => true,
                        'data-method' => 'get',
                      }

  # Delete "New Issue" menu item
  Redmine::MenuManager.map :project_menu do |menu|
    menu.delete(:new_issue)
  end

  #project_module :issue_tracking do
    permission :add_issues2, { :take_up_issues => [ :new, :show, :edit, :update, :create, :index ] }
  #end
end
