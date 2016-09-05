require 'redmine'
require_dependency 'projects_helper'
require_dependency 'application_helper'

Redmine::Plugin.register :redmine_wia do
  name 'Redmine Wia plugin'
  author 'Nuno Carvalho'
  description 'This is a plugin for Redmine to customize.'
  version '0.0.1'
  url 'http://lean.wrightia.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  Redmine::WikiFormatting::Macros.macro :my_news, :desc => 'Create a list of news from the user projects. Example:\n\n {{my_news()}}.' do |obj, args|
      news_items = News.visible.
        where(:project_id => User.current.projects.map(&:id)).
        limit(10).
        includes(:project, :author).
        references(:project, :author).
        order("#{News.table_name}.created_on DESC").
        to_a
      render :partial => 'news/news', :collection => news_items
  end

  module RedmineContactsNoteTypes
    class HelpersNotesHook < Redmine::Hook::ViewListener     
      def helper_notes_note_type_label(context={})
        context[:note_types] << ["Proposal", 4]
      end  
      def helper_notes_note_type_tag(context={})
        context[:type_tag] << content_tag('span', '', :class => "icon icon-attachment", :title => "Proposal") if context[:type_id] == 4
      end  
    end
  end
end
