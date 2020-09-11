module EventsHelper
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
end
