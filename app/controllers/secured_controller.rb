# SecuredControllerクラスはApplicationControllerを継承しており、
# 全てのコントローラー実行前にauthorize_requestを実行する
class SecuredController < ApplicationController
  before_action :authorize_request

  private

# authorize_request
# tokenを解析し、ユーザー認証ができなかった場合はエラーメッセージを返す
  def authorize_request
    authorize_request = AuthorizationService.new(request.headers)
    # binding.pry
    @current_user = authorize_request.current_user
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end