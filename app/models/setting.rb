class Setting < ActiveRecord::Base
  attr_accessor :startTimeDelta

  def self.getSetting
    if(!Setting.exists?(1))
      setting = Setting.new
      setting.save
    end

    return Setting.first
  end
end
