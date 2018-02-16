class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def stripe_customer
    return Stripe::Customer.retrieve(stripe_id) if stripe_id?
    stripe_customer = Stripe::Customer.create(email: email)
    update(stripe_id: stripe_customer.id)
    stripe_customer
  end

  def subscribed?
    stripe_subscription_id?
  end
end
