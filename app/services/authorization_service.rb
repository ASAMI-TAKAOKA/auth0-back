# AuthorizationService
# Authorization HTTP Headerに含まれるアクセストークンを取得しJWTに渡して検証する
class AuthorizationService
  def initialize(headers = {})
    # binding.pry
     # 取得できている
    @headers = headers
  end

  # current_user
  # ユーザーモデルメソッドを実行し、ユーザー情報を返す
  def current_user
    # current_userメソッドが実行されないことで、401が返ってきている。
    # binding.pry
    @auth_payload, @auth_header = verify_token
    # verify_tokenの中身
    # => [{"iss"=>"https://dev-qg5jv6pdemj650kv.jp.auth0.com/",
    #   "sub"=>"Zr57glGSEX7dvPumVAp4as7l71vL4GlN@clients",
    #   "aud"=>"https://auth0-app",
    #   "iat"=>1698467635,
    #   "exp"=>1698554035,
    #   "azp"=>"Zr57glGSEX7dvPumVAp4as7l71vL4GlN",
    #   "gty"=>"client-credentials"},
    #  {"alg"=>"RS256", "typ"=>"JWT", "kid"=>"TkT_oY2Aoyk2sbI3oVfAp"}]

    # @auth_payload
    # {"iss"=>"https://dev-qg5jv6pdemj650kv.jp.auth0.com/",
    #  "sub"=>"Zr57glGSEX7dvPumVAp4as7l71vL4GlN@clients",
    #  "aud"=>"https://auth0-app",
    #  "iat"=>1698467635,
    #  "exp"=>1698554035,
    #  "azp"=>"Zr57glGSEX7dvPumVAp4as7l71vL4GlN",
    #  "gty"=>"client-credentials"}
    
    # @auth_header
    # {"alg"=>"RS256", "typ"=>"JWT", "kid"=>"TkT_oY2Aoyk2sbI3oVfAp"}
    # binding.pry
    @user = User.from_token_payload(@auth_payload)
    # binding.pry
  end

  private

  def http_token
    # binding.pry
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  # verify_token
  # json_web_token.rbを実行してTokenを渡す
  def verify_token
    # binding.pry 
    # http_tokenは取得できているが、verify_tokenは取得できていない
    # json_web_token.rbを記事のとおりに修正するしかなさそう...？
    JsonWebToken.verify(http_token)
  end
end