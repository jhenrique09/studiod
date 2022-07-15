import 'package:flutter/material.dart';
import 'package:studiod/pages/pagina_interna.dart';

class Agendamento extends StatefulWidget {
  const Agendamento({Key? key}) : super(key: key);

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends PaginaInternaState<Agendamento> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("Agendamento"),
            elevation: 1,
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              children: [
                const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://belezaeart.com.br/wp-content/uploads/2019/05/14.jpeg")),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Salão exemplo",
                        style: TextStyle(
                          color: Color(0xff4c505b),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ))),
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    "Av. Fernandes Lima adasd as5\nFarol, Maceió - AL\n(82) 3024-4589",
                    style: TextStyle(
                      color: Color(0xff4c505b),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(36),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    DropdownButtonFormField(
                        onChanged: (val) {
                          debugPrint('selected option: $val');
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Serviço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione um serviço.';
                          }
                          return null;
                        },
                        items: const [
                          DropdownMenuItem(
                              value: "Escova/Chapinha",
                              child: Text("Escova/Chapinha")),
                          DropdownMenuItem(
                              value: "Manicure/Pedicure",
                              child: Text("Manicure/pedicure")),
                          DropdownMenuItem(
                              value: "Hidratação", child: Text("Hidratação")),
                          DropdownMenuItem(
                              value: "Selagem", child: Text("Selagem")),
                          DropdownMenuItem(
                              value: "Outros", child: Text("Outros")),
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButtonFormField(
                        onChanged: (val) {
                          debugPrint('selected option: $val');
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Data do serviço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione uma data.';
                          }
                          return null;
                        },
                        items: const [
                          DropdownMenuItem(
                              value: "04/07/2022", child: Text("04/07/2022")),
                          DropdownMenuItem(
                              value: "05/07/2022", child: Text("05/07/2022")),
                          DropdownMenuItem(
                              value: "06/07/2022", child: Text("06/07/2022")),
                          DropdownMenuItem(
                              value: "07/07/2022", child: Text("07/07/2022")),
                          DropdownMenuItem(
                              value: "08/07/2022", child: Text("08/07/2022")),
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButtonFormField(
                        onChanged: (val) {
                          debugPrint('selected option: $val');
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Hora do serviço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione um horário.';
                          }
                          return null;
                        },
                        items: const [
                          DropdownMenuItem(
                              value: "08:00", child: Text("08:00")),
                          DropdownMenuItem(
                              value: "08:30", child: Text("08:30")),
                          DropdownMenuItem(
                              value: "09:00", child: Text("09:00")),
                          DropdownMenuItem(
                              value: "09:30", child: Text("09:30")),
                          DropdownMenuItem(
                              value: "10:00", child: Text("10:00")),
                          DropdownMenuItem(
                              value: "10:30", child: Text("10:30")),
                          DropdownMenuItem(
                              value: "11:00", child: Text("11:00")),
                          DropdownMenuItem(
                              value: "11:30", child: Text("11:30")),
                          DropdownMenuItem(value: "12:00", child: Text("12:00"))
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 12),
                        ),
                        icon: const Icon(Icons.calendar_today),
                        label: const Text('Agendar'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // TODO
                          }
                        },
                      ),
                    ]),
                  ])))
        ]),
      ),
    );
  }
}
