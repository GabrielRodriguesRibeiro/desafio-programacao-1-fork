require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:completo)
  end
 
  test "Deve mostrar o item" do
    get item_url(@item)
    assert(@item)
  end

  # test "Deve editar o item" do
  #   patch item_url(@item), params: { item: { arquivo: @item.arquivo, item_description: @item.item_description, item_price: @item.item_price, merchant_address: @item.merchant_address, merchant_name: @item.merchant_name, purchase_count: @item.purchase_count, purchaser_name: @item.purchaser_name } }
  # end

  test "Deve excluir o item" do

    assert_difference("Item.count", 0) do
      delete item_url(@item)
    end
  end
end
