import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/login.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _pref = SharedPreferences.getInstance();
  final _loginController = LoginController();
  String _name = "";
  String _email = "";
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();

    _pref.then((pref) {
      setState(() {
        _name = pref.getString("name") ?? "N/A";
        _email = pref.getString("email") ?? "N/A";
        _isAdmin = pref.getBool("admin") ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4e495f),
            ),
            child: _header(),
          ),
          if (_isAdmin)
            ListTile(
              leading: const Icon(Icons.plus_one),
              title: const Text('Agregar Maquinas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/addMachine");
              },
            ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar sesion'),
            onTap: () async {
              var nav = Navigator.of(context);
              // Cerrar sesion en Auth de Firebase
              _loginController.logout();

              // Limpiar las preferences
              var pref = await _pref;
              pref.remove("uid");
              pref.remove("email");
              pref.remove("name");
              pref.remove("admin");

              // Volver a pagina de login
              nav.pushNamed("/");
            },
          ),
        ],
      ),
    );
  }

  Widget _header() {
    // Consultar los datos de la cabecera
    const image = Icon(Icons.manage_accounts);

    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          child: image,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _email,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
