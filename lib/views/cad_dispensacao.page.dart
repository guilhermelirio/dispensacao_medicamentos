import 'package:dispensacao_medicamentos/controllers/dispensacao.controller.dart';
import 'package:dispensacao_medicamentos/controllers/medicamentos.controller.dart';
import 'package:dispensacao_medicamentos/controllers/pacientes.controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_select/smart_select.dart';

class CadDispensacao extends StatelessWidget {
  final DispensacaoController dController = Get.put(DispensacaoController());
  final MedicamentosController mController = Get.put(MedicamentosController());
  final PacientesController uController = Get.put(PacientesController());

  final FocusNode codBarrasFocus = FocusNode();
  final FocusNode nomeFocus = FocusNode();
  final FocusNode apresentacaoFocus = FocusNode();
  final FocusNode labFocus = FocusNode();
  TextEditingController coBarrasController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController apresentacaoController = TextEditingController();
  TextEditingController labController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mController.getMedicines();
    uController.getUsers();
    dController.medSel.clear();
    print(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Cadastrar Dispensação'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 5, right: 15, bottom: 10),
                child: Text(
                  'Nova Dispensação',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Obx(
                () => dController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SmartSelect<String>.single(
                        title: 'Paciente',
                        placeholder: 'Selecione um paciente',
                        isTwoLine: true,
                        leading: Icon(FontAwesomeIcons.personBooth),
                        value: uController.userSel(),
                        options: uController.optionsUsers,
                        onChange: uController.userSel,
                      ),
              ),
              Obx(
                () => uController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SmartSelect<String>.multiple(
                        title: 'Medicamentos',
                        isTwoLine: true,
                        leading: Icon(FontAwesomeIcons.notesMedical),
                        value: dController.medSel.value,
                        placeholder: 'Selecione um ou mais medicamentos',
                        options: mController.optionsMedicines,
                        onChange: (val) => dController.medSel.value = val,
                      ),
              ),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Obx(
                  () => FlatButton(
                    child: dController.isLoadingCad.value
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: Icon(
                                Icons.send,
                                size: 16,
                                color: Colors.white,
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "CADASTRAR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                    onPressed: () async {
                      bool result = await dController.cadDispensacao(
                          paciente: uController.userSel.value);
                      if (result) {
                        uController.userSel.value = '';
                        dController.medSel.clear();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
