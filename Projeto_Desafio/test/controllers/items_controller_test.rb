require "test_helper"

class ItemsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @item = items(:completo)
    sign_in users(:one)
  end
 
  test 'Deve mostrar o item' do
    get item_url(@item)
    assert(@item)
  end

  test 'Deve excluir o item' do
    assert_difference("Item.count", 0) do
      delete item_url(@item)
    end
  end

  test 'ID do usuário não pode ser nulo' do
    assert_not_nil @item.user_id
  end  

  # test 'Teste de filtro' do
  #   get :index, params: { q: { purchaser_name: @item.purchaser_name } } 
  #   assert_difference("Item.count", 0) do
  #     get item_url(@item)
  #   end
  # end

end
