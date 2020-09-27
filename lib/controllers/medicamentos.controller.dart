import 'package:dispensacao_medicamentos/constants.dart';
import 'package:dispensacao_medicamentos/models/medicamentos.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:smart_select/smart_select.dart';

class MedicamentosController extends GetxController {
  HasuraConnect conexao = HasuraConnect(GRAPHQL_URL);

  RxBool isLoading = false.obs;
  RxBool isLoadingCad = false.obs;

  RxString codBarras = ''.obs;
  RxString nome = ''.obs;
  RxString apresentacao = ''.obs;
  RxString laboratorio = ''.obs;

  RxList listMedicines = List<MedicinesModel>().obs;
  List<SmartSelectOption<String>> optionsMedicines = [];
  //RxList listSelectMedicines = List<SmartSelectOption<String>>().obs;

  getMedicines() async {
    listMedicines.clear();
    optionsMedicines.clear();
    isLoading.value = true;

    var data = await conexao.query(Queries().listMedicines);

    for (var med in data["data"]["medicamentos"]) {
      listMedicines.add(MedicinesModel.fromJson(med));
      optionsMedicines.add(SmartSelectOption<String>(
          value: med["id"].toString(),
          title:
              '${med["nome"]} ${med["apresentacao"]} (${med["laboratorio"]})'));
    }

    isLoading.value = false;
    //print(data["data"]["medicamentos"]);
  }

  Future<bool> cadMedicine() async {
    isLoadingCad.value = true;

    var response = await conexao.mutation(Queries().cadastrarMedicamento(
        codBarras.toString(),
        nome.toString(),
        apresentacao.toString(),
        laboratorio.toString()));

    isLoadingCad.value = false;

    if (response["data"]["insert_medicamentos"]["affected_rows"] == 1) {
      Get.snackbar(
        "Confirmação", // title
        'Medicamento cadastrado com sucesso!', // message
        icon: Icon(Icons.check_box),
        shouldIconPulse: true,
        barBlur: 50,
        isDismissible: false,
        margin: EdgeInsets.all(8),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      getMedicines();
      return true;
    } else {
      Get.snackbar(
        "Erro", // title
        'Erro ao cadastrar paciente. Tente novamente!', // message
        icon: Icon(Icons.error),
        shouldIconPulse: true,
        barBlur: 50,
        isDismissible: false,
        margin: EdgeInsets.all(8),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
