class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    customer = current_user.stripe_customer
    begin
      subscription = customer.subscriptions.create(source: params[:stripeToken], plan: 'subscriber')
      current_user.assign_attributes(stripe_subscription_id: subscription.id)
      current_user.save
      redirect_to root_path, notice: 'Thanks for subscribing!'
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new
    end
  end
end