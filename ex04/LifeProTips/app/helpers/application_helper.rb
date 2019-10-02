module ApplicationHelper
  def votant_name(user_id)
    User.find(user_id).name
  end

  def destroy_vote(user_id, post_id)
    Post.find(post_id).votes.where(user_id: user_id).update_attributes(value: 0)
  end
end
