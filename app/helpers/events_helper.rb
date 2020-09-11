module EventsHelper
  def edit_link(event)
    link_to 'Edit', edit_event_path(event)
  end

  def show_link(event)
    link_to 'Show', event
  end

  def destroy_link(event)
    link_to 'Destroy', event, method: :delete, data: { confirm: 'Are you sure?' }
  end

  def edit_event(current_user, event)
    link_to 'Edit', edit_event_path(event) if current_user && current_user.id == @event.user_id
  end

  def show_attendees(event)     
    @tr_content = content_tag(:div)
    event.attendees.uniq.each do |user|
      @content = content_tag(:tr)
      @content << content_tag(:td, user.name)
      @content << content_tag(:td, user.email)
      @tr_content << @content
    end
    @tr_content    
  end

  def events_list(events)
    @list_body = content_tag(:tbody)
    events.each do |event|
      @content = content_tag(:tr)
      @content << content_tag(:td, event.user_id)
      @content << content_tag(:td, event.time)
      @content << content_tag(:td, event.location)
      @content << content_tag(:td, event.title)
      @content << content_tag(:td, event.description)
      @content << content_tag(:td, show_link(event))
      if current_user && current_user.id == event.user_id
        @content << content_tag(:td, edit_link(event))
        @content << content_tag(:td, destroy_link(event))
      end
      @list_body << @content
    end
    @list_body
  end

end
