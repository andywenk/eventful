module EventsHelper

  def attribute_detail(name, value)
    label = content_tag(:span, :class => "label") do
      Event.human_attribute_name(name) + ':'
    end
    content_tag(:p, :id => name) do
      label + " " + value
    end
  end

  def link_to_event_by_application(title, event)
    query = {
      :environment => event.environment,
      :application => event.application
    }
    link_to(title, search_events_path({:search => query}))
  end

  def link_to_event_by_application_and_action(title, event)
    query = {
      :environment => event.environment,
      :application => event.application,
      :controller => event.controller,
      :action => event.action
    }
    link_to(title, search_events_path({:search => query}))
  end

  def link_to_event_by_application_and_controller(title, event)
    query = {
      :environment => event.environment,
      :application => event.application,
      :controller => event.controller
    }
    link_to(title, search_events_path({:search => query}))
  end

  def link_to_event_by_application_and_title(title, event)
    query = {
      :environment => event.environment,
      :application => event.application,
      :title => event.title
    }
    link_to(title, search_events_path({:search => query}))
  end

  def link_to_event_by_application_and_node(title, event)
    query = {
      :environment => event.environment,
      :application => event.application,
      :title => event.node
    }
    link_to(title, search_events_path({:search => query}))
  end
end
