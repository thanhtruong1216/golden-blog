module LikesHelper
  def liked?(post)
    @liked_post_ids ||= current_user.likes.pluck(:post_id).to_set
    @liked_post_ids.include?(post.id)
  end
end
