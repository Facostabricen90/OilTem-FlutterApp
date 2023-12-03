import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAutenticationRepository {
  Future<void> createEmailPasswordAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('La contraseña es demasiado debil');
      } else if (e.code == 'email-already-in-use') {
        return Future.error(
            'El correo ya se encuentra con una cuenta registrada');
      }
    }
  }

  Future<void> fBLogUserCreated(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('La cuenta email no se encuentra registrada');
      } else if (e.code == 'wrong-password') {
        return Future.error('La contraseña es incorrecta para este usuario');
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
