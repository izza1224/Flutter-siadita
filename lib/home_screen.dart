import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart'; 
import 'package:reorderable_grid_view/reorderable_grid_view.dart'; 

// --- TAMBAHAN BARU: Import SenimanScreen untuk Navigasi ---
import 'seniman_screen.dart'; 

// --- KONSTANTA WARNA ---
// Merah Gelap: #5E0821
const Color kPrimaryColor = Color(0xFF5E0821); 
// Putih: #FFFFFF
const Color kCardColor = Color(0xFFFFFFFF);    
// Merah Muda Pucat 
const Color kLightPrimaryColor = Color(0xFFFBE4E4); 
const Color kBlackColor = Color(0xFF000000); 

// --- DATA DUMMY VIDEO ---
final List<Map<String, String>> videoItems = [
  {'title': 'BALEN', 'subtitle': 'Live Youtube Cak Durasim', 'date': '26 September 2025', 'desc': 'Live Streaming Youtube Cak Durasim', 'image': 'assets/images/image_balen.png'}, 
  {'title': 'Dageline "Mata Keranjang"', 'subtitle': 'Gedung Cak Durasim', 'date': '22 Oktober 2025', 'desc': 'Live Streaming Youtube', 'image': 'assets/images/image_matakeranjang.png'}, 
  {'title': 'ASHOLAH JHARAN', 'subtitle': 'Dageline "Mata Keranjang"', 'date': '22 Oktober 2025', 'desc': 'Pagelaran Budaya', 'image': 'assets/images/image_asholah.png'}, 
];

// --- DATA DUMMY BERITA (DITAMBAH IMAGE) ---
final List<Map<String, String>> newsItems = [
  // Berita Lumajang DENGAN GAMBAR (image_lumajang.png)
  {'title': 'Dokumentasi Karya Budaya Jaran Slining Lumajang', 'time': '15 Hari yang lalu', 'image': 'assets/images/image_lumajang.png'},
  // Berita lainnya (gunakan placeholder jika belum ada gambar)
  {'title': 'Dokumentasi Karya Budaya Jaran Lamongan', 'time': '15 Hari yang lalu', 'image': 'assets/images/image_lamongan.png'},
  {'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Ramayanti', 'time': '15 Hari yang lalu', 'image': 'assets/images/image_ludruk.png'}, 
  {'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Kang Bagong', 'time': '15 Hari yang lalu', 'image': 'assets/images/image_kang.png'},
];


