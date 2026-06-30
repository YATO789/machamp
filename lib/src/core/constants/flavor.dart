enum Flavor {
  dev,
  prod;

  const Flavor();

  static Flavor get current {
    const flavorString = String.fromEnvironment('FLUTTER_APP_FLAVOR');
    return values.firstWhere((e) => e.name == flavorString);
  }
}
