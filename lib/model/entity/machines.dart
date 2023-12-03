import 'package:cloud_firestore/cloud_firestore.dart';

class MachineEntity {
  late String? namemachine;
  late String? imagen;
  late String? fuel;
  late String? grass;
  late String? quantityGrams;
  late String? quantityLiters;
  late String? tag;
  late String? periodicityFuel;
  late String? periodicityGrass;

  MachineEntity(
      {this.namemachine,
      this.imagen,
      this.fuel,
      this.grass,
      this.periodicityFuel,
      this.periodicityGrass,
      this.quantityGrams,
      this.quantityLiters,
      this.tag});

  factory MachineEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();
    return MachineEntity(
      namemachine: data?["namemachine "],
      imagen: data?["imagen"],
      fuel: data?["fuel"],
      grass: data?["grass"],
      periodicityFuel: data?["periodicityFuel"],
      periodicityGrass: data?["periodicityGrass"],
      quantityGrams: data?["quantityGrams "],
      quantityLiters: data?["quantityLiters"],
      tag: data?["tag"],
      //isAdmin: data?["isAdmin"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (namemachine != null && namemachine!.isNotEmpty)
        "namemachine ": namemachine,
      if (imagen != null && imagen!.isNotEmpty) "imagen": imagen,
      if (fuel != null && fuel!.isNotEmpty) "fuel": fuel,
      if (grass != null && grass!.isNotEmpty) "grass": grass,
      if (periodicityFuel != null && periodicityFuel!.isNotEmpty)
        "periodicityFuel": periodicityFuel,
      if (periodicityGrass != null && periodicityGrass!.isNotEmpty)
        "periodicityGrass": periodicityGrass,
      if (quantityGrams != null) "quantityGrams ": quantityGrams,
      if (quantityLiters != null) "quantityLiters": quantityLiters,
      if (tag != null && tag!.isNotEmpty) "tag": tag,
    };
  }

  // @override
  // String toString() {
  //   return ("machineEntity: {$namemachine, $imagen,  $fuel, $grass, $quantityGrams, $quantityLiters, $tag, $periodicityFuel, $periodicityGrass}");
  // }
}
