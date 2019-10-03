module ApplicationHelper
  def votant_name(user_id)
    User.find(user_id).name
  end

  def current_user_owns_post(post)
    post.user_id == current_user.id
  end

  def know_your_rights(user)
    case Post.all.where(user_id: user.id).size
    when 0...3
      'You can\'t edit other\'s posts or vote'
    when 3...6
      'You can\'t edit other\'s posts but can upvote'
    when 6...9
      'You can\'t edit other\'s posts but can downvote'
    else
      'You can edit other\'s posts'
    end
  end
end
