import 'package:dispensacao_medicamentos/constants.dart';
import 'package:dispensacao_medicamentos/models/pacientes.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:smart_select/smart_select.dart';

class PacientesController extends GetxController {
  HasuraConnect conexao = HasuraConnect(GRAPHQL_URL);

  RxBool isLoading = false.obs;
  RxBool isLoadingCad = false.obs;

  RxString nome = ''.obs;
  RxString celular = ''.obs;
  RxString userSel = ''.obs;

  RxList listUsers = List<PacientesModel>().obs;
  List<SmartSelectOption<String>> optionsUsers = [];

  getUsers() async {
    listUsers.clear();
    optionsUsers.clear();
    userSel.value = '';
    isLoading.value = true;

    var data = await conexao.query(Queries().listaPacientes);

    for (var user in data["data"]["pacientes"]) {
      listUsers.add(PacientesModel.fromJson(user));
      optionsUsers.add(SmartSelectOption<String>(
          value: user["id"].toString(), title: user["nome"]));
    }

    isLoading.value = false;
    print(data["data"]["pacientes"]);
  }

  Future<bool> cadUser() async {
    isLoadingCad.value = true;

    var response = await conexao.mutation(
        Queries().cadastrarPaciente(nome.toString(), celular.toString()));

    isLoadingCad.value = false;

    if (response["data"]["insert_pacientes"]["affected_rows"] == 1) {
      Get.snackbar(
        "Confirmação", // title
        'Paciente cadastrado com sucesso!', // message
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
      getUsers();
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
