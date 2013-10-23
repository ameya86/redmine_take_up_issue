# -*- encoding: utf-8 -*-
require_dependency 'application_helper'

module RedmineTakeUpIssue
  module ApplicationHelperPatch
    def self.included(base) # :nodoc:
      #base.extend(ClassMethods) # self.method

      base.send(:include, InstanceMethods) # obj.method

      base.class_eval do
        alias_method_chain :link_to_issue, :take_up
      end
    end

    #module ClassMethods # self.method
    #end

    module InstanceMethods # obj.method
      def link_to_issue_with_take_up(issue, options={})
        title = nil
        subject = nil
        text = options[:tracker] == false ? "##{issue.id}" : "#{issue.tracker} ##{issue.id}"
        if options[:subject] == false
          title = truncate(issue.subject, :length => 60)
        else
          subject = issue.subject
          if options[:truncate]
            subject = truncate(subject, :length => options[:truncate])
          end
        end
        s = link_to(text, {:controller => 'take_up_issues', :action => 'show', :id => issue.id},
                           :remote => true,
                           :class => issue.css_classes, :title => title)
        s << h(": #{subject}") if subject
        s = h("#{issue.project} - ") + s if options[:project]
        return s
      end
    end
  end
end

ApplicationHelper.send(:include, RedmineTakeUpIssue::ApplicationHelperPatch)
