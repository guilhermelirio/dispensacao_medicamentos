const GRAPHQL_URL = "YOUR_GRAPHQL_ENDPOINT";

class Queries {
  String listaPacientes = """
    query listaPacientes {
      pacientes {
        id
        celular
        nome
      }
    }
  """;

  String listMedicines = """
    query listMedicines {
      medicamentos {
        apresentacao
        cod_barras
        id
        laboratorio
        nome
      }
    }
  """;

  String listaDispensacao = """
    query listaDispensacao {
      dispensacao {
        id
        data
        id_paciente
        paciente {
          nome
          id
        }
      }
    }
  """;

  String cadastrarPaciente(String nome, String celular) {
    return ("""
      mutation cadUser {
        insert_pacientes(objects: {celular: "$celular", nome: "$nome"}) {
          affected_rows
        }
      }
      """);
  }

  String cadastrarMedicamento(
      String codBarras, String nome, String apresentacao, String laboratorio) {
    return ("""
      mutation cadMedicine {
        insert_medicamentos(objects: {apresentacao: "$apresentacao", cod_barras: "$codBarras", laboratorio: "$laboratorio", nome: "$nome"}) {
          affected_rows
        }
      }
      """);
  }

  String cadastrarDispensacao(int idPaciente) {
    return ("""
      mutation cadDispensing {
        insert_dispensacao(objects: {data: "${DateTime.now().toIso8601String()}", id_paciente: $idPaciente}) {
          affected_rows
          returning {
            id
          }
        }
      }
    """);
  }

  String cadastrarMedicamentosDispensacao(
      int idDispensacao, int idMedicamento) {
    return ("""
      mutation cadDispensing {
        insert_medicamentos_dispensacao(objects: {quantidade: 1, id_dispensacao: "$idDispensacao", id_medicamento: $idMedicamento}) {
          affected_rows
        }
      }
    """);
  }

  String detalheDispensacao(int idDispensacao) {
    return ("""
      query DetalhesDispensacao {
        dispensacao(where: {id: {_eq: "$idDispensacao" }}) {
          id
          data
          medicamentos_dispensados {
            medicamento {
              nome
              apresentacao
              laboratorio
            }
            quantidade
          }
          paciente {
            nome
          }
        }
      }
    """);
  }
}
