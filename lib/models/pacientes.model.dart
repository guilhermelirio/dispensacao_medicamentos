class PacientesModel {
  String celular;
  int id;
  String nome;

  PacientesModel({this.celular, this.id, this.nome});

  PacientesModel.fromJson(Map<String, dynamic> json) {
    celular = json['celular'];
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['celular'] = this.celular;
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
