# module MessagesHelper
#   def recipients_options
#     s = ''
#     User.all.each do |user|
#       s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 20)}'>#{user.name}</option>"
#     end
#     s.html_safe
#   end
# end

module MessagesHelper
  def recipients_options
    s = ''
    User.all.each do |user|

      s << "<option style='background-image:url(#{user.picture.url}?size=20);background-position: right center;
  background-repeat: no-repeat;
  padding: 21px;
  background-size:9% auto;' value='#{user.id}'>#{user.name} <img src='#{user.picture.url}?size=20'></img></option>"
    end
    s.html_safe
  end
end

