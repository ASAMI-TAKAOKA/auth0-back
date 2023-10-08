class Api::V1::PostsController < SecuredController
  # indexとshowメソットのみ認証処理をスキップしている
  # authorize_requestの処理はapp/controllers/secured_controller.rbに記述済み
  skip_before_action :authorize_request, only: [:index,:show]

  # ブログの取得(index,show)は認証なしで実行できる
  # ブログの新規作成は認証がないと実行できない
  # ブログの削除も認証がないと実行できない

  def index
    posts = Post.all
    render json: posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def create
    # ユーザー認証
    post = @current_user.posts.build(post_params)

    if post.save
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.delete
  end

  private

  def post_params
    params.permit(:title,:caption)
  end
end