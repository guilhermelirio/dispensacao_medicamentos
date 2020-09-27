import 'package:dispensacao_medicamentos/views/cad_pacientes.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pacientes.controller.dart';

class PatientPage extends StatelessWidget {
  final PacientesController uController = Get.put(PacientesController());

  @override
  Widget build(BuildContext context) {
    uController.getUsers();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Pacientes'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Get.to(CadUserPage()),
              child: Icon(Icons.person_add),
            ),
          ),
        ],
      ),
      body: Container(
        child: GetX<PacientesController>(
          init: PacientesController(),
          builder: (_) => _.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _.listUsers.isEmpty
                  ? Center(child: Text('Nenhum paciente cadastrado.'))
                  : Container(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _.listUsers.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                child: ListTile(
                                    title: Text(
                                      '#' +
                                          _.listUsers[index].id.toString() +
                                          ' ' +
                                          _.listUsers[index].nome,
                                    ),
                                    subtitle: Text(_.listUsers[index].celular)),
                              ),
                            );
                          }),
                    ),
        ),
      ),
    );
  }
}
