class SettingsController < ApplicationController
  def index
    @setting=Setting.getSetting()
  end

  def show
    @setting=Setting.getSetting()
  end

  def edit
    @setting=Setting.getSetting()
  end
  
  def update
    @setting = Setting.getSetting()

    success=true
    if setting_params[:startTimeDelta] != ""
      startTime = DateTime.now+setting_params[:startTimeDelta].to_i.seconds
      success = @setting.update_attributes(:startTime=>startTime)
    else
      success =  @setting.update(setting_params)
    end

    if success
      redirect_to action: "index"
    else
      render 'edit'
    end

  end

  
  private
    def setting_params
      params[:setting].permit(:startTime, :startTimeDelta)
    end
end
