class Version2 < ActiveRecord::Migration
  def change
    change_table :monsters do |t|
      t.string :kind
      t.string :type1
      t.string :type2
    end
  end
end
