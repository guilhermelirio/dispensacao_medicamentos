import 'package:dispensacao_medicamentos/constants.dart';
import 'package:dispensacao_medicamentos/models/detalhes_dispensacao.model.dart';
import 'package:dispensacao_medicamentos/models/dispensacao.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

class DispensacaoController extends GetxController {
  HasuraConnect conexao = HasuraConnect(GRAPHQL_URL);

  RxBool isLoading = false.obs;
  RxBool isLoadingCad = false.obs;
  RxBool isLoadingDet = false.obs;

  RxList medSel = <String>[].obs;

  RxList listDispensing = List<DispensacaoModel>().obs;

  RxList detalhesDisp = List<DetalhesModel>().obs;

  buscaDispensacoes() async {
    listDispensing.clear();
    isLoading.value = true;

    var data = await conexao.query(Queries().listaDispensacao);

    for (var disp in data["data"]["dispensacao"]) {
      listDispensing.add(DispensacaoModel.fromJson(disp));
    }
    isLoading.value = false;

    print(data["data"]["dispensacao"]);
  }

  Future<bool> cadDispensacao({String paciente}) async {
    if (paciente.isEmpty || paciente.isNull || medSel.isEmpty) {
      Get.snackbar(
        "Erro", // title
        'Os dados da dispensação não podem ficar em branco!', // message
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
    } else {
      isLoadingCad.value = true;
      var response;
      var response2;
      var idPaciente = int.tryParse(paciente);

      response =
          await conexao.mutation(Queries().cadastrarDispensacao(idPaciente));

      if (response["data"]["insert_dispensacao"]["affected_rows"] == 1) {
        int idDispenscaco =
            response["data"]["insert_dispensacao"]["returning"][0]["id"];

        for (var idM in medSel) {
          response2 = await conexao.mutation(Queries()
              .cadastrarMedicamentosDispensacao(
                  idDispenscaco, int.tryParse(idM)));
        }

        if (response2["data"]["insert_medicamentos_dispensacao"]
                ["affected_rows"] >=
            1) {
          Get.snackbar(
            "Confirmação", // title
            'Dispensação cadastrada com sucesso!', // message
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
          isLoadingCad.value = false;
          buscaDispensacoes();
          return true;
        } else {
          Get.snackbar(
            "Erro", // title
            'Erro ao cadastrar dispensação. Tente novamente!', // message
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
          isLoadingCad.value = false;
          return false;
        }
      } else {
        Get.snackbar(
          "Erro", // title
          'Erro ao cadastrar dispensação. Tente novamente!', // message
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
        isLoadingCad.value = false;
        return false;
      }
    }
  }

  detalheDispensacao(int idDispensacao) async {
    detalhesDisp.clear();
    isLoadingDet.value = true;

    var response;

    response = await conexao.query(Queries().detalheDispensacao(idDispensacao));

    detalhesDisp
        .add(DetalhesModel.fromJson(response["data"]["dispensacao"][0]));

    print(detalhesDisp[0].medicamentosDispensados[0].medicamento);

    isLoadingDet.value = false;
  }
}
