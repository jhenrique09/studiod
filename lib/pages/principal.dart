import 'package:flutter/material.dart';

import 'meus_agendamentos.dart';
import 'meus_dados.dart';
import 'saloes.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MeusAgendamentos(),
    Saloes(),
    MeusDados(),
  ];

  static const List<BottomNavigationBarItem> menuItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.schedule),
      label: 'Agendamentos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.store),
      label: 'Salões',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Meus dados',
    ),
  ];

  String _appBarTitle = 'Agendamentos';

  void _onItemTapped(int index) {
    setState(() {
      _appBarTitle = menuItems[index].label!;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Image.asset(
                  "assets/appbar_icone_black.png",
                  width: 32,
                  height: 32,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(_appBarTitle)
              ],
            ),
            centerTitle: false,
            elevation: 1,
          )),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: menuItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
