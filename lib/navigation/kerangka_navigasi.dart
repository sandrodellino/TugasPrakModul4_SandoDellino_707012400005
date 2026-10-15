import 'package:flutter/material.dart';
import '../pages/formulir_page.dart';
import '../pages/chat_page.dart';
import '../pages/peta_page.dart';
import '../pages/statistik_page.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    FormulirPage(),
    ChatPage(),
    PetaPage(),
    StatistikPage(),
  ];

  void _pilihTujuan(int indeks) {
    setState(() => _indeksTerpilih = indeks);
  }

  @override
  Widget build(BuildContext context) {
    final bool layarLebar = MediaQuery.of(context).size.width >= 600;

    // Setiap halaman sudah punya AppBar sendiri, jadi kerangka tidak
    // menambah AppBar lagi (menghindari judul ganda).
    return Scaffold(
      body: layarLebar ? _tataLetakLebar() : _isiHalaman(),
      bottomNavigationBar: layarLebar ? null : _buatBilahBawah(),
    );
  }

  // IndexedStack menjaga state tiap halaman (isian form, chat) saat berpindah tab.
  Widget _isiHalaman() {
    return IndexedStack(index: _indeksTerpilih, children: _halaman);
  }

  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Formulir'),
        NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat'),
        NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Peta'),
        NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik'),
      ],
    );
  }

  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.assignment_outlined),
                selectedIcon: Icon(Icons.assignment),
                label: Text('Formulir')),
            NavigationRailDestination(
                icon: Icon(Icons.chat_outlined),
                selectedIcon: Icon(Icons.chat),
                label: Text('Chat')),
            NavigationRailDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: Text('Peta')),
            NavigationRailDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: Text('Statistik')),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _isiHalaman()),
      ],
    );
  }
}
