require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "新規登録" do
    it "入力欄を全て適切に埋めれば登録できる" do
      expect(@user).to be_valid
    end
  end
end
