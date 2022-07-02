import 'package:flutter/material.dart';

class Saloes extends StatelessWidget {
  const Saloes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = ["Salão exemplo", "Salão exemplo 2"];
    final subtitles = [
      "R. Dr. Antônio Cansanção\nPonta Verde, Maceió - AL\n(82) 3325-4589",
      "Av. Fernandes Lima\nFarol, Maceió - AL\n(82) 3024-4589"
    ];
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: InkWell(
                  onTap: () => {Navigator.pushNamed(context, 'agendamento')},
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ListTile(
                              title: Text(titles[index]),
                              subtitle: Text(subtitles[index]),
                              leading: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://belezaeart.com.br/wp-content/uploads/2019/05/14.jpeg")))))));
        });
  }
}
