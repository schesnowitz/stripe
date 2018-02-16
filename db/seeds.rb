# Stripe::Plan.create(name: 'Subscriber',
#                     id: 'subscriber',
#                     interval: 'month',
#                     currency: 'usd',
#                     amount: '900')






user = User.create!(
  email: 'steve@chesnowitz.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true

)
puts user.inspect