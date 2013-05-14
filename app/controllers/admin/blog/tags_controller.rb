class Admin::Blog::TagsController < Admin::Blog::BaseController
  
  before_filter :build_tag, :only => [:new, :create]
  before_filter :load_tag,  :only => [:edit, :update, :destroy]

  def index
    @tags = Blog::Tag.order('is_category DESC', :name)
  end
  
  def edit
    render
  end
  
  def new
    render
  end
  
  def update
    @tag.update_attributes!(params[:tag])
    flash[:notice] = I18n.t('comfy_blog.tag_updated')
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = I18n.t('comfy_blog.tag_update_failed')
    render :action => :edit
  end
  
  def create
    @tag.save!
    flash[:notice] = I18n.t('comfy_blog.tag_created')
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = I18n.t('comfy_blog.tag_create_failed')
    render :action => :new
  end
  
  def destroy
    @tag.destroy
    flash[:notice] = I18n.t('comfy_blog.tag_removed')
    redirect_to :action => :index
  end

protected
  
  def build_tag
    @tag = Blog::Tag.new(params[:tag])
  end
  
  def load_tag
    @tag = Blog::Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = I18n.t('comfy_blog.tag_not_found')
    redirect_to :action => :index
  end
end
