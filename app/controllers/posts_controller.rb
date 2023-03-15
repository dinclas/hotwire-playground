class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy like ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts/1/like
  def like
    user_like = Like.find_or_initialize_by(post: @post, user: current_user) { |l| l.liked = true }

    if user_like.persisted?
      user_like.liked = !user_like.liked
    end

    respond_to do |format|
      if user_like.save
        format.html { redirect_to :root }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html do
          if @post.parent.present?
            return redirect_to @post.parent
          end
          redirect_to :root, notice: "Post was successfully published."
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to :root, alert: @post.errors.full_messages[0] }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :text, :posts_id)
    end
end
