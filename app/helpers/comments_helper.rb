module CommentsHelper
  def ancestry_comment(comment_id)
    @ancestry = Comment.find(comment_id)
  end
end
