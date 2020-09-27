class MedicinesModel {
  String apresentacao;
  String codBarras;
  int id;
  String laboratorio;
  String nome;

  MedicinesModel(
      {this.apresentacao,
      this.codBarras,
      this.id,
      this.laboratorio,
      this.nome});

  MedicinesModel.fromJson(Map<String, dynamic> json) {
    apresentacao = json['apresentacao'];
    codBarras = json['cod_barras'];
    id = json['id'];
    laboratorio = json['laboratorio'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apresentacao'] = this.apresentacao;
    data['cod_barras'] = this.codBarras;
    data['id'] = this.id;
    data['laboratorio'] = this.laboratorio;
    data['nome'] = this.nome;
    return data;
  }
}
