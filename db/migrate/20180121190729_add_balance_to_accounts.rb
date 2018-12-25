class AddBalanceToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_monetize :accounts, :balance
    change_column :accounts, :balance, :decimal, precision: 1000, scale: 0
  end
end
