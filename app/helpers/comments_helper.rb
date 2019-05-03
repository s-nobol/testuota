module CommentsHelper
  
  # # もしコメントユーザーとログインユーザーが違うと削除できない
  # def comment_destroy(comment)
  #   if comment.user == current_user #|| current_user.admin?
  #     comment
  #   end
  # end
end
