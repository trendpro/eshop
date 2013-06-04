module AdminHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(admin)
    gravatar_id = Digest::MD5::hexdigest(admin.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: 'gravatar', class: "gravatar")
  end
end
