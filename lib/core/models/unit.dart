enum Unit {
  G,      // grams
  KG,     // kilograms
  ML,     // milliliters
  L,      // liters
  PCS,    // pieces
  TBSP,   // tablespoon
  TSP,    // teaspoon
  CUP,    // cup
  OZ,     // ounces
  LB,     // pounds
  SLICE,  // slice
  PINCH,  // pinch
  OTHER;  // other or custom unit

  String get displayName {
    switch (this) {
      case Unit.G:
        return 'grams';
      case Unit.KG:
        return 'kilograms';
      case Unit.ML:
        return 'milliliters';
      case Unit.L:
        return 'liters';
      case Unit.PCS:
        return 'pieces';
      case Unit.TBSP:
        return 'tablespoon';
      case Unit.TSP:
        return 'teaspoon';
      case Unit.CUP:
        return 'cup';
      case Unit.OZ:
        return 'ounces';
      case Unit.LB:
        return 'pounds';
      case Unit.SLICE:
        return 'slice';
      case Unit.PINCH:
        return 'pinch';
      case Unit.OTHER:
        return 'other';
    }
  }

  String get abbreviation {
    switch (this) {
      case Unit.G:
        return 'g';
      case Unit.KG:
        return 'kg';
      case Unit.ML:
        return 'ml';
      case Unit.L:
        return 'L';
      case Unit.PCS:
        return 'pcs';
      case Unit.TBSP:
        return 'tbsp';
      case Unit.TSP:
        return 'tsp';
      case Unit.CUP:
        return 'cup';
      case Unit.OZ:
        return 'oz';
      case Unit.LB:
        return 'lb';
      case Unit.SLICE:
        return 'slice';
      case Unit.PINCH:
        return 'pinch';
      case Unit.OTHER:
        return '';
    }
  }
} 