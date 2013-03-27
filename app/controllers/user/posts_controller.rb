class User::PostsController < User::BaseController
  def index
    @posts = Post.all(:order => [:id.desc]).page(params[:page]).per(params[:limit])
    respond_to do |format|
      format.html
    end
  end

  def show
    @post = Post.get(params[:id])
    respond_to do |format|
      format.html
      format.json {render json: @post}
    end
  end

  def new
    @post = Post.new
  end

  def create
    binding.pry
    post = Post.new(params[:post])

    respond_to do |format|
      if post.save
        format.html
      else
        redirect_to posts_path
      end
    end
  end
end
