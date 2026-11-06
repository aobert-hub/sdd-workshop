// Basket: prices on the shelf include VAT, so the total is just their sum.
// Amounts are kept in cents and rounded once, when a price comes in.
// Each line has its own VAT rate (percent); its VAT is price * rate / (100 + rate), the
// price including VAT. The VAT is summed unrounded and rounded once, at the end.
function newBasket() {
  var cents = [];
  var rates = [];
  function sumCents() {
    var sum = 0;
    for (var i = 0; i < cents.length; i++) {
      sum += cents[i];
    }
    return sum;
  }
  function vatCents() {
    var vat = 0;
    for (var i = 0; i < cents.length; i++) {
      vat += cents[i] * rates[i] / (100 + rates[i]);
    }
    return vat;
  }
  return {
    add: function (price, vatRate) {
      cents.push(Math.round(price * 100));
      rates.push(vatRate || 0);
    },
    vatTotal: function () {
      return (Math.round(vatCents()) / 100).toFixed(2);
    },
    totalWithoutVat: function () {
      return (Math.round(sumCents() - vatCents()) / 100).toFixed(2);
    },
    total: function () {
      var sum = 0;
      for (var i = 0; i < cents.length; i++) {
        sum += cents[i];
      }
      return (sum / 100).toFixed(2);
    }
  };
}
