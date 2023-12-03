import 'package:flutter/material.dart';
import 'package:flutter_project_test/model/entity/machines.dart';

class ViewMachine extends StatefulWidget {
  final MachineEntity machineEntity;

  const ViewMachine(this.machineEntity, {Key? key}) : super(key: key);

  @override
  State<ViewMachine> createState() => _ViewMachineState();
}

class _ViewMachineState extends State<ViewMachine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machineEntity.namemachine.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Center(
              child: Image.network(
                widget.machineEntity.imagen!,
                width: 400,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "TAG: ",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 100, 94, 93),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: widget.machineEntity.tag.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 100, 94, 93),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                DataTable(
                  // ignore: prefer_const_literals_to_create_immutables
                  columns: [
                    const DataColumn(
                        label: Text('Descripción',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    const DataColumn(
                        label: Text('Referencia',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('Grasa:')),
                      DataCell(Text(widget.machineEntity.grass.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Cantidad en gramos (Grasa):')),
                      DataCell(
                          Text(widget.machineEntity.quantityGrams.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Periocidad (Grasa):')),
                      DataCell(Text(
                          widget.machineEntity.periodicityGrass.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Aceite:')),
                      DataCell(Text(widget.machineEntity.fuel.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Cantidad en litros (Aceite):')),
                      DataCell(
                          Text(widget.machineEntity.quantityLiters.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Periocidad (Aceite):')),
                      DataCell(Text(
                          widget.machineEntity.periodicityFuel.toString())),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
