module UsersHelper
  def edit_user(current_user, user)
    link_to 'Edit', edit_user_path(user) if current_user && current_user.id == user.id
  end

  def show_users(current_user, users)
    @tr_content = content_tag(:div)
    users.each do |user|
      @content = content_tag(:tr)
      @content << content_tag(:td, user.name)
      @content << content_tag(:td, user.email)
      @content << content_tag(:td, user.id)
      @content << content_tag(:td, show_link(user))
      if current_user && current_user.id == user.id
        @content << content_tag(:td, edit_user(current_user, user))
        @content << content_tag(:td, destroy_link(user))
      end
      @tr_content << @content
    end
    @tr_content
  end

  def show_created(current_user, user)
    @tr_content = content_tag(:div)
    user.events.uniq.each do |event|
      @content = content_tag(:tr)
      if event.user_id == user.id
        @content << content_tag(:td, event.location)
        @content << content_tag(:td, event.time)
        @content << content_tag(:td, event.title)
        @content << content_tag(:td, event.description)
        @content << content_tag(:td, show_link(event))
        if current_user && current_user.id == user.id
          @content << content_tag(:td, edit_link(event))
          @content << content_tag(:td, destroy_link(event))
        end
      end
      @tr_content << @content
    end
    @tr_content
  end

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
