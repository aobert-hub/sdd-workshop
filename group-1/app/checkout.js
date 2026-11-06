// Basket: prices on the shelf include VAT, so the total is just their sum.
// Amounts are kept in cents and rounded once, when a price comes in.
function newBasket() {
  var cents = [];
  return {
    add: function (price) {
      cents.push(Math.round(price * 100));
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
