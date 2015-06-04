module LocationsHelper

	def cache_key_for_location_comments(location_id)

		comment_ids = Comment.where(:location_id => location_id).to_a.map { |elem| elem[:id] }
		count = comment_ids.count
		max_updated_at = Vote.where(:comment_id => comment_ids).maximum(:updated_at).try(:utc).try(:to_s, :number)

		return "comments/location-#{location_id}-#{count}-#{max_updated_at}"
	end

end
