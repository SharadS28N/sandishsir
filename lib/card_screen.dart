import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  bool _showCards = false;
  static const _mint = Color(0xFF19D3A2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F7),
      body: SafeArea(child: _showCards ? _cardsView() : _homeView()),
    );
  }

  Widget _homeView() => Column(children: [
        _header('Card', 'Simple and easy to use app.'),
        Expanded(child: GridView.count(crossAxisCount: 2, padding: const EdgeInsets.all(16), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.18, children: [
          _menuTile(Icons.menu_book_rounded, 'Text', '18 items'), _menuTile(Icons.home_work_rounded, 'Address', '5 items'), _menuTile(Icons.person_rounded, 'Character', '9 items'), _menuTile(Icons.credit_card_rounded, 'Bank card', '4 items'), _menuTile(Icons.key_rounded, 'Password', '12 items'), _menuTile(Icons.local_shipping_rounded, 'Logistics', '7 items'),
          _menuTile(Icons.settings_rounded, 'Settings', 'Preferences', wide: true),
        ])),
      ]);

  Widget _cardsView() => Column(children: [
        _header('Card', 'Your saved cards.', back: true),
        Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(16, 4, 16, 24), children: [_infoCard('Dribbble', 'Paid account', const Color(0xFFF6B53F)), _infoCard('HJM', '173****8838', const Color(0xFF348BEF)), _infoCard('Tom', 'Room 601, Building 8', const Color(0xFF4DBA98)), _infoCard('1882 **** **** 8695', 'ICBC', const Color(0xFF6455E9)), _infoCard('Young', 'This is the story of me and them.', const Color(0xFFC78F7B))])),
        FloatingActionButton(onPressed: () {}, backgroundColor: _mint, foregroundColor: Colors.white, tooltip: 'Add card', child: const Icon(Icons.add)),
        const SizedBox(height: 18),
      ]);

  Widget _header(String title, String subtitle, {bool back = false}) => Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 22),
        color: _mint,
        child: Row(
          children: [
            if (back) IconButton(tooltip: 'Back', onPressed: () => setState(() => _showCards = false), icon: const Icon(Icons.arrow_back, color: Colors.white)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white)),
          ],
        ),
      );

  Widget _menuTile(IconData icon, String title, String subtitle, {bool wide = false}) => InkWell(onTap: () => setState(() => _showCards = true), borderRadius: BorderRadius.circular(10), child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 3))]), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 38, color: const Color(0xFF4B5563)), const SizedBox(height: 10), Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11))])));

  Widget _infoCard(String title, String subtitle, Color color) => Container(height: 108, margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 13))]));
}
