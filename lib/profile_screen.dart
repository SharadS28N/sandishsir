import 'package:flutter/material.dart';

import 'spotify_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.showBottomNavigation = true, this.onBack});

  final bool showBottomNavigation;
  final VoidCallback? onBack;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _following = false;
  int _selectedTab = 0;
  int _selectedNav = 4;
  final Set<int> _likedPosts = <int>{};
  final Set<int> _savedPosts = <int>{};
  final Set<int> _playingReels = <int>{};
  final Map<int, List<String>> _comments = <int, List<String>>{
    0: <String>['Love this!', 'Great team energy.'],
    1: <String>['Such a cute moment.'],
  };

  static const _ink = Color(0xFF111214);
  static const _softInk = Color(0xFF6B6D72);
  static const _line = Color(0xFFE5E5E7);
  static const _mediaPaths = <String>[
    'assets/images/My Pictures/IMG-20250820-WA0021.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0005.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0003.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0001.jpg',
    'assets/images/My Pictures/IMG-20250330-WA0023.jpg',
    'assets/images/My Pictures/DSC01699.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0013.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0011.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0009.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0017.jpg',
    'assets/images/My Pictures/IMG-20250820-WA0019.jpg',
    'assets/images/My Pictures/IMG_3002.JPG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _ink,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('s.bhandari__', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        leading: IconButton(tooltip: 'Back', onPressed: widget.onBack ?? () {}, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22)),
        actions: [
          IconButton(
            tooltip: 'Open Spotify',
            onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const SpotifyScreen())),
            icon: const Icon(Icons.music_note_rounded, size: 22),
          ),
          IconButton(tooltip: 'More options', onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded, size: 25)),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _profileHeader()),
          SliverToBoxAdapter(child: _highlights()),
          SliverToBoxAdapter(child: _tabBar()),
          if (_selectedTab == 0)
            SliverGrid.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2, childAspectRatio: 0.92),
              itemBuilder: (_, index) => _postTile(index),
            )
          else if (_selectedTab == 1)
            SliverFillRemaining(
              child: _reelsView(),
            )
          else
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Icon(Icons.person_pin_outlined, size: 52, color: _softInk)),
            ),
        ],
      ),
      bottomNavigationBar: widget.showBottomNavigation ? _bottomNavigationBar() : null,
    );
  }

  Widget _profileHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _avatar(size: 88),
              const SizedBox(width: 22),
              const Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_Stat(value: '6', label: 'posts'), _Stat(value: '384', label: 'followers'), _Stat(value: '391', label: 'following')])),
            ],
          ),
          const SizedBox(height: 14),
          const Text('Sharad Bhandari', style: TextStyle(color: _ink, fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 5),
          const Text('Oh Ophelia', style: TextStyle(color: _ink, fontSize: 16)),
          const SizedBox(height: 4),
          const Row(children: [Icon(Icons.link_rounded, size: 20, color: _ink), SizedBox(width: 4), Text('sharadb.com.np', style: TextStyle(color: _ink, fontWeight: FontWeight.w600, fontSize: 16))]),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 112, child: Stack(children: [_miniAvatar(0), Positioned(left: 26, child: _miniAvatar(1)), Positioned(left: 52, child: _miniAvatar(2))])),
              const Expanded(child: Text.rich(TextSpan(style: TextStyle(color: _ink, fontSize: 16, height: 1.25), children: [TextSpan(text: 'Followed by '), TextSpan(text: 'pork_momo9, uni_rijal', style: TextStyle(fontWeight: FontWeight.w700)), TextSpan(text: ' + 15\nmore')]))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _actionButton(_following ? 'Following' : 'Follow', filled: !_following, onTap: () => setState(() => _following = !_following))),
              const SizedBox(width: 5),
              Expanded(child: _actionButton('Message', filled: false)),
              const SizedBox(width: 5),
              SizedBox(width: 42, height: 40, child: OutlinedButton(onPressed: _showCollabSheet, style: OutlinedButton.styleFrom(padding: EdgeInsets.zero, side: const BorderSide(color: _line), backgroundColor: const Color(0xFFF2F2F3), foregroundColor: _ink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))), child: const Icon(Icons.person_add_alt_1_rounded, size: 19))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, {required bool filled, VoidCallback? onTap}) => SizedBox(
        height: 40,
        child: ElevatedButton(
          onPressed: onTap ?? () {},
          style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: filled ? _ink : const Color(0xFFF2F2F3), foregroundColor: filled ? Colors.white : _ink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
          child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      );

  Widget _highlights() {
    const labels = ['Brotherho...', 'Global Fie...', 'Concert &...'];
    return SizedBox(
      height: 126,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (_, index) => Column(children: [_highlightCircle(index), const SizedBox(height: 6), Text(labels[index], style: const TextStyle(color: _ink, fontSize: 14))]),
      ),
    );
  }

  Widget _tabBar() => Container(
        height: 62,
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _line))),
        child: Row(children: [_tab(Icons.grid_view_rounded, 0), _tab(Icons.smart_display_outlined, 1), _tab(Icons.person_pin_outlined, 2)]),
      );

  Widget _tab(IconData icon, int index) => Expanded(
        child: InkWell(
          onTap: () => setState(() => _selectedTab = index),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: _selectedTab == index ? _ink : _softInk, size: 29), const SizedBox(height: 9), if (_selectedTab == index) Container(height: 2, width: 80, color: _ink)]),
        ),
      );

  Widget _postTile(int index) => GestureDetector(
        onTap: () => _showPostViewer(index),
        child: Container(
          color: Colors.black,
          child: Stack(children: [
            Positioned.fill(child: Image.asset(_mediaPaths[index % _mediaPaths.length], fit: BoxFit.cover)),
            if (index == 0 || index == 2 || index == 3) const Positioned(top: 8, right: 8, child: Icon(Icons.collections_rounded, color: Colors.white, size: 18)),
          ]),
        ),
      );

  Widget _reelsView() => PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => setState(() => _playingReels.contains(index) ? _playingReels.remove(index) : _playingReels.add(index)),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.black),
            child: Stack(
              children: [
                Positioned.fill(child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(_mediaPaths[(index + 2) % _mediaPaths.length], fit: BoxFit.cover))),
                Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(color: Colors.black.withValues(alpha: .22)))),
                Center(child: Icon(_playingReels.contains(index) ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded, color: Colors.white, size: 72)),
                const Positioned(left: 18, right: 18, bottom: 22, child: Text('@s.bhandari__  •  Original audio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15))),
                Positioned(left: 18, right: 18, bottom: 12, child: LinearProgressIndicator(value: _playingReels.contains(index) ? .62 : 0, minHeight: 3, backgroundColor: Colors.white38, color: Colors.white)),
              ],
            ),
          ),
        ),
      );

  void _showPostViewer(int index) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: AspectRatio(aspectRatio: 1.25, child: Image.asset(_mediaPaths[index % _mediaPaths.length], fit: BoxFit.cover))),
            const SizedBox(height: 16),
            Text(index == 0 ? 'MEET THE TEAM' : 'Sharad Bhandari', style: const TextStyle(color: _ink, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('A small-scale Instagram post viewer. Add your original image to the matching media slot to replace this preview.', style: TextStyle(color: _softInk, height: 1.35)),
            const SizedBox(height: 18),
            Row(children: [
              IconButton(tooltip: 'Like', onPressed: () { setState(() => _likedPosts.contains(index) ? _likedPosts.remove(index) : _likedPosts.add(index)); setSheetState(() {}); }, icon: Icon(_likedPosts.contains(index) ? Icons.favorite : Icons.favorite_border, color: _likedPosts.contains(index) ? Colors.red : _ink)),
              IconButton(tooltip: 'Comment', onPressed: () => _showCommentsSheet(index), icon: const Icon(Icons.chat_bubble_outline_rounded, color: _ink)),
              const Spacer(),
              IconButton(tooltip: 'Save', onPressed: () { setState(() => _savedPosts.contains(index) ? _savedPosts.remove(index) : _savedPosts.add(index)); setSheetState(() {}); }, icon: Icon(_savedPosts.contains(index) ? Icons.bookmark : Icons.bookmark_border, color: _ink)),
            ]),
          ]),
        ),
      ),
    );
  }

  void _showCommentsSheet(int index) {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final comments = _comments.putIfAbsent(index, () => <String>[]);
          void addComment() {
            final comment = controller.text.trim();
            if (comment.isEmpty) return;
            setState(() => comments.add(comment));
            controller.clear();
            setSheetState(() {});
          }

          return Padding(
            padding: EdgeInsets.fromLTRB(20, 4, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Comments', style: TextStyle(color: _ink, fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                if (comments.isEmpty) const Padding(padding: EdgeInsets.symmetric(vertical: 18), child: Text('Be the first to comment.', style: TextStyle(color: _softInk))),
                if (comments.isNotEmpty) ...comments.map((comment) => ListTile(contentPadding: EdgeInsets.zero, leading: _miniAvatar(0), title: Text(comment, style: const TextStyle(color: _ink)), subtitle: const Text('s.bhandari__', style: TextStyle(color: _softInk)))),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: TextField(controller: controller, textInputAction: TextInputAction.send, onSubmitted: (_) => addComment(), decoration: InputDecoration(hintText: 'Add a comment...', filled: true, fillColor: const Color(0xFFF2F2F3), border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
                  IconButton(tooltip: 'Post comment', onPressed: addComment, icon: const Icon(Icons.send_rounded, color: _ink)),
                ]),
              ],
            ),
          );

        },
      ),
    ).whenComplete(controller.dispose);
  }

  void _showCollabSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          final people = ['pork_momo9', 'uni_rijal', 's.bhandari__'];
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Invite collaborator', style: TextStyle(color: _ink, fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text('Choose who can collaborate on your next post or reel.', style: TextStyle(color: _softInk)),
              const SizedBox(height: 14),
              ...people.map((person) => ListTile(leading: _miniAvatar(people.indexOf(person)), title: Text(person, style: const TextStyle(color: _ink, fontWeight: FontWeight.w600)), trailing: IconButton(tooltip: 'Add collaborator', onPressed: () { setState(() {}); setSheetState(() {}); }, icon: const Icon(Icons.add_circle_outline_rounded, color: _ink)))),
            ]),
          );
        },
      ),
    );
  }

  Widget _bottomNavigationBar() {
    const icons = [Icons.home_outlined, Icons.search, Icons.smart_display_outlined, Icons.send_outlined, Icons.account_circle_outlined];
    const labels = ['Home', 'Search', 'Reels', 'Messages', 'Profile'];
    return SafeArea(
      child: Container(
        height: 58,
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: _line))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(icons.length, (index) => IconButton(tooltip: labels[index], onPressed: () => setState(() => _selectedNav = index), icon: Icon(icons[index], color: _selectedNav == index ? _ink : _softInk, size: 29)))),
      ),
    );
  }

  Widget _avatar({double size = 48}) => Container(width: size, height: size, padding: const EdgeInsets.all(4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE4E4E5), width: 4)), child: ClipOval(child: Image.asset(_mediaPaths.first, fit: BoxFit.cover)));
  Widget _miniAvatar(int index) => Container(width: 34, height: 34, padding: const EdgeInsets.all(2), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.white, width: 2)), child: ClipOval(child: Image.asset(_mediaPaths[index % _mediaPaths.length], fit: BoxFit.cover)));
  Widget _highlightCircle(int index) => Container(width: 68, height: 68, padding: const EdgeInsets.all(4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF25262A), width: 3)), child: ClipOval(child: Image.asset(_mediaPaths[(index + 3) % _mediaPaths.length], fit: BoxFit.cover)));
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(children: [Text(value, style: const TextStyle(color: _ProfileScreenState._ink, fontWeight: FontWeight.w700, fontSize: 16)), Text(label, style: const TextStyle(color: _ProfileScreenState._ink, fontSize: 16))]);
}