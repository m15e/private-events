module ApplicationHelper
  def logout
    link_to 'Log Out', logout_path
  end

  def signup
    link_to 'Sign Up', signup_path
  end

  def login
    link_to 'Log In', login_path
  end

  def show_session(_current_user)
    content = content_tag(:div)
    if current_user
      content << content_tag(:span, "Logged in as #{current_user.email}")
      content << tag(:br)
      content << content_tag(:span, logout)
    else
      content << content_tag(:span, signup)
      content << content_tag(:span, ' ')
      content << content_tag(:span, login)
    end
    content
  end
end

# @content << content_tag(:td, edit_link(event))
#
# <% if current_user %>
#   Logged in as <%= current_user.email %>
#   <%= link_to "Log Out", logout_path %>
# <% else %>
#   <%= link_to "Sign_up", signup_path %> or
#   <%= link_to "Log In", login_path %>
# <% end %>
