module UsersHelper
  # Return the Gravatar for the given user.
  def gravatar_for( user, options = { size:80 } )
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  # Return the cache key of the user activity for the given user
  def cache_key_for_user_activity(user_id)

  	comment_max_updated_at = Comment.where(:user_id => user_id).maximum(:updated_at).try(:utc).try(:to_s, :number)
  	vote_max_updated_at = Vote.where(:user_id => user_id).maximum(:updated_at).try(:utc).try(:to_s, :number)
  	like_max_updated_at = Like.where(:user_id => user_id).maximum(:updated_at).try(:utc).try(:to_s, :number)

  	return "activity/user-#{user_id}-#{comment_max_updated_at}-#{vote_max_updated_at}-#{like_max_updated_at}"

  end
end
