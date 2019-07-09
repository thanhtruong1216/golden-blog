module UsersHelper
  def following?(user)
    @followed_ids ||= current_user.active_relationships.pluck(:followed_id).to_set
    @followed_ids.include?(user.id)
  end
end
