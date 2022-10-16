class ChangeDefaultTicketPrice < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :ticket_price, :integer, default: 0
  end
end
