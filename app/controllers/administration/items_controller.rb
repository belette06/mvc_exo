# frozen_string_literal: true

module Administration
  # noinspection ALL
  class ItemsController < AdministrationController
    before_action :set_item, only: [:update]
    def index
      @emails = User.emails_of_all_users
      @items = Item.all
    end

    def update
      @item.update(item_params)
      @item.has_discount = @item.discount_percentage.to_i.present?
      if @item.save
        redirect_back fallback_location: administration_items_path, alert: "Veuillez entrer une réduction valable"

      else
        redirect_to administration_items_path, notice: "L'item a bien été modifié"
      end
    end

    private

    def item_params
      params.require(:item).permit(:original_price, :has_discount, :discount_percentage)
    end

    def set_item
      @item = Item.find(params[:id])
    end
  end
end
