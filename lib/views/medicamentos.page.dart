import 'package:dispensacao_medicamentos/controllers/medicamentos.controller.dart';
import 'package:dispensacao_medicamentos/views/cad_medicamentos.page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MedicinePage extends StatelessWidget {
  final MedicamentosController mController = Get.put(MedicamentosController());

  @override
  Widget build(BuildContext context) {
    mController.getMedicines();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Medicamentos'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Get.to(CadMedicamentoPage()),
              child: Icon(FontAwesomeIcons.pills),
            ),
          ),
        ],
      ),
      body: Container(
        child: GetX<MedicamentosController>(
          init: MedicamentosController(),
          builder: (_) => _.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _.listMedicines.isEmpty
                  ? Center(child: Text('Nenhum medicamento cadastrado.'))
                  : Container(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _.listMedicines.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                child: ListTile(
                                    isThreeLine: true,
                                    title: Text(
                                      _.listMedicines[index].codBarras,
                                    ),
                                    subtitle: Text(_.listMedicines[index].nome +
                                        ' (' +
                                        _.listMedicines[index].laboratorio +
                                        ')'
                                            '\n' +
                                        _.listMedicines[index].apresentacao)),
                              ),
                            );
                          }),
                    ),
        ),
      ),
    );
  }
}
