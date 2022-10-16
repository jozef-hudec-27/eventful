class MakeTicketPriceNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :ticket_price, :integer, null: false
  end
end
