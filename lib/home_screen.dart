import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

// --- TAMBAHAN BARU: Import SenimanScreen untuk Navigasi ---
import 'seniman_screen.dart';
import 'sewa_gedung.dart';
import 'agenda_screen.dart';
import 'profile_screen.dart'; // Import halaman profil

// --- KONSTANTA WARNA ---
const Color kPrimaryColor = Color(0xFF5E0821);
const Color kCardColor = Color(0xFFFFFFFF);
const Color kLightPrimaryColor = Color(0xFFFBE4E4);
const Color kBlackColor = Color(0xFF000000);

// --- DATA DUMMY VIDEO ---
final List<Map<String, String>> videoItems = [
  {
    'title': 'BALEN',
    'subtitle': 'Live Youtube Cak Durasim',
    'date': '26 September 2025',
    'desc': 'Live Streaming Youtube Cak Durasim',
    'image': 'assets/images/image_balen.png',
  },
  {
    'title': 'Dageline "Mata Keranjang"',
    'subtitle': 'Gedung Cak Durasim',
    'date': '22 Oktober 2025',
    'desc': 'Live Streaming Youtube',
    'image': 'assets/images/image_matakeranjang.png',
  },
  {
    'title': 'ASHOLAH JHARAN',
    'subtitle': 'Dageline "Mata Keranjang"',
    'date': '22 Oktober 2025',
    'desc': 'Pagelaran Budaya',
    'image': 'assets/images/image_asholah.png',
  },
];

