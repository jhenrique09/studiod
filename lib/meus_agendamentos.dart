import 'package:flutter/material.dart';

class MeusAgendamentos extends StatelessWidget {
  const MeusAgendamentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = ["Salão exemplo", "Salão exemplo 2"];
    final subtitles = [
      "Unhas, cabelo\n26/02/2022 - 19:45",
      "Unhas, cabelo\n30/05/2022 - 19:45"
    ];
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: ListTile(
                          title: Text(titles[index]),
                          subtitle: Text(subtitles[index])))));
        });
  }
}
