class Stat < ActiveRecord::Base
  attr_accessor :player_name
  belongs_to :membership

  def as_json(options={})
    if @player_name
      super.merge(:player_name => @player_name)
    else
      super
    end
  end
end
