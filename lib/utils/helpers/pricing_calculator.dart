class MPricingCalculator {
  // Calculate Price  based on Tax and shipping

  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  /// --- calculate shipping cost
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);

    return shippingCost.toStringAsFixed(2);
  }

  /// --- Calculate tax

  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    //lookup the shipping cost for the given location using a shipping rate API
    // Calculate the shipping cost based on various factors like distance, weight, etc
    return 0.10;
  }

  static double getShippingCost(String location) {
    //lookup the shipping cost for the given location using a shipping rate API
    // Calculate the shipping cost based on various factors like distance, weight, etc
    return 5.00;
  }

  /// ---- sum all cart values and return total amount
  ///  static double calculateCartTotal(CartModel cart) {
  /// return cart.items.map((e) => e.price).fold(0, (currentPrice)  => prevoiusPrice + (currentPrice ?? 0));
  /// }
}
