class DetalhesModel {
  int id;
  String data;
  List<MedicamentosDispensados> medicamentosDispensados;
  Paciente paciente;

  DetalhesModel(
      {this.id, this.data, this.medicamentosDispensados, this.paciente});

  DetalhesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'];
    if (json['medicamentos_dispensados'] != null) {
      medicamentosDispensados = new List<MedicamentosDispensados>();
      json['medicamentos_dispensados'].forEach((v) {
        medicamentosDispensados.add(new MedicamentosDispensados.fromJson(v));
      });
    }
    paciente = json['paciente'] != null
        ? new Paciente.fromJson(json['paciente'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    if (this.medicamentosDispensados != null) {
      data['medicamentos_dispensados'] =
          this.medicamentosDispensados.map((v) => v.toJson()).toList();
    }
    if (this.paciente != null) {
      data['paciente'] = this.paciente.toJson();
    }
    return data;
  }
}

class MedicamentosDispensados {
  Medicamento medicamento;
  int quantidade;

  MedicamentosDispensados({this.medicamento, this.quantidade});

  MedicamentosDispensados.fromJson(Map<String, dynamic> json) {
    medicamento = json['medicamento'] != null
        ? new Medicamento.fromJson(json['medicamento'])
        : null;
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicamento != null) {
      data['medicamento'] = this.medicamento.toJson();
    }
    data['quantidade'] = this.quantidade;
    return data;
  }
}

class Medicamento {
  String nome;
  String apresentacao;
  String laboratorio;

  Medicamento({this.nome, this.apresentacao, this.laboratorio});

  Medicamento.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    apresentacao = json['apresentacao'];
    laboratorio = json['laboratorio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['apresentacao'] = this.apresentacao;
    data['laboratorio'] = this.laboratorio;
    return data;
  }
}

class Paciente {
  String nome;

  Paciente({this.nome});

  Paciente.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    return data;
  }
}
