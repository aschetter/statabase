class CreateAdvs < ActiveRecord::Migration
  def change
    create_table :advs do |t|

      t.belongs_to :membership
      t.string     :br_id

      t.float      :per
      t.float      :ts_pct
      t.float      :efg_pct
      t.float      :ft_ar
      t.float      :three_ar

      t.float      :orb_pct
      t.float      :drb_pct
      t.float      :trb_pct
      t.float      :ast_pct
      t.float      :stl_pct

      t.float      :blk_pct
      t.float      :tov_pct
      t.float      :usg_pct
      t.float      :o_rtg
      t.float      :d_rtg

      t.float      :ows
      t.float      :dws
      t.float      :ws
      t.float      :ws_48

      t.timestamps
    end
  end
end
