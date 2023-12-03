import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/machines.dart';
import 'fb_storage.dart';

class MachineRepository {
  late final CollectionReference _collection;
  late FirebaseStorageRepository _storageRepository;

  MachineRepository() {
    _collection = FirebaseFirestore.instance.collection("machines");
    _storageRepository = FirebaseStorageRepository();
  }

  Future<MachineEntity> findByTag(String tag) async {
    final query = await _collection
        .doc(tag)
        .withConverter<MachineEntity>(
          fromFirestore: MachineEntity.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .get();
    return Future(() => query.data()!);
  }

  Future<void> savedMachine(MachineEntity machine) async {
    if (machine.imagen != null) {
      // cargo la foto en storage
      var url =
          await _storageRepository.loadFile(machine.imagen!, "machines/photo");
      // cambio direccion foto por la del storage
      machine.imagen = url;
    }

    await _collection
        .doc(machine.tag)
        .withConverter(
          fromFirestore: MachineEntity.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .set(machine);
  }
}
