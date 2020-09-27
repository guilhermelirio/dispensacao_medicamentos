import 'package:dispensacao_medicamentos/widgets/cria_input.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pacientes.controller.dart';

class CadPacientePage extends StatelessWidget {
  final PacientesController uController = Get.put(PacientesController());

  final FocusNode nomeFocus = FocusNode();
  final FocusNode celularFocus = FocusNode();
  TextEditingController nomeController = TextEditingController();
  TextEditingController celularController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Cadastrar Paciente'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 5, right: 15, bottom: 10),
              child: Text(
                'Novo Paciente',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            CriaInput(
              controller: nomeController,
              tipo: TextInputType.text,
              isPassword: false,
              setInput: uController.nome,
              icone: Icons.person,
              hint: 'Nome',
              focoInicial: nomeFocus,
              focoFinal: celularFocus,
              acaoKeyboard: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            CriaInput(
              controller: celularController,
              tipo: TextInputType.phone,
              isPassword: false,
              setInput: uController.celular,
              icone: Icons.phone_android,
              hint: 'Celular',
              formatacao: 'tel',
              focoInicial: celularFocus,
              acaoKeyboard: TextInputAction.done,
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Obx(
                  () => FlatButton(
                    child: uController.isLoadingCad.value
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
                      bool result = await uController.cadUser();
                      if (result) {
                        nomeController.clear();
                        celularController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
