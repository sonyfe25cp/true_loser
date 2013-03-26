class User::PostsController < User::BaseController
  def index
    @posts = Post.page(params[:page]).per(params[:limit])
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

  end
end
