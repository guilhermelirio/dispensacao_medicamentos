import 'package:dispensacao_medicamentos/controllers/dispensacao.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetalhesDispPage extends StatelessWidget {
  final int idDispensacao;
  DetalhesDispPage({Key key, this.idDispensacao}) : super(key: key);

  var formatter = new DateFormat('dd/MM/yyyy');

  final DispensacaoController dController = Get.put(DispensacaoController());

  @override
  Widget build(BuildContext context) {
    dController.detalheDispensacao(idDispensacao);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Detalhes da Dispensação'),
      ),
      body: GetX<DispensacaoController>(
        init: DispensacaoController(),
        builder: (_) => _.isLoadingDet.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: size.height,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informações',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Código Dispesação: #${dController.detalhesDisp[0].id}'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Data: ${formatter.format(DateTime.parse(dController.detalhesDisp[0].data))}'),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paciente',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${dController.detalhesDisp[0].paciente.nome}'),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Medicamento(s)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nome'),
                        Text('Apresentação'),
                        Text('Lab'),
                        Text('Qnt'),
                      ],
                    ),
                    Divider(),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dController
                              .detalhesDisp[0].medicamentosDispensados.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(dController
                                        .detalhesDisp[0]
                                        .medicamentosDispensados[index]
                                        .medicamento
                                        .nome),
                                    Text(dController
                                        .detalhesDisp[0]
                                        .medicamentosDispensados[index]
                                        .medicamento
                                        .apresentacao),
                                    Text(dController
                                        .detalhesDisp[0]
                                        .medicamentosDispensados[index]
                                        .medicamento
                                        .laboratorio),
                                    Text(dController
                                        .detalhesDisp[0]
                                        .medicamentosDispensados[index]
                                        .quantidade
                                        .toString())
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                    Divider(),
                  ],
                ),
              ),
      ),
    );
  }
}
