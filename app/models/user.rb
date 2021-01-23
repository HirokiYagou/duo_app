class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  
  USERNAME_REGEX = /\A[a-zA-Z_0-9]+\z/.freeze
  EMAIL_REGEX = /\A\S+@\S+\.\S+\z/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  FULLNAME_REGEX = /\A[a-zA-Z]+\z/.freeze
  with_options presence: true do
    with_options uniqueness: { case_sensitive: false } do
      validates :username, format: { with: USERNAME_REGEX, message: 'は英字、数字、アンダーバーを入力してください'}
      validates :email, format: { with: EMAIL_REGEX,    message: 'には@を含めてください' }
    end
    validates :password, format: { with: PASSWORD_REGEX, message: 'には半角で英字と数字の両方を含めて設定してください' }
    with_options format: { with: FULLNAME_REGEX, message: 'は英字で入力してください'} do
      validates :last_name
      validates :first_name
    end
  end

end
