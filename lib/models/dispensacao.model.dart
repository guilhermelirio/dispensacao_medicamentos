class DispensacaoModel {
  String data;
  int id;
  int idPaciente;
  Paciente paciente;

  DispensacaoModel({this.data, this.id, this.idPaciente, this.paciente});

  DispensacaoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    id = json['id'];
    idPaciente = json['id_paciente'];
    paciente = json['paciente'] != null
        ? new Paciente.fromJson(json['paciente'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['id'] = this.id;
    data['id_paciente'] = this.idPaciente;
    if (this.paciente != null) {
      data['paciente'] = this.paciente.toJson();
    }
    return data;
  }
}

class Paciente {
  String nome;
  int id;

  Paciente({this.nome, this.id});

  Paciente.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id'] = this.id;
    return data;
  }
}
