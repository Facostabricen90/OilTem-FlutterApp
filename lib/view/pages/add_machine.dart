import 'package:flutter/material.dart';

import '../../controller/add_machine.dart';
import '../../controller/request/add_machine.dart';
import '../widgets/photo_avatar.dart';
//import '../../controller/login.dart';

class AddMachine extends StatefulWidget {
  const AddMachine({super.key});

  @override
  State<AddMachine> createState() => _AddMachineState();
}

class _AddMachineState extends State<AddMachine> {
  @override
  Widget build(BuildContext context) {
    late AddMachineRequest data = AddMachineRequest();
    late AddMachineController controller = AddMachineController();
    var formKey = GlobalKey<FormState>();
    final PhotoAvatarWidget avatar = PhotoAvatarWidget();
    bool loading = false;

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
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 500),
                    child: const Icon(Icons.camera_alt, size: 130),
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
            child: Stack(
              children: <Widget>[
                Center(
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
                                  "Nombre del equipo:",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.namemachine = newValue!;
                                  },
                                ),
                                _campoImagen("Foto del Equipo N°:",
                                    validarCampoObligatorio, (newValue) {
                                  data.imagen = newValue!;
                                }, avatar),
                                _camposDeRegistro(
                                  "Tag:",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.tag = newValue!;
                                  },
                                ),
                                _camposDeRegistro(
                                  "Grasa:",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.grass = newValue!;
                                  },
                                  //isPassword: true,
                                ),
                                _camposDeRegistro(
                                  "Aceite",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.fuel = newValue!;
                                  },
                                ),
                                _camposDeRegistro(
                                  "Cantidad en gramos (Grasa)",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.quantityGrams = newValue!;
                                  },
                                ),
                                _camposDeRegistro(
                                  "Cantidad en litros (Aceite)",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.quantityLiters = newValue!;
                                  },
                                ),
                                _camposDeRegistro(
                                  "Periocidad (Grasa)",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.periodicityGrass = newValue!;
                                  },
                                ),
                                _camposDeRegistro(
                                  "Periocidad (Aceite)",
                                  validarCampoObligatorio,
                                  (newValue) {
                                    data.periodicityFuel = newValue!;
                                  },
                                ),
                                const SizedBox(height: 15),
                                MaterialButton(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      setState(() {
                                        loading = true;
                                      });
                                      data.imagen = avatar.photo.toString();

                                      try {
                                        await controller.addMachine(data);

                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Equipo Registrado satisfactoriamente!!")));

                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);

                                        setState(() {
                                          loading = false;
                                        });
                                      } catch (error) {
                                        setState(() {
                                          loading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                      Text("Agregar Equipo"),
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
                Visibility(
                    visible: loading,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ))
              ],
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
      {bool isTag = false}) {
    return TextFormField(
      maxLength: 100,
      obscureText: isTag,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: title),
      validator: validate,
      onSaved: save,
    );
  }

  Widget _campoImagen(String title, FormFieldValidator<String> validate,
      FormFieldSetter<String> save, Widget avatar) {
    return TextFormField(
      maxLength: 100,
      autofocus: true,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        icon: avatar,
        border: const OutlineInputBorder(),
        labelText: title,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "El campo es obligatorio";
        }
        return null;
      },
      onSaved: save,
    );
  }
}
