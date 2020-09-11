module UsersHelper
  def edit_user(current_user, user)
    link_to 'Edit', edit_user_path(user) if current_user && current_user.id == user.id
  end

  def show_users(users)
    @tr_content = content_tag(:div)
    users.each do |user|
      @content = content_tag(:tr)
      @content << content_tag(:td, user.name)
      @content << content_tag(:td, user.email)
      @content << content_tag(:td, user.id)
      @tr_content << @content
    end
    @tr_content
  end

  def show_created(user)
    @tr_content = content_tag(:div)
    user.events.uniq.each do |event|
      @content = content_tag(:tr)
      if event.user_id == user.id
        @content << content_tag(:td, event.location)
        @content << content_tag(:td, event.time)
        @content << content_tag(:td, event.title)
        @content << content_tag(:td, event.description)
      end
      @tr_content << @content
    end
    @tr_content
  end

  #     <td><%= link_to 'Show', event %></td>
  #     <td><%= link_to 'Edit', edit_event_path(event) %></td>
  #     <td><%= link_to 'Destroy', event, method: :delete, data: { confirm: 'Are you sure?' } %></td>
  #     <% end %>
  #   </tr>
  # <% end %>

  def show_upcoming(invites, user)
    @tr_content = content_tag(:div)
    invites.uniq.each do |invite|
      @content = content_tag(:tr)
      if invite.user.id == user.id && invite.event.time >= DateTime.now
        @content << content_tag(:td, invite.event.title)
        @content << content_tag(:td, invite.event.time)
      end
      @tr_content << @content
    end
    @tr_content
  end

  def show_past(invites, user)
    @tr_content = content_tag(:div)
    invites.uniq.each do |invite|
      @content = content_tag(:tr)
      if invite.user.id == user.id && invite.event.time < DateTime.now
        @content << content_tag(:td, invite.event.title)
        @content << content_tag(:td, invite.event.time)
      end
      @tr_content << @content
    end
    @tr_content
  end
end
