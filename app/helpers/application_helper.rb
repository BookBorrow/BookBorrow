module ApplicationHelper

  def avatar_for(user)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    pixels = 100
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{pixels}"
  end

end
