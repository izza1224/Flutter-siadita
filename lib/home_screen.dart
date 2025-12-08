import 'package:flutter/material.dart';

// --- Konstanta Warna ---
// Definisikan warna marun yang mirip dengan desain Anda
const Color kPrimaryColor = Color(0xFF8B0000); 

// --- Data Dummy ---
// Data untuk menu ikon
final List<Map<String, dynamic>> menuItems = [
  {'icon': Icons.group, 'label': 'Profile'},
  {'icon': Icons.airplane_ticket_outlined, 'label': 'Tiket'},
  {'icon': Icons.web, 'label': 'Web'},
  {'icon': Icons.account_balance, 'label': 'Info Sewa'},
  {'icon': Icons.calendar_today, 'label': 'Jadwal'},
  {'icon': Icons.person_pin_circle_outlined, 'label': 'Seniman'},
  {'icon': Icons.calendar_month, 'label': 'Agenda'},
];

// Data untuk berita terbaru
final List<Map<String, String>> newsItems = [
  {'title': 'Dokumentasi Karya Budaya Jaran Slining Lumajang'},
  {'title': 'Dokumentasi Karya Budaya Jaran Lamongan'},
  {'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Ramayanti'},
  {'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Kang Bagong'},
];


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(context),
            _buildIconMenu(),
            _buildVideoSection(),
            _buildNewsHeader(),
            _buildNewsSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET 1: HEADER (Selamat Datang SiAdita) ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      // Padding menyesuaikan dengan Status Bar
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10, 
        left: 20, 
        right: 10, 
        bottom: 20
      ),
      decoration: const BoxDecoration(
        color: kPrimaryColor, 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: kPrimaryColor),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selamat datang', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  Text('SiAdita', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // --- WIDGET 2: MENU IKON (GRID) ---
  Widget _buildIconMenu() {
    return GridView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(), 
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemCount: menuItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, 
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8, 
      ),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFBE4E4), 
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(item['icon'], size: 30, color: kPrimaryColor),
            ),
            const SizedBox(height: 5),
            Text(item['label'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        );
      },
    );
  }

  // --- WIDGET 3: CUPLIKAN VIDEO ---
  Widget _buildVideoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.movie, color: kPrimaryColor),
              SizedBox(width: 5),
              Text("Cuplikan Video", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Area Gambar Video dengan Tombol Play
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Placeholder Gambar (Harus diganti dengan Image.asset)
                      Container(color: Colors.black), 
                      const Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
                      // Text dummy di atas gambar video
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          color: Colors.black54,
                          child: const Text('Live Streaming Youtube Cak Durasim', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
                // Deskripsi Video
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "BALEN", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                          ),
                          Text("Live Youtube Cak Durasim", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                      const Text("26 September 2025", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET 4: BERITA TERBARU (HEADER) ---
  Widget _buildNewsHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          Icon(Icons.article, color: kPrimaryColor),
          SizedBox(width: 5),
          Text("Berita Terbaru", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPrimaryColor, // Latar belakang merah marun
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                // Placeholder Gambar Berita
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // Placeholder untuk gambar (ganti dengan Image.asset jika ada aset)
                  ),
                  child: const Center(child: Icon(Icons.image, color: Colors.grey)),
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
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Teks waktu (15 hari yang lalu)
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("15 Hari yang lalu", style: TextStyle(color: Color(0xFFFBE4E4), fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}