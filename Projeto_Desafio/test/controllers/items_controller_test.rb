require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:completo)
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

end
