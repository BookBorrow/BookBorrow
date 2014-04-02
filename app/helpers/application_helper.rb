module ApplicationHelper

  def avatar_for(user)
    pixels = 100
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    default_url = "#{root_url}images/guest.png"
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{pixels}"
  end

end
