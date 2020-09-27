import 'package:dispensacao_medicamentos/controllers/medicamentos.controller.dart';
import 'package:dispensacao_medicamentos/widgets/cria_input.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CadMedicamentoPage extends StatelessWidget {
  final MedicamentosController mController = Get.put(MedicamentosController());

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Cadastrar Medicamento'),
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
                  'Novo Medicamento',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              CriaInput(
                controller: coBarrasController,
                tipo: TextInputType.text,
                isPassword: false,
                setInput: mController.codBarras,
                icone: FontAwesomeIcons.barcode,
                hint: 'Código de Barras',
                focoInicial: codBarrasFocus,
                focoFinal: nomeFocus,
                tamanho: 13,
                acaoKeyboard: TextInputAction.next,
              ),
              SizedBox(
                height: 5,
              ),
              CriaInput(
                controller: nomeController,
                tipo: TextInputType.text,
                isPassword: false,
                setInput: mController.nome,
                icone: FontAwesomeIcons.briefcaseMedical,
                hint: 'Nome',
                focoInicial: nomeFocus,
                focoFinal: apresentacaoFocus,
                acaoKeyboard: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              CriaInput(
                controller: apresentacaoController,
                tipo: TextInputType.text,
                isPassword: false,
                setInput: mController.apresentacao,
                icone: FontAwesomeIcons.notesMedical,
                hint: 'Apresentaçao',
                focoInicial: apresentacaoFocus,
                focoFinal: labFocus,
                acaoKeyboard: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              CriaInput(
                controller: labController,
                tipo: TextInputType.text,
                isPassword: false,
                setInput: mController.laboratorio,
                icone: FontAwesomeIcons.flask,
                hint: 'Laboratório',
                focoInicial: labFocus,
                acaoKeyboard: TextInputAction.done,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Obx(
                  () => FlatButton(
                    child: mController.isLoadingCad.value
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
                      bool result = await mController.cadMedicine();
                      if (result) {
                        coBarrasController.clear();
                        nomeController.clear();
                        labController.clear();
                        apresentacaoController.clear();
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
