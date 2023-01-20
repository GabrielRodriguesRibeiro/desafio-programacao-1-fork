require "test_helper"

class ItemServicesTest < ActionDispatch::IntegrationTest

    test "Criacao de itens" do   
        assert_changes("Item.count") do
            ImportarService.call fixture_file_upload('example_input.tab'), users(:one).id          
        end
    end

    test "Importacao de imagem" do    
        assert_not(
            ImportarService.call(
                fixture_file_upload('Moeda.jpg'), users(:one).id
            )
        ) 
    end

    test "Importacao com campos vazios" do
        assert_empty(
            ImportarService.call(
                fixture_file_upload('example_input.tab'), users(:one).id
            )
        )        
    end

end
