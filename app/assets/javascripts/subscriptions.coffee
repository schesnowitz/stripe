document.addEventListener 'turbolinks:load', ->
  stripe_public_key = document.querySelector('meta[name="stripe-public-key"]').getAttribute('content')
  stripe = Stripe(stripe_public_key)
  elements = stripe.elements()
  style=
  card = elements.create('card', style: style)
  card.mount '#card-element'
  card.addEventListener 'change', (event) ->
    displayError = document.getElementById('card-errors')
    if event.error
      displayError.textContent = event.error.message
    else
      displayError.textContent = ''
      
  stripeTokenHandler = (token) ->
    form = document.getElementById('payment-form')
    hiddenInput = document.createElement('input')
    hiddenInput.setAttribute 'type', 'hidden'
    hiddenInput.setAttribute 'name', 'stripeToken'
    hiddenInput.setAttribute 'value', token.id
    form.appendChild hiddenInput
    form.submit()

  form = document.getElementById('payment-form')
  form.addEventListener 'submit', (event) ->
    event.preventDefault()
    stripe.createToken(card).then (result) ->
      if result.error
        errorElement = document.getElementById('card-errors')
        errorElement.textContent = result.error.message
      else
        stripeTokenHandler result.token