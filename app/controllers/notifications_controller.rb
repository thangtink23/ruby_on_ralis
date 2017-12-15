class NotificationsController < ApplicationController

  def create
    @notifications = Notification.where(subscriber_id: params[:notification][:subscriber_id], status: 'false')
    @notifications.each do |notification|
    notification.update_attributes(status: true)
    end
  end
end