final List<Map<String, String>> newsItems = [
  {
    'title': 'Dokumentasi Karya Budaya Jaran Slining Lumajang',
    'time': '15 Hari yang lalu',
    'image': 'assets/images/image_lumajang.png',
    'imageDetail': 'assets/images/image_lumajang_hd.png',
  },
  {
    'title': 'Dokumentasi Karya Budaya Jaran Lamongan',
    'time': '15 Hari yang lalu',
    'image': 'assets/images/image_lamongan.png',
    'imageDetail': 'assets/images/image_lamongan_hd.jpg',
  },
  {
    'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Ramayanti',
    'time': '15 Hari yang lalu',
    'image': 'assets/images/image_ludruk.png',
    'imageDetail': 'assets/images/image_ludruk_hd.jpg',
  },
  {
    'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Kang Bagong',
    'time': '15 Hari yang lalu',
    'image': 'assets/images/image_kang.png',
    'imageDetail': 'assets/images/image_kang_hd.jpg',
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.group, 'label': 'Profile'},
    {'icon': Icons.airplane_ticket_outlined, 'label': 'Tiket'},
    {'icon': Icons.web, 'label': 'Web'},
    {'icon': Icons.account_balance, 'label': 'Info Sewa'},
    {'icon': Icons.calendar_today, 'label': 'Jadwal'},
    {'icon': Icons.person_pin_circle_outlined, 'label': 'Seniman'},
    {'icon': Icons.calendar_month, 'label': 'Agenda'},
  ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = menuItems.removeAt(oldIndex);
      menuItems.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeader(context),
              Container(
                decoration: BoxDecoration(
                  color: kCardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    _buildReorderableIconMenu(),
                    _buildVideoSlider(),
                    _buildNewsHeader(),
                    _buildNewsSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 30,
        left: 20,
        right: 20,
        bottom: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: kCardColor,
                  child: Icon(Icons.person, color: kPrimaryColor, size: 24),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: const Text(
                  'Selamat datang',
                  style: TextStyle(color: kCardColor, fontSize: 16),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'SiAdita',
                style: TextStyle(
                  color: kCardColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.notifications, color: kCardColor, size: 28),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReorderableIconMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ReorderableGridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        itemCount: menuItems.length,
        onReorder: _onReorder,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return InkWell(
            key: ValueKey(item['label']),
            onTap: () {
              switch (item['label']) {
                case 'Seniman':
                  Navigator.of(context).push(_createRoute(const SenimanScreen()));
                  break;
                case 'Info Sewa':
                  Navigator.of(context).push(_createRoute(InfoSewaPage()));
                  break;
                case 'Agenda':
                  Navigator.of(context).push(_createRoute(const AgendaScreen()));
                  break;
                // --- TAMBAHAN BARU: Navigasi Tiket ---
                case 'Tiket':
                  Navigator.of(context).push(_createRoute(const TiketScreen()));
                  break;
                case 'Profile':
                  Navigator.of(context).push(_createRoute(const ProfileScreen()));
                  break;
                // ------------------------------------
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Menu ${item['label']} belum tersedia'),
                    ),
                  );
              }
            },
            child: Column(
              children: <Widget>[
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    item['icon'],
                    size: 30,
                    color: kCardColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: kBlackColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoSlider() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.movie, color: Colors.black54, size: 20),
              SizedBox(width: 5),
              Text(
                "Cuplikan Video",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: Swiper(
              itemCount: videoItems.length,
              layout: SwiperLayout.DEFAULT,
              itemBuilder: (context, index) {
                final item = videoItems[index];
                return _buildVideoCard(item);
              },
              autoplay: true,
              autoplayDelay: 4000,
              viewportFraction: 0.9,
              scale: 0.95,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: kBlackColor,
                        child: const Center(
                          child: Icon(Icons.error, color: kCardColor),
                        ),
                      );
                    },
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white70,
                    size: 50,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            item['desc']!,
                            style: const TextStyle(
                              color: kCardColor,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['subtitle']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          item['date']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsHeader() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 10.0,
      ),
      child: Row(
        children: [
          Icon(Icons.article, color: Colors.black54, size: 20),
          SizedBox(width: 5),
          Text(
            "Berita Terbaru",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newsItems.length,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemBuilder: (context, index) {
        final item = newsItems[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(_createRoute(DetailBeritaPage(data: item)));
              },
              borderRadius: BorderRadius.circular(15),
              child: Ink(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        item['image']!,
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: const TextStyle(
                          color: kCardColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      item['time']!,
                      style: const TextStyle(
                        color: kLightPrimaryColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// --- HALAMAN DETAIL BERITA ---
class DetailBeritaPage extends StatelessWidget {
  final Map<String, String> data;
  const DetailBeritaPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                data['imageDetail'] ?? data['image']!,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: kLightPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "BUDAYA",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    data['title']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['time']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const Divider(height: 40),
                  Text(
                    "Ini adalah detail isi berita mengenai ${data['title']}. "
                    "Pagelaran ini merupakan bentuk upaya pelestarian kebudayaan Jawa Timur yang diselenggarakan di Gedung Cak Durasim.\n\n"
                    "Diharapkan dengan adanya publikasi ini, masyarakat luas dapat lebih mengenal kekayaan tradisi lokal dan turut serta dalam menjaga keberlangsungannya bagi generasi mendatang.",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// --- HALAMAN TIKET PAGELARAN (DIBUAT BERDASARKAN AGENDA) ---
// =========================================================================

class TiketScreen extends StatefulWidget {
  const TiketScreen({super.key});

  @override
  State<TiketScreen> createState() => _TiketScreenState();
}

class _TiketScreenState extends State<TiketScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Data Agenda yang Anda berikan
  final List<Map<String, String>> tiketData = [
    {'category': 'Ludruk', 'title': '“Sucining Katresnan”', 'image': 'assets/images/agenda_sucining.png'},
    {'category': 'Ludruk', 'title': '“Kepaten Obor”', 'image': 'assets/images/agenda_kepaten.png'},
    {'category': 'Ludruk', 'title': '“Nada Klinting”', 'image': 'assets/images/agenda_nada.png'},
    {'category': 'Ludruk', 'title': '“Sarap Tambak Oso”', 'image': 'assets/images/agenda_sarap.png'},
    {'category': 'Ludruk', 'title': '“Nglaras Ikhlas Noto Lelaku”', 'image': 'assets/images/agenda_nglaras.png'},
    {'category': 'Ludruk', 'title': '“Lemah Abang”', 'image': 'assets/images/agenda_lemah.png'},
  ];

  List<Map<String, String>> _getFilteredTiket() {
    return tiketData.where((item) {
      return item['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             item['category']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          // Header Maroon
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Tiket Pagelaran', 
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      Text('Pemesanan tiket untuk pagelaran yang\nakan datang', 
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  )
                ],
              ),
            ),
          ),
          // Body Putih
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  // Kotak Pencarian
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) => setState(() => _searchQuery = val),
                        decoration: const InputDecoration(
                          hintText: 'Search..',
                          suffixIcon: Icon(Icons.search, color: kPrimaryColor),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Akan Datang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  // Grid Tiket
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: _getFilteredTiket().length,
                      itemBuilder: (context, index) {
                        final item = _getFilteredTiket()[index];
                        return Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(item['image']!, fit: BoxFit.cover,
                                  errorBuilder: (c,e,s) => Container(color: Colors.grey[200])),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(item['title']!, textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Tombol Bawah
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 35, color: Colors.grey),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (c) => const HomeScreen()), (r) => false),
            ),
            const Icon(Icons.confirmation_number, size: 35, color: kPrimaryColor),
          ],
        ),
      ),
    );
  }
}