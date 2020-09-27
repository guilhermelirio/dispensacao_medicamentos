import 'package:dispensacao_medicamentos/controllers/dispensacao.controller.dart';
import 'package:dispensacao_medicamentos/views/cad_dispensacao.page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'detalhes_dispensacao.page.dart';

class DispensingPage extends StatelessWidget {
  final DispensacaoController dController = Get.put(DispensacaoController());

  var formatter = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    dController.buscaDispensacoes();
    print(dController.detalhesDisp.length);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Dispensações'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Get.to(CadDispensacao()),
              child: Icon(FontAwesomeIcons.bookMedical),
            ),
          ),
        ],
      ),
      body: Container(
        child: GetX<DispensacaoController>(
          init: DispensacaoController(),
          builder: (_) => _.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _.listDispensing.isEmpty
                  ? Center(child: Text('Nenhuma dispensação efetuada.'))
                  : Container(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _.listDispensing.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                child: ListTile(
                                  isThreeLine: true,
                                  trailing: Icon(Icons.arrow_right),
                                  title: Text(
                                    'Código: #' +
                                        _.listDispensing[index].id.toString(),
                                  ),
                                  subtitle: Text('Nome: ' +
                                      _.listDispensing[index].paciente.nome +
                                      '\nData: ' +
                                      formatter.format(DateTime.parse(
                                          _.listDispensing[index].data))),
                                  onTap: () => Get.to(DetalhesDispPage(
                                      idDispensacao:
                                          _.listDispensing[index].id)),
                                ),
                              ),
                            );
                          }),
                    ),
        ),
      ),
    );
  }
}
