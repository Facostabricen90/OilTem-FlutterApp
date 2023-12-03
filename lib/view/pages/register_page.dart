import 'package:flutter/material.dart';
import '../../controller/login.dart';
import '../../controller/request/register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    late RegisterRequest data = RegisterRequest();
    late LoginController controller = LoginController();
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFF4e495f),
      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 500),
                    child: Image.asset(
                      "lib/assets/icono.png",
                      scale: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: kToolbarHeight + 25,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  color: const Color(0xFFf6d6bd),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _camposDeRegistro(
                              "Nombre",
                              validarCampoObligatorio,
                              (newValue) {
                                data.name = newValue!;
                              },
                            ),
                            _camposDeRegistro(
                              "email",
                              validarCampoObligatorio,
                              (newValue) {
                                data.email = newValue!;
                              },
                            ),
                            _camposDeRegistro(
                              "contraseña",
                              validarCampoObligatorio,
                              (newValue) {
                                data.password = newValue!;
                              },
                              isPassword: true,
                            ),
                            _camposDeRegistro(
                              "telefono",
                              (value) => null,
                              (newValue) {
                                data.phone = newValue;
                              },
                            ),
                            _camposDeRegistro(
                              "direccion",
                              (value) => null,
                              (newValue) {
                                data.address = newValue;
                              },
                            ),
                            const SizedBox(height: 15),
                            MaterialButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  try {
                                    controller.registerNewUser(data);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "El usuario se ha creado!!")));
                                    Navigator.pop(context);
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error.toString()),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text("Registrarme"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validarCampoObligatorio(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio";
    }
    return null;
  }

  Widget _camposDeRegistro(String title, FormFieldValidator<String> validate,
      FormFieldSetter<String> save,
      {bool isPassword = false}) {
    return TextFormField(
      maxLength: 100,
      obscureText: isPassword,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: title),
      validator: validate,
      onSaved: save,
    );
  }
}
