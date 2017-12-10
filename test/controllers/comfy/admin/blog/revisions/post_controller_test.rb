require_relative "../../../../../test_helper"

class Comfy::Admin::Cms::Revisions::PageControllerTest < ActionDispatch::IntegrationTest

  setup do
    @site     = comfy_cms_sites(:default)
    @post     = comfy_blog_posts(:default)
    @revision = comfy_cms_revisions(:post)
  end

  def test_get_index
    r :get, comfy_admin_blog_post_revisions_path(@site, @post)
    assert_response :redirect
    assert_redirected_to action: :show, id: @revision
  end

  def test_get_index_with_no_revisions
    Comfy::Cms::Revision.delete_all
    r :get, comfy_admin_blog_post_revisions_path(@site, @post)
    assert_response :redirect
    assert_redirected_to edit_comfy_admin_blog_post_path(@site, @post)
  end

  def test_get_show
    r :get, comfy_admin_blog_post_revision_path(@site, @post, @revision)
    assert_response :success
    assert assigns(:record)
    assert assigns(:revision)
    assert assigns(:record).is_a?(Comfy::Blog::Post)
    assert_template :show
  end

  def test_get_show_for_invalid_record
    r :get, comfy_admin_blog_post_revision_path(@site, "invalid", @revision)
    assert_response :redirect
    assert_redirected_to comfy_admin_blog_posts_path(@site)
    assert_equal "Record Not Found", flash[:danger]
  end


  def test_get_show_failure
    r :get, comfy_admin_blog_post_revision_path(@site, @post, "invalid")
    assert_response :redirect
    assert assigns(:record)
    assert_redirected_to edit_comfy_admin_blog_post_path(@site, assigns(:record))
    assert_equal "Revision Not Found", flash[:danger]
  end

  def test_revert
    assert_difference -> {@post.revisions.count} do
      r :patch, revert_comfy_admin_blog_post_revision_path(@site, @post, @revision)
      assert_response :redirect
      assert_redirected_to edit_comfy_admin_blog_post_path(@site, @post)
      assert_equal "Content Reverted", flash[:success]

      @post.reload

      assert_equal [{
        identifier: "content",
        tag:        "text",
        content:    "old content",
        datetime:   nil,
        boolean:    false
      }], @post.fragments_attributes
    end
  end
end
