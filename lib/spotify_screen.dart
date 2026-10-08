import 'package:flutter/material.dart';

class SpotifyScreen extends StatefulWidget {
	const SpotifyScreen({super.key, this.showBottomNavigation = true});

	final bool showBottomNavigation;

	@override
	State<SpotifyScreen> createState() => _SpotifyScreenState();
}

class _SpotifyScreenState extends State<SpotifyScreen> {
	int _tab = 0;
	int? _playing;

	final _playlists = const [
		['Liked Songs', 'assets/images/My Pictures/IMG-20250820-WA0021.jpg'],
		['Daily Mix 1', 'assets/images/My Pictures/IMG-20250820-WA0005.jpg'],
		['Discover Weekly', 'assets/images/My Pictures/IMG-20250820-WA0003.jpg'],
		['Release Radar', 'assets/images/My Pictures/IMG-20250820-WA0001.jpg'],
	];

	final _albums = const [
		['Daily Mix 1', 'Taylor Swift, Dua Lipa, and more', 'assets/images/My Pictures/IMG-20250330-WA0023.jpg'],
		['Daily Mix 2', 'The Weeknd, Drake, and more', 'assets/images/My Pictures/DSC01699.jpg'],
		['Chill Hits', 'Kick back to the best new music.', 'assets/images/My Pictures/IMG-20250820-WA0013.jpg'],
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			body: SafeArea(
				child: CustomScrollView(slivers: [
					SliverToBoxAdapter(child: _header()),
					SliverToBoxAdapter(child: _quickLinks()),
					SliverToBoxAdapter(child: _title('Made for you')),
					SliverToBoxAdapter(child: _albumList()),
					SliverToBoxAdapter(child: _title('Recently played')),
					SliverToBoxAdapter(child: _recentList()),
					const SliverToBoxAdapter(child: SizedBox(height: 24)),
				]),
			),
			bottomNavigationBar: widget.showBottomNavigation ? BottomNavigationBar(
				backgroundColor: const Color(0xff121212),
				type: BottomNavigationBarType.fixed,
				currentIndex: _tab,
				onTap: (value) => setState(() => _tab = value),
				selectedItemColor: Colors.white,
				unselectedItemColor: Colors.grey,
				items: const [
					BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
					BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
					BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Your Library'),
				],
			) : null,
		);
	}

	Widget _header() => Padding(
				padding: const EdgeInsets.fromLTRB(20, 20, 12, 12),
				child: Row(children: [
					const Expanded(child: Text('Good evening', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
					IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
					IconButton(onPressed: () {}, icon: const Icon(Icons.history, color: Colors.white)),
					IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, color: Colors.white)),
				]),
			);

	Widget _quickLinks() => Padding(
				padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
				child: Wrap(
					spacing: 8,
					runSpacing: 8,
					children: _playlists.map((item) => SizedBox(
						width: 175,
						height: 54,
						child: Material(
							color: const Color(0xff292929),
							borderRadius: BorderRadius.circular(4),
							child: InkWell(
								onTap: () {},
								child: Row(children: [
									Image.asset(item[1], width: 54, height: 54, fit: BoxFit.cover),
									const SizedBox(width: 10),
									Expanded(child: Text(item[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
								]),
							),
						),
					)).toList(),
				),
			);

	Widget _title(String text) => Padding(
				padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
				child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
			);

	Widget _albumList() => SizedBox(
				height: 245,
				child: ListView.builder(
					scrollDirection: Axis.horizontal,
					padding: const EdgeInsets.only(left: 20),
					itemCount: _albums.length,
					itemBuilder: (context, index) => Container(
						width: 165,
						margin: const EdgeInsets.only(right: 16),
						child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
											ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.asset(_albums[index][2], width: 165, height: 165, fit: BoxFit.cover)),
							const SizedBox(height: 10),
							Text(_albums[index][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
							const SizedBox(height: 5),
							Text(_albums[index][1], style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
						]),
					),
				),
			);

	Widget _recentList() => SizedBox(
				height: 180,
				child: ListView.builder(
					scrollDirection: Axis.horizontal,
					padding: const EdgeInsets.only(left: 20),
					itemCount: _playlists.length,
					itemBuilder: (context, index) => GestureDetector(
						onTap: () => setState(() => _playing = _playing == index ? null : index),
						child: Container(
							width: 130,
							margin: const EdgeInsets.only(right: 14),
							child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
								Stack(alignment: Alignment.center, children: [
									ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.asset(_playlists[index][1], width: 130, height: 130, fit: BoxFit.cover)),
									if (_playing == index) const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.pause, color: Colors.black)),
								]),
								const SizedBox(height: 9),
								Text(_playlists[index][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
							]),
						),
					),
				),
			);
}
