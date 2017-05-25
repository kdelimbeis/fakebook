class AddToUsers < ActiveRecord::Migration[5.1]
  def change
  	change_table :users do |t|
  			t.string :city
	  		t.string :school
  	end
  end
end
