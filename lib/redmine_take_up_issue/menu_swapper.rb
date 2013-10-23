# -*- encoding: utf-8 -*-

module RedmineTakeUpIssue
  class MenuSwapper
    class << self
      def swap_new_issue
        Redmine::MenuManager.map :project_menu do |menu|
          # Delete "New Issue" menu item
          menu.delete(:new_issue)

          # Copy from Redmine 2.3.0 lib/redmine.rb line:243-244
          menu.push :new_issue,
                    { :controller => 'take_up_issues', :action => 'new', :copy_from => nil },
                    :param => :project_id, :caption => :label_issue_new,
                    :html => { :accesskey => Redmine::AccessKeys.key_for(:new_issue) }

        end
      end
    end
  end
end
