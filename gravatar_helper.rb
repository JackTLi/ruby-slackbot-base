require 'digest/md5'

module GravatarHelper

  def GravatarHelper.gravatar_url(email_addr)
    email_address = email_addr.downcase
    hash = Digest::MD5.hexdigest(email_address)
    "https://www.gravatar.com/avatar/#{hash}"
  end

end
