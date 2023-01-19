class ImportarService < ApplicationService
    attr_accessor :import_errors

    def initialize arquivo, current_user_id
        @arquivo = arquivo
        @current_user_id = current_user_id
        self.import_errors = []
    end

    def call
        unless self.validateExtension
            return false
        end

        nome_arquivo = self.salvar_em_disco
        response = self.salvar_no_banco nome_arquivo
    end

    def salvar_em_disco
        caminho = "uploads"
        arquivo_nome = "dados_#{Time.now.to_i}.txt"
        caminho = Rails.root.join(caminho, arquivo_nome).to_s

        File.open(caminho, "wb") do |f|
            f.write(@arquivo.read)
        end
        arquivo_nome
    end

    def salvar_no_banco arquivo  

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
                item.user_id = @current_user_id
                item[:gross_income] += (item.purchase_count * item.item_price)
            
                self.import_errors.push([i, item.errors.full_messages]) unless item.save
            end
        end

        self.import_errors
    end

    def validateExtension

        allow_extensions = ['.tab']
        if allow_extensions.include? File.extname(@arquivo.original_filename)
            true
        end
    end
end