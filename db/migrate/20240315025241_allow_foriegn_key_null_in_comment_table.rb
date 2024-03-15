class AllowForiegnKeyNullInCommentTable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :comments, :parent_comment_id, true
  end
end
