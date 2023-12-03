import 'package:flutter_project_test/controller/request/add_machine.dart';

import '../model/entity/machines.dart';
import '../model/repository/machines.dart';

class AddMachineController {
  late final MachineRepository _machineRepository;

  AddMachineController() {
    _machineRepository = MachineRepository();
  }

  Future<void> addMachine(AddMachineRequest request) async {
    try {
      await _machineRepository.findByTag(request.tag);
      return Future.error("Ya existe un equipo con este tag");
    } catch (e) {
      // Crear correo/clave en Firebase Authentication
      await _machineRepository.savedMachine(MachineEntity(
          namemachine: request.namemachine,
          imagen: request.imagen,
          fuel: request.fuel,
          grass: request.grass,
          quantityGrams: request.quantityGrams,
          quantityLiters: request.quantityLiters,
          tag: request.tag,
          periodicityFuel: request.periodicityFuel,
          periodicityGrass: request.periodicityGrass));
    }
  }

  Future<MachineEntity> findByTag(String tag) async {
    try {
      var response = await _machineRepository.findByTag(tag);

      return Future.value(MachineEntity(
          namemachine: response.namemachine,
          imagen: response.imagen,
          fuel: response.fuel,
          grass: response.grass,
          quantityGrams: response.quantityGrams,
          quantityLiters: response.quantityLiters,
          tag: response.tag,
          periodicityFuel: response.periodicityFuel,
          periodicityGrass: response.periodicityGrass));
    } catch (e) {
      throw "No se encontró ningún tag";
    }
  }
}
