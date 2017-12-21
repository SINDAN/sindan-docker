require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(
      login: 'name',
      email: 'user@example.com',
      password: 'user@example.com',
    )
  end

  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end

  it "is not valid without login" do
    @user.login = nil

    expect(@user).not_to be_valid
  end

  it "is not valid with same value of login" do
    @user.login = 'name'
    @user.save

    @user2 = User.new(login: 'name')

    expect(@user2).not_to be_valid
  end
end
