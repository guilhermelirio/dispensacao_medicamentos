import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CriaInput extends StatelessWidget {
  var label = "";
  var hint = "";
  bool isPassword = false;
  Function setInput;
  TextInputType tipo;
  String formatacao;
  String valorInicial;
  FocusNode focoInicial;
  FocusNode focoFinal;
  TextInputAction acaoKeyboard;
  IconData icone;
  TextEditingController controller;
  bool habilitado;

  var maskTelefone = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  CriaInput({
    this.label,
    @required this.isPassword,
    @required this.tipo,
    @required this.setInput,
    this.formatacao,
    @required this.icone,
    this.controller,
    this.focoInicial,
    this.focoFinal,
    this.acaoKeyboard,
    this.valorInicial,
    this.hint,
    this.habilitado = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: isPassword || tipo == TextInputType.emailAddress
          ? TextCapitalization.none
          : TextCapitalization.words,
      inputFormatters: formatacao == 'tel' ? [maskTelefone] : null,
      controller: controller,
      onChanged: setInput,
      enabled: habilitado,
      autocorrect: false,
      keyboardType: tipo,
      obscureText: isPassword,
      textAlign: TextAlign.left,
      initialValue: valorInicial,
      focusNode: focoInicial,
      textInputAction: acaoKeyboard,
      onFieldSubmitted: (_) {
        acaoKeyboard == TextInputAction.next
            ? fieldFocusChange(context, focoInicial, focoFinal)
            : focoInicial.unfocus();
      },
      //Decoração
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        prefixIcon: Icon(
          icone,
          color: Color(0xFF666666),
          size: 16,
        ),
        fillColor: Color(0xFFF2F3F5),
        hintStyle: TextStyle(color: Color(0xFF666666), fontSize: 16),
        hintText: hint,
      ),
    );
  }
}

fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
