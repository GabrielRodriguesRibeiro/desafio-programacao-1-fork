class ImportarService < ApplicationService

    def initialize arquivo
        @arquivo = arquivo
        puts "Tem arquivo? #{arquivo}"
    end

    def call
        unless self.validateExtensiopn
            return false
        end

        nome_arquivo = self.salvar_em_disco
        response = self.salvar_no_banco nome_arquivo
    end

    def salvar_em_disco
            caminho = "/uploads/"
            arquivo_nome = "dados_#{Time.now.to_i}.txt"
            caminho = File.join(Rails.root, caminho, arquivo_nome)
            puts "Caminho gerado no disco: #{caminho}"
            File.open(caminho, "wb") do |f|
            f.write(@arquivo.read)
        end
        arquivo_nome
    end

    def salvar_no_banco arquivo

        response = {
            gross_income: 0
        }

        open("#{Rails.root}/uploads/#{arquivo}") do |file|
            file.each_with_index do |linha, i|
                next if i == 0
                coluna = linha.split("\t")
                item = Item.new
                    item.purchaser_name = coluna[0]
                    item.item_description = coluna[1]
                    item.item_price = coluna[2].to_f
                    item.purchase_count = coluna[3].to_f
                    item.merchant_address = coluna[4]
                    item.merchant_name = coluna[5]
                    item.gross_income = coluna[6].to_f
                    item[:gross_income] += (item.purchase_count * item.item_price)
                    item.save    
            end
            end
        response
    end

    def validateExtensiopn
        allow_extensions = ['.tab']
        if allow_extensions.include? File.extname(@arquivo.original_filename)
            true
        end
    end
end