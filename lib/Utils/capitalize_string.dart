extension CapitalizeString on String {
  String get capitalize {
    return this != null ? (this[0].toUpperCase() + this.substring(1)) : '';
  }
}
