// document.addEventListener('turbolinks:load', function() {
  var card, elements, form, stripe, stripeTokenHandler, stripe_public_key, style;
  stripe_public_key = document.querySelector('meta[name="stripe-public-key"]').getAttribute('content');
  stripe = Stripe(stripe_public_key);
  elements = stripe.elements();
  style = {}
  card = elements.create('card', {
    style: style
  });
  card.mount('#card-element');
  card.addEventListener('change', function(event) {
    var displayError;
    displayError = document.getElementById('card-errors');
    if (event.error) {
      return displayError.textContent = event.error.message;
    } else {
      return displayError.textContent = '';
    }
  });

  stripeTokenHandler = function(token) {
    var form, hiddenInput;
    form = document.getElementById('payment-form');
    hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeToken');
    hiddenInput.setAttribute('value', token.id);
    form.appendChild(hiddenInput);
    return form.submit();
  };

  form = document.getElementById('payment-form');
  return form.addEventListener('submit', function(event) {
    event.preventDefault();
    return stripe.createToken(card).then(function(result) {
      var errorElement;
      if (result.error) {
        errorElement = document.getElementById('card-errors');
        return errorElement.textContent = result.error.message;
      } else {
        return stripeTokenHandler(result.token);
      }
    });
  });
// });