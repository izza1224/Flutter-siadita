import 'package:flutter/material.dart';

// --- Konstanta Warna ---
// Warna marun yang sesuai dengan desain
const Color kPrimaryColor = Color(0xFF8B0000); 
// Warna latar belakang ikon menu yang lebih terang
const Color kLightPrimaryColor = Color(0xFFFBE4E4); 

// --- Data Dummy ---
final List<Map<String, dynamic>> menuItems = [
  {'icon': Icons.group, 'label': 'Profile'},
  {'icon': Icons.airplane_ticket_outlined, 'label': 'Tiket'},
  {'icon': Icons.web, 'label': 'Web'},
  {'icon': Icons.account_balance, 'label': 'Info Sewa'},
  {'icon': Icons.calendar_today, 'label': 'Jadwal'},
  {'icon': Icons.person_pin_circle_outlined, 'label': 'Seniman'},
  {'icon': Icons.calendar_month, 'label': 'Agenda'},
];

final List<Map<String, String>> newsItems = [
  {'title': 'Dokumentasi Karya Budaya Jaran Slining Lumajang', 'time': '15 Hari yang lalu'},
  {'title': 'Dokumentasi Karya Budaya Jaran Lamongan', 'time': '15 Hari yang lalu'},
  {'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Ramayanti', 'time': '11 Hari yang lalu'}, // Penyesuaian waktu
  {'title': 'Dokumentasi Karya Budaya Pagelaran Ludruk Kang Bagong', 'time': '15 Hari yang lalu'},
];


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold tidak perlu Appbar karena Header sudah mencakup status bar
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang utama putih
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
      // Padding vertikal 40+10 di atas dan 20 di bawah (Total 70)
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10, 
        left: 20, 
        right: 20, 
        bottom: 20
      ),
      decoration: const BoxDecoration(
        color: kPrimaryColor, 
        // Radius lengkungan sangat besar
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Kiri: Ikon Profil & Teks
          Row(
            children: <Widget>[
              const CircleAvatar(
                radius: 18, // Ukuran ikon profil
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: kPrimaryColor, size: 24),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selamat datang', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  Text('SiAdita', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          
          // Kanan: Ikon Notifikasi
          const Icon(Icons.notifications, color: Colors.white, size: 28),
        ],
      ),
    );
  }

  // --- WIDGET 2: MENU IKON (GRID) ---
  Widget _buildIconMenu() {
    return Padding(
      // Padding luar sesuai dengan desain
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: GridView.builder(
        shrinkWrap: true, 
        physics: const NeverScrollableScrollPhysics(), 
        padding: const EdgeInsets.symmetric(horizontal: 40.0), // Padding horizontal lebih besar untuk menengahkan 4 kolom
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          mainAxisSpacing: 25, // Jarak vertikal antar item lebih besar
          crossAxisSpacing: 0, // Tidak ada jarak horizontal (sudah diatur oleh padding luar)
          childAspectRatio: 0.7, // Rasio lebar/tinggi item
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Column(
            children: <Widget>[
              // Container Ikon
              Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor, // Latar belakang ikon warna marun gelap
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(item['icon'], size: 30, color: Colors.white), // Ikon putih
              ),
              const SizedBox(height: 5),
              // Label Teks
              Text(item['label'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
            ],
          );
        },
      ),
    );
  }

  // --- WIDGET 3: CUPLIKAN VIDEO ---
  Widget _buildVideoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Cuplikan Video
          const Row(
            children: [
              Icon(Icons.movie, color: Colors.black54, size: 20), // Ikon hitam/abu
              SizedBox(width: 5),
              Text("Cuplikan Video", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          // Card Video
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2, // Bayangan card
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
                      // Placeholder Gambar (Perlu diganti dengan Image.asset)
                      Container(color: Colors.black), 
                      const Icon(Icons.play_circle_fill, color: Colors.white70, size: 70), // Tombol play lebih besar
                      
                      // Data teks overlay di atas video
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Text('Live Streaming Youtube Cak Durasim', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                      // Area wajah dan teks BALEN (tidak bisa 100% tanpa aset gambar asli)
                      Positioned(
                        top: 10,
                        child: Text("BALEN", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, shadows: [Shadow(blurRadius: 5.0, color: Colors.black)])),
                      )
                    ],
                  ),
                ),
                // Deskripsi Video (Di luar gambar)
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text("Live Youtube Cak Durasim", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ],
                      ),
                      Text("26 September 2025", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
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

  // --- WIDGET 4 & 5: BERITA TERBARU ---
  Widget _buildNewsHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          Icon(Icons.article, color: Colors.black54, size: 20),
          SizedBox(width: 5),
          Text("Berita Terbaru", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
          padding: const EdgeInsets.only(bottom: 15.0), // Jarak antar item
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kPrimaryColor, // Latar belakang merah marun
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [ // Tambah shadow tipis agar mirip card
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                // Placeholder Gambar Berita (dengan radius sudut)
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // Placeholder untuk gambar
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
                        style: const TextStyle(color: Color(0xFFFBE4E4), fontSize: 10),
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