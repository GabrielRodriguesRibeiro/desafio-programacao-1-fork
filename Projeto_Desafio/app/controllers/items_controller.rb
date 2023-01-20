class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /items or /items.json
  def index
    @items = Item.paginate(page: params[:page], per_page: 5)
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items or /items.json
  def create
    
    @import_items = ImportarService.call item_params[:arquivo], current_user.id

    respond_to do |format|      
      if @import_items.empty?
        format.html { redirect_to items_path, notice: "Dados importados com sucesso." }
      else
        format.html { redirect_to new_item_path, notice: @import_items.map{|a| a[1].join(' - ')} }
      end
    end
    
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_url(@item), notice: "Itens editados." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item foi deletado" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name, :arquivo, :user_id)
    end
end
