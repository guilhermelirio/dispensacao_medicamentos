import 'package:dispensacao_medicamentos/views/dispensacao.page.dart';
import 'package:dispensacao_medicamentos/views/medicamentos.page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'pacientes.page.dart';

class InicialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hasura + GetX')),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ActionButton(
                ' Pacientes',
                FontAwesomeIcons.personBooth,
                PatientPage(),
              ),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                ' Medicamentos',
                FontAwesomeIcons.pills,
                MedicinePage(),
              ),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                'Dispensações',
                FontAwesomeIcons.fileMedical,
                DispensacaoPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ActionButton(String text, IconData icon, Widget page) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      onPressed: () => Get.to(page),
    ),
  );
}
