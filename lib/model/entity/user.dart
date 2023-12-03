import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  late String? id;
  late String? email;
  late String? name;
  late String? address;
  late String? phone;
  late bool? isAdmin;

  UserEntity({this.email, this.name, this.address, this.phone, this.isAdmin});

  factory UserEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    var data = snapshot.data();
    return UserEntity(
      email: data?["email"],
      name: data?["name"],
      address: data?["address"],
      phone: data?["phone"],
      isAdmin: data?["isAdmin"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null && email!.isNotEmpty) "email": email,
      if (name != null && name!.isNotEmpty) "name": name,
      if (phone != null && phone!.isNotEmpty) "phone": phone,
      if (address != null && address!.isNotEmpty) "address": address,
      "isAdmin": isAdmin ?? false
    };
  }

  @override
  String toString() {
    return "UserEntity: {$email, $name, $address, $phone, $isAdmin}";
  }
}
