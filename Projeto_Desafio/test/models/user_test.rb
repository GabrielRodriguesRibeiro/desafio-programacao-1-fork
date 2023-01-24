require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.create(
      email: "gabrielgrr97@gmail.com",
      password: "123456" 
    )
  end

  test "Deve-se ter um e-mail cadastrado para logar" do
    @user.email = " "
    assert_not @user.valid? # Espera que seja false
  end 

  test "E-mail do usuário não deve ter mais que 256 caracteres" do
    @user.email = "a" * 256
    assert_not @user.valid? # Espera que seja false
  end 

end