// --- KELAS UTAMA (STATEFUL UNTUK REORDER) ---
class HomeScreen extends StatefulWidget {
  // Konstruktor NON-CONST
  HomeScreen({super.key}); 

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // --- TAMBAHAN: FUNGSI CUSTOM TRANSITION ---
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide dari kanan ke kiri
        const begin = Offset(1.0, 0.0); 
        const end = Offset.zero; 
        const curve = Curves.ease; 
        
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400), 
    );
  }
  // ------------------------------------------------

  // Data MENU IKON
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
      // Atur background Scaffold sebagai default Merah Gelap (jika ada area kosong)
      backgroundColor: kPrimaryColor, 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // 1. HEADER (Bagian Merah Gelap)
              _buildHeader(context), 
              
              // 2. KOTAK PUTIH (Konten Utama)
              Container(
                decoration: BoxDecoration(
                  color: kCardColor, // Putih
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                // Padding atas 50.0 untuk menggeser Baris 1 Ikon ke bawah
                padding: const EdgeInsets.only(top: 50.0), 
                child: Column(
                  children: [
                    _buildReorderableIconMenu(), // Menu Ikon (reorderable)
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

  // --- WIDGET 1: HEADER (TATA LETAK AKURAT) ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      // --- WARNA DI SINI DIPERLUKAN UNTUK JIKA TIDAK TER-SCROLL ---
      color: kPrimaryColor, 
      // --------------------------------
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 30, 
        left: 20, 
        right: 20, 
        bottom: 50 
      ),
      child: Row( // Semua dalam satu Row utama untuk penyelarasan sejajar
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: <Widget>[
          
          // KIRI: Logo Akun dan "Selamat datang"
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
                child: const Text('Selamat datang', style: TextStyle(color: kCardColor, fontSize: 16)), 
              ),
            ],
          ),
          
          const Spacer(),
          
          // KANAN: SiAdita dan Lonceng
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('SiAdita', style: TextStyle(color: kCardColor, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(width: 12), 
              Icon(Icons.notifications, color: kCardColor, size: 28), 
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET 2: MENU IKON (REORDERABLE & DAPAT DIKLIK) ---
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
          mainAxisSpacing: 10, // Jarak vertikal yang rapat
          crossAxisSpacing: 5, 
          childAspectRatio: 0.7, 
        ),
        
        itemBuilder: (context, index) {
          final item = menuItems[index];
          
          // --- InkWell untuk interaksi klik ---
          return InkWell(
            key: ValueKey(item['label']), // Key unik untuk reorder
            onTap: () {
              // LOGIKA NAVIGASI DENGAN ANIMASI
              if (item['label'] == 'Seniman') {
                Navigator.of(context).push(_createRoute(const SenimanScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menu ${item['label']} diklik')),
                );
              }
            },
            // --- Konten Kolom Ikon ---
            child: Column(
              children: <Widget>[
                // Container Ikon 
                Container(
                  height: 55, 
                  width: 55, 
                  decoration: BoxDecoration(
                    color: kPrimaryColor, // Merah Gelap
                    borderRadius: BorderRadius.circular(15), 
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(item['icon'], size: 30, color: kCardColor), // Putih
                ),
                const SizedBox(height: 5),
                Text(item['label'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: kBlackColor)),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // --- WIDGET 3: CUPLIKAN VIDEO SLIDER ---
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
              Text("Cuplikan Video", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kBlackColor)),
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

  // WIDGET CARD UNTUK SLIDER (MEMUAT GAMBAR DARI ASSET)
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
                  
                  // --- Memuat Gambar dari Aset ---
                  Image.asset(
                    item['image']!, 
                    fit: BoxFit.cover, 
                    width: double.infinity, 
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: kBlackColor, child: const Center(child: Icon(Icons.error, color: kCardColor)));
                    },
                  ),
                  
                  // Ikon Play Overlay
                  const Icon(Icons.play_circle_fill, color: Colors.white70, size: 50), 
                  
                  // Teks Live Streaming (Desc) di overlay (diposisikan di kiri bawah)
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
                            style: const TextStyle(color: kCardColor, fontSize: 12),
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
            // Deskripsi Teks di Bawah Gambar (Subtitle dan Tanggal Sejajar)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title']!, 
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kBlackColor)),
                    const SizedBox(height: 2),

                    // Subtitle ("Live Youtube Cak Durasim") dan Tanggal Sejajar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['subtitle']!, // "Live Youtube Cak Durasim" (Teks kiri)
                          style: const TextStyle(fontSize: 12, color: Colors.grey)
                        ),
                        Text(
                          item['date']!, // "26 September 2025" (Teks kanan, sejajar)
                          style: const TextStyle(fontSize: 12, color: Colors.grey)
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

  // --- WIDGET 4: BERITA TERBARU (HEADER) ---
  Widget _buildNewsHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      child: Row(
        children: [
          Icon(Icons.article, color: Colors.black54, size: 20),
          SizedBox(width: 5),
          Text("Berita Terbaru", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: kBlackColor)),
        ],
      ),
    );
  }

  // --- WIDGET 5: BERITA TERBARU (LIST) ---
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
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPrimaryColor, // Merah Gelap
              borderRadius: BorderRadius.circular(15), 
              boxShadow: const [ 
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                // Gambar Berita dari Aset
                Container(
                  width: 65,
                  height: 65,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    item['image']!, // Memuat gambar berita dari aset
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: kCardColor, child: const Center(child: Icon(Icons.image, color: Colors.grey)));
                    },
                  ),
                ),
                const SizedBox(width: 15),
                // Teks Berita
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: kCardColor, // Putih
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Teks waktu
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item['time']!, 
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: kLightPrimaryColor, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}