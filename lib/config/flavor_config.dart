enum Flavor { dev, prod }

class FlavorConfig {
  static const _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  static Flavor get current =>
      _flavor == 'prod' ? Flavor.prod : Flavor.dev;

  static bool get isDev => current == Flavor.dev;
  static bool get isProd => current == Flavor.prod;
}
