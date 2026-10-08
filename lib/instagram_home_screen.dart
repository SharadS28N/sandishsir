import 'package:flutter/material.dart';

class InstagramHomeScreen extends StatefulWidget {
  const InstagramHomeScreen({super.key, required this.onProfile});

  final VoidCallback onProfile;

  @override
  State<InstagramHomeScreen> createState() => _InstagramHomeScreenState();
}

class _InstagramHomeScreenState extends State<InstagramHomeScreen> {
  static const _ink = Color(0xFF111214);
  static const _photos = <String>[
    'assets/images/My Pictures/IMG-20250820-WA0021.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0005.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0003.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0001.jpg',
  ];
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _ink,
        elevation: 0,
        title: const Text('Instagram', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic)),
        actions: [IconButton(tooltip: 'Create post', onPressed: () {}, icon: const Icon(Icons.add_box_outlined)), IconButton(tooltip: 'Activity', onPressed: () {}, icon: const Icon(Icons.favorite_border)), IconButton(tooltip: 'Messages', onPressed: () {}, icon: const Icon(Icons.messenger_outline_rounded)), IconButton(tooltip: 'Open profile', onPressed: widget.onProfile, icon: const Icon(Icons.account_circle_outlined))],
      ),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: _stories()),
        SliverToBoxAdapter(child: _postHeader()),
        SliverToBoxAdapter(child: AspectRatio(aspectRatio: .92, child: Image.asset(_photos[1], fit: BoxFit.cover))),
        SliverToBoxAdapter(child: _postActions()),
        SliverToBoxAdapter(child: _caption()),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
      ]),
    );
  }

  Widget _stories() => SizedBox(height: 116, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.fromLTRB(14, 8, 14, 8), itemCount: 5, itemBuilder: (_, index) => Padding(padding: const EdgeInsets.only(right: 14), child: Column(children: [Container(width: 68, height: 68, padding: const EdgeInsets.all(3), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: index == 0 ? const Color(0xFF3861F5) : const Color(0xFFDD9B38), width: 2)), child: ClipOval(child: Image.asset(_photos[index % _photos.length], fit: BoxFit.cover))), const SizedBox(height: 5), Text(index == 0 ? 'Your story' : ['oliver', 'andrew', 'oliver', 'mateo'][index - 1], style: const TextStyle(fontSize: 12))]))));

  Widget _postHeader() => ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 14), leading: ClipOval(child: Image.asset(_photos.first, width: 36, height: 36, fit: BoxFit.cover)), title: const Text('Samuel', style: TextStyle(fontWeight: FontWeight.w700)), subtitle: const Text('Original post'), trailing: IconButton(tooltip: 'Post options', onPressed: () {}, icon: const Icon(Icons.more_horiz)));

  Widget _postActions() => Padding(padding: const EdgeInsets.fromLTRB(14, 8, 14, 0), child: Row(children: [IconButton(tooltip: 'Like', onPressed: () => setState(() => _liked = !_liked), icon: Icon(_liked ? Icons.favorite : Icons.favorite_border, color: _liked ? Colors.red : _ink)), IconButton(tooltip: 'Comment', onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline)), IconButton(tooltip: 'Share', onPressed: () {}, icon: const Icon(Icons.send_outlined)), const Spacer(), IconButton(tooltip: 'Save', onPressed: () {}, icon: const Icon(Icons.bookmark_border))]));

  Widget _caption() => const Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Liked by Grace and others', style: TextStyle(fontWeight: FontWeight.w700)), SizedBox(height: 7), Text('elise good times. great vibes.', style: TextStyle(fontSize: 15))]));
}
