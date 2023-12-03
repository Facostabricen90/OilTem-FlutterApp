import 'request/register.dart';
import '../model/entity/user.dart';
import '../model/repository/fb_auth.dart';
import '../model/repository/user.dart';
import 'request/login.dart';
import 'response/userinfo.dart';

class LoginController {
  late final UserRepository _userRepository;
  late final FireBaseAutenticationRepository _fbRepository;

  LoginController() {
    _userRepository = UserRepository();
    _fbRepository = FireBaseAutenticationRepository();
  }

  Future<UserInfoResponse> validatePassUser(LoginRequest req) async {
    await _fbRepository.fBLogUserCreated(req.email, req.password);
    //consultar el usuario que tenga el correo dado
    var user = await _userRepository.findByEmail(req.email);
    return UserInfoResponse(
      id: user.id,
      email: user.email,
      name: user.name,
      isAdmin: user.isAdmin,
    );
  }

  Future<void> registerNewUser(RegisterRequest request,
      {bool adminUser = false}) async {
    try {
      await _userRepository.findByEmail(request.email);
      return Future.error("Ya existe un usuario con este correo electrónico");
    } catch (e) {
      // No existe el correo en la base de datos

      // Crear correo/clave en Firebase Authentication
      await _fbRepository.createEmailPasswordAccount(
          request.email, request.password);

      // Agregar informacion adicional en base de datos
      _userRepository.savedUser(UserEntity(
          email: request.email,
          name: request.name,
          address: request.address,
          phone: request.phone,
          isAdmin: adminUser));
    }
  }

  Future<void> logout() async {
    await _fbRepository.signOut();
  }
}
