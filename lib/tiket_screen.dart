import 'package:flutter/material.dart';
import 'home_screen.dart';

// --- KONSTANTA WARNA (Sesuai Agenda) ---
const Color kPrimaryColor = Color(0xFF5E0821);
const Color kPrimaryColor70 = Color(0xB35E0821); 
const Color kCardColor = Color(0xFFFFFFFF);
const Color kBlackColor = Color(0xFF000000);

// Menggunakan Model yang sama agar konsisten
class Tiket {
  final String category;
  final String title;
  final String imagePath;

  Tiket({
    required this.category,
    required this.title,
    required this.imagePath,
  });
}

class TiketScreen extends StatefulWidget {
  const TiketScreen({super.key});

  @override
  State<TiketScreen> createState() => _TiketScreenState();
}

class _TiketScreenState extends State<TiketScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // --- DATA DUMMY ---
  final List<Tiket> allTickets = [
    Tiket(category: 'Ludruk', title: '“Sucining Katresnan”', imagePath: 'assets/images/agenda_sucining.png'),
    Tiket(category: 'Ludruk', title: '“Kepaten Obor”', imagePath: 'assets/images/agenda_kepaten.png'),
    Tiket(category: 'Ludruk', title: '“Nada Klinting”', imagePath: 'assets/images/agenda_nada.png'),
    Tiket(category: 'Ludruk', title: '“Sarap Tambak Oso”', imagePath: 'assets/images/agenda_sarap.png'),
    Tiket(category: 'Ludruk', title: '“Nglaras Ikhlas Noto Lelaku”', imagePath: 'assets/images/agenda_nglaras.png'),
    Tiket(category: 'Ludruk', title: '“Lemah Abang”', imagePath: 'assets/images/agenda_lemah.png'),
  ];

  List<Tiket> _getFilteredTickets() {
    return allTickets.where((tiket) {
      return tiket.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             tiket.category.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCardColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchField(),
                        const SizedBox(height: 25),
                        const Text('Akan Datang', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kBlackColor)),
                        const SizedBox(height: 15),
                        _buildTicketGrid(), // Memanggil grid tiket
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNav(context),
        ],
      ),
    );
  }

  // --- WIDGET HEADER (Sudah disesuaikan dengan permintaanmu) ---
  Widget _buildHeader(BuildContext context) {
  return Stack(
    children: [
      // Wadah utama Header
      Container(
        height: 250,
        decoration: const BoxDecoration(
          color: kPrimaryColor, // Warna dasar jika gambar gagal dimuat
          image: DecorationImage(
            // PASTIKAN: Path gambar ini benar dan sudah ada di pubspec.yaml
            image: AssetImage('assets/images/background_tiket.png'), 
            fit: BoxFit.cover,
            // Properti ini penting agar gambar terlihat agak gelap/transparan
            // sesuai desain Agenda di image_47a9ea.png
            colorFilter: ColorFilter.mode(
              kPrimaryColor70, 
              BlendMode.overlay
            ),
          ),
        ),
      ),
      
      Positioned(
        bottom: 0, left: 0, right: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tiket Pagelaran', 
                    style: TextStyle(
                      color: kCardColor, 
                      fontSize: 32, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Pemesanan tiket untuk pagelaran yang\nakan datang',
                    style: TextStyle(
                      color: kCardColor, 
                      fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            
            // Lengkungan putih di bagian bawah header
            Container(
              height: 30,
              decoration: const BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), 
                  topRight: Radius.circular(30)
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Tombol Back
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: kCardColor, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    ],
  );
}

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: const InputDecoration(
          hintText: 'Search...',
          suffixIcon: Icon(Icons.search, color: kPrimaryColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  // --- WIDGET GRID (Perbaikan Error Undefined Method) ---
  Widget _buildTicketGrid() {
    final filteredData = _getFilteredTickets();
    if (filteredData.isEmpty) {
      return const Center(child: Text("Tiket tidak ditemukan"));
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final item = filteredData[index];
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(item.imagePath, fit: BoxFit.cover, 
                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[200])),
              ),
            ),
            const SizedBox(height: 8),
            Text(item.title, textAlign: TextAlign.center, 
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: kCardColor,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home, size: 35, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()), 
                (route) => false
              );
            },
          ),
          const Icon(Icons.confirmation_number, size: 35, color: kPrimaryColor),
        ],
      ),
    );
  }
}