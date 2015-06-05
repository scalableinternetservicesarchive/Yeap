module LocationsHelper

	def cache_key_for_location_comments(location_id, comments)
    #Comment.where(:location_id => location_id).to_a.map { |elem| elem[:id] }
    
		comment_ids = comments.to_a.map {|elem| elem[:id]}
    id_sum = 0
    puts "###################"
    comment_ids.each do |id|
      id_sum = id_sum + id
    end
    puts "###################"
    #puts comments.count
		#count = comment_ids.count
		max_updated_at = Vote.where(:comment_id => comment_ids).maximum(:updated_at).try(:utc).try(:to_s, :number)

		return "comments/location-#{location_id}-#{id_sum}-#{max_updated_at}"
	end

end
