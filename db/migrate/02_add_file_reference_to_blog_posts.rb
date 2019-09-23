class AddFileReferenceToBlogPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :comfy_blog_posts,
      :file,
      index: true,
      foreign_key: { to_table: :comfy_cms_files },
      null: true
  end
end
