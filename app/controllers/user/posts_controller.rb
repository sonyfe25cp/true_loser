# -*- encoding: utf-8 -*-
class User::PostsController < User::BaseController
  def index
    @posts = Post.all(:order => [:id.desc]).search('status' => :ok).page(params[:page]).per(params[:limit])
    respond_to do |format|
      format.html
    end
  end

  def show
    @post = Post.get(params[:id])
    @comments = Comment.search(:post_id => @post.id)
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json {render json: @post}
    end
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(params[:post])
    if current_user
      post.username = current_user.username
      post.user_img = current_user.user_img
    end
    if post.save
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end

  #随机出一个
  def choose
    @post = Post.search('status' => :new).sample

    respond_to do |format|
      format.html
      format.json {render json: @post}
    end

  end

  #海选
  def judge
    status = params[:status]
    post_id = params[:id]
    post = Post.get(post_id)
    post.update(:status => status.to_sym)
    redirect_to  choose_path
  end

  def pknew
    @base = Post.get(params[:id])
    @post = Post.new

  end
  #挑战某一个
  def pk
    base_id = params[:base_id]
    post = Post.create(:content => params[:content])
    if current_user
      post.username = current_user.username
      post.user_img = current_user.user_img
    end
    post.save

    Pair.create(:base_id => base_id, :pk_id => post.id)
    redirect_to root_path

  end

  #记录两个比惨的post的胜负记录
  def win

  end

  #挑选出两个post进行比惨
  def bican
    pair = Pair.all.sample
    if pair != nil
      @postA = Post.get(pair.base_id)
      @postB = Post.get(pair.pk_id)
    else
      @postA = nil
      @postB = nil
    end
  end

end
