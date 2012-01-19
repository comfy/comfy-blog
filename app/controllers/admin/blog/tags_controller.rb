class Admin::Blog::TagsController < Admin::Blog::BaseController
  
  before_filter :build_tag, :only => [:new, :create]
  before_filter :load_tag,  :only => [:edit, :update, :destroy]

  def index
    @tags = Blog::Tag.all
  end
  
  def edit
    render
  end
  
  def new
    render
  end
  
  def update
    @tag.update_attributes!(params[:tag])
    flash[:notice] = 'Blog Tag updated'
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = 'Failed to update Blog Tag'
    render :action => :edit
  end
  
  def create
    @tag.save!
    flash[:notice] = 'Blog Tag created'
    redirect_to :action => :index
    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = 'Failed to create Blog Tag'
    render :action => :new
  end
  
  def destroy
    @tag.destroy
    flash[:notice] = 'Blog Tag removed'
    redirect_to :action => :index
  end

protected
  
  def build_tag
    @tag = Blog::Tag.new(params[:tag])
  end
  
  def load_tag
    @tag = Blog::Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'Blog Tag not found'
    redirect_to :action => :index  
  end
end
