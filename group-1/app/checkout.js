// Basket: prices on the shelf include VAT, so the total is just their sum.
// A product may carry a sticker, a percentage that comes off the price (VAT included in it,
// so before VAT). Amounts are kept in cents and rounded once, when a line comes in.
function newBasket() {
  var cents = [];
  return {
    add: function (price, sticker) {
      var off = sticker || 0;
      cents.push(Math.round(price * (100 - off)));
    },
    lines: function () {
      return cents.map(function (c) { return (c / 100).toFixed(2); });
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
