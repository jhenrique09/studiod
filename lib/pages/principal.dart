import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'agendamentos.dart';
import 'estabelecimentos.dart';
import 'meus_dados.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0;
  Logger logger = Logger();

  void reca(){
    logger.d("teste");
  }

  List<Widget> _pages = [];

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

  void _onItemTapped(int index, {bool recarregarAgendamentos = false}) {
    setState(() {
      if (recarregarAgendamentos){
        _pages.removeAt(index);
        _pages.insert(index, Agendamentos(key: UniqueKey()));
      }
      _appBarTitle = menuItems[index].label!;
      _selectedIndex = index;
    });
  }

  void initPages(){
    if (_pages.isEmpty){
      _pages = <Widget>[
        Agendamentos(),
        Estabelecimentos(callbackRecarregar: () {
          _onItemTapped(0, recarregarAgendamentos: true);
        }),
        MeusDados(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    initPages();
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
