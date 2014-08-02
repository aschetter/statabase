class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      t.belongs_to :player
      t.string     :br_id

      t.integer    :age
      t.integer    :gp
      t.integer    :gs
      t.float      :min
      t.float      :fg_made

      t.float      :fg_att
      t.float      :fg_pct
      t.float      :three_made
      t.float      :three_att
      t.float      :three_pct

      t.float      :two_made
      t.float      :two_att
      t.float      :two_pct
      t.float      :ft_made
      t.float      :ft_att

      t.float      :ft_pct
      t.float      :orb
      t.float      :drb
      t.float      :trb
      t.float      :ast

      t.float      :stl
      t.float      :blk
      t.float      :tov
      t.float      :pf
      t.float      :pts

      t.timestamps
    end
  end
end
