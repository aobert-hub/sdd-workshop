// The checkout's basket arithmetic. Prices include VAT; a sticker is a percentage that comes
// off the price before VAT, so it comes off the shelf price as it is.
var Checkout = (function () {
  // line(product): the price of one product line in euros, sticker taken off, rounded once.
  function line(product) {
    var sticker = product.sticker || 0;
    return Math.round(product.price * 100 * (100 - sticker) / 100) / 100;
  }

  // total(lines): the sum of line prices in euros, rounded once.
  function total(lines) {
    var cents = 0;
    for (var i = 0; i < lines.length; i++) cents += Math.round(lines[i] * 100);
    return cents / 100;
  }

  return { line: line, total: total };
})();
