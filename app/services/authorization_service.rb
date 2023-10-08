# AuthorizationService
# Authorization HTTP Headerに含まれるアクセストークンを取得しJWTに渡して検証する
class AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  # current_user
  # ユーザーモデルメソッドを実行し、ユーザー情報を返す
  def current_user
    @auth_payload, @auth_header = verify_token
    @user = User.from_token_payload(@auth_payload)
  end

  private

  def http_token
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  # verify_token
  # json_web_token.rbを実行してTokenを渡す
  def verify_token
    JsonWebToken.verify(http_token)
  end
end