class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  # self.from_token_payload(payload)
  # token情報を参照して対象のuserが存在する場合はuser情報を返し、
  # 存在しない場合は新規作成の処理を行う
  def self.from_token_payload(payload)
    # binding.pry
    find_by(sub: payload['sub']) || create!(sub: payload['sub'])
  end
end