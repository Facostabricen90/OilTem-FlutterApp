// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_project_test/view/pages/view_machine.dart';
import '../../controller/add_machine.dart';
import '../widgets/drawer_widget.dart';

class MisEquipos extends StatefulWidget {
  const MisEquipos({super.key});

  @override
  State<MisEquipos> createState() => _MisEquiposState();
}

class _MisEquiposState extends State<MisEquipos> {
  late AddMachineController findMachinecontroller;
  late TextEditingController textEditingController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    findMachinecontroller = AddMachineController();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Equipos"),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Image.asset(
                    "lib/assets/machines.png",
                    width: 200,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 1, bottom: 1),
                  child: Text(
                    "Equipos disponibles",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ),
                ),

                DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      child: Text("Elija el equipo"),
                    ),
                  ],
                  onChanged: (value) {},
                ),

                ////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////

                Container(
                  height: 40,
                  width: 300,
                  margin: const EdgeInsets.all(16),
                  child: TextField(
                    controller: textEditingController,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
                      fillColor: const Color.fromARGB(97, 164, 82, 10),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0.8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                      hintText: "Buscar por TAG",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 15,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, size: 15),
                          onPressed: () => textEditingController.text = ""),
                    ),
                  ),
                ),

                //////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////

                Container(
                  height: 40,
                  width: 300,
                  margin: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    child: const Text("Buscar"),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                    onPressed: () async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        var machine = await findMachinecontroller
                            .findByTag(textEditingController.text);
                        setState(() {
                          loading = false;
                        });

                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewMachine(machine)));
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),
                ),
              ],
            ),
            Visibility(
                visible: loading,
                child: const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
