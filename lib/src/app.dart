import 'package:flutter/material.dart';
import 'package:flutter_project_test/view/pages/add_machine.dart';
import '../view/pages/my_machines.dart';
import '../view/pages/login_page.dart';
import '../view/pages/register_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OilTemp',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: const Color(0xFF4e495f),
        primarySwatch: Colors.brown,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            switch (settings.name) {
              case "/":
                return const LoginPage();
              case "/register":
                return const RegisterPage();
              case "/myteams":
                return const MisEquipos();
              case "/addMachine":
                return const AddMachine();
              default:
                return const LoginPage();
            }
          },
        );
      },
    );
  }
}
