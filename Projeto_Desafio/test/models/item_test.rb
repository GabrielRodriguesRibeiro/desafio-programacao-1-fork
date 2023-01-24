require "test_helper"

class ItemTest < ActiveSupport::TestCase

  test 'Salvar item preenchendo todo os atributos' do 
    item = items(:completo)
    assert item.valid?
  end

  test 'Salvar item preenchendo sem informar todos os atributos' do
    item = items(:incompleto)
    assert_not item.valid?, item.errors.full_messages.inspect
  end

  test 'Todos os atributos vazios' do
    item = items(:vazio)
    assert_not item.valid?, item.errors.full_messages.inspect
  end

  test 'Valores numericos não podem ficar negativos' do
    item = items(:valor_invalido)
    assert_not item.item_price >= 0
  end

  test 'A quantidade não pode ser negativa' do
    item = items(:valor_negativo)
    assert_not item.purchase_count >= 0
  end

  test 'Nome do comprador não pode ser maior que 60 caracteres' do
    item = items(:completo)
    assert_not item.purchaser_name.length > 60
  end 

end
