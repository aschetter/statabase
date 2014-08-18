class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      t.belongs_to :membership

      t.integer    :age
      t.integer    :gp
      t.integer    :gs
      t.integer    :min
      t.integer    :fg_made

      t.integer    :fg_att
      t.float      :fg_pct
      t.integer    :three_made
      t.integer    :three_att
      t.float      :three_pct

      t.integer    :two_made
      t.integer    :two_att
      t.float      :two_pct
      t.integer    :ft_made
      t.integer    :ft_att

      t.float      :ft_pct
      t.integer    :orb
      t.integer    :drb
      t.integer    :trb
      t.integer    :ast

      t.integer    :stl
      t.integer    :blk
      t.integer    :tov
      t.integer    :pf
      t.integer    :pts

      t.timestamps
    end
  end
end
