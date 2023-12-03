import 'package:flutter/material.dart';
import 'package:flutter_project_test/view/pages/my_machines.dart';
import '../../controller/login.dart';
import '../../controller/request/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _pref = SharedPreferences.getInstance();

  late LoginRequest _model;
  late LoginController _controller;
  bool loading = false;

  _LoginPageState() {
    _controller = LoginController();
    _model = LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4e495f),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFf6d6bd),
                  Color.fromARGB(255, 192, 192, 192),
                ],
              ),
            ),
            height: 305,
            child: Image.asset("lib/assets/icono.png"),
          ),
          Transform.translate(
            offset: const Offset(0, -60),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 300, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: _form(),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
              visible: loading,
              child: const Center(
                child: CircularProgressIndicator(),
              ))
        ],
      ),
    );
  }

  Widget _form() {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _user(),
          const SizedBox(height: 0),
          _password(),
          const SizedBox(height: 25),
          MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 15),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                setState(() {
                  loading = true;
                });
                //Validar email y contraseña en BD
                try {
                  final nav = Navigator.of(context);
                  var userInfo = await _controller.validatePassUser(_model);

                  var pref = await _pref;
                  pref.setString("uid", userInfo.id!);
                  pref.setString("name", userInfo.name!);
                  pref.setString("email", userInfo.email!);
                  pref.setBool("admin", userInfo.isAdmin!);

                  nav.pushReplacement(MaterialPageRoute(
                    builder: (context) => const MisEquipos(),
                  ));
                } catch (e) {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //           title: const Text("Lo sentimos"),
                  //           content: Text(e.toString()),
                  //         ));
                  setState(() {
                    loading = false;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Iniciar Sesión"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _singup(),
          const SizedBox(height: 16),
          _alternativelogin(),
        ],
      ),
    );
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  Widget _user() {
    return TextFormField(
      maxLength: 100,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: "Usuario:"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "El correo electronico es obligatorio";
        }
        if (!value.contains("@") &&
            !value.contains(".com") &&
            !value.contains(".es")) {
          return "No valido, Ejem: ejemplo@valido.com";
        }

        if (value.contains(" ")) {
          return "El correo tiene un formato invalido";
        }
        return null;
      },
      onSaved: (value) {
        _model.email = value!;
      },
    );
  }

  Widget _password() {
    return TextFormField(
      maxLength: 20,
      decoration: const InputDecoration(labelText: "Contraseña:"),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "La contraseña es obligatoria";
        }
        if (value.length < 6) {
          return "La contraseña debe ser minimo de 6 caracteres";
        }
        return null;
      },
      onSaved: (value) {
        _model.password = value!;
      },
    );
  }

  Widget _singup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("No tienes cuenta?   "),
        TextButton(
            onPressed: () {
              _showRegister(context);
            },
            child: const Text("Registrate"))
      ],
    );
  }

  Widget _alternativelogin() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        color: Colors.red[800],
        textColor: Colors.white,
        onPressed: () {},
        child: const Text("Google"),
      ),
      MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        color: Colors.blue[900],
        textColor: Colors.white,
        onPressed: () {},
        child: const Text("Facebook"),
      ),
    ]);
  }
}
