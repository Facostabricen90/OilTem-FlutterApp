class AddMachineRequest {
  late String namemachine;
  late String imagen;
  late String fuel;
  late String grass;
  late String quantityGrams;
  late String quantityLiters;
  late String tag;
  late String periodicityFuel;
  late String periodicityGrass;

  @override
  String toString() {
    return "$namemachine, $imagen, $fuel, $grass, $quantityGrams, $quantityLiters,  $tag, $periodicityFuel, $periodicityGrass  ";
  }
}
