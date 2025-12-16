import 'package:flutter/material.dart';

// --- KONSTANTA WARNA ---
const Color kPrimaryColor = Color(0xFF5E0821); 
// Warna Merah Gelap dengan opasitas 70% (0xB3)
const Color kPrimaryColor70 = Color(0xB35E0821); 

const Color kCardColor = Color(0xFFFFFFFF);    
const Color kLightPrimaryColor = Color(0xFFFBE4E4); 
const Color kBlackColor = Color(0xFF000000); 

// --- STRUKTUR DATA SENIMAN ---
class Artist {
  final String name;
  final String imagePath;
  final String category;

  Artist({required this.name, required this.imagePath, required this.category});
}

// --- DATA DUMMY SENIMAN ---
final List<Artist> allArtists = [
  // Kategori: Pemeran
  Artist(name: 'Masduki', imagePath: 'assets/images/artist_masduki.png', category: 'Pemeran'),
  Artist(name: 'Nyai Ranti', imagePath: 'assets/images/artist_ranti.png', category: 'Pemeran'),
  Artist(name: 'Cak Anto', imagePath: 'assets/images/artist_anto.png', category: 'Pemeran'),
  Artist(name: 'Nyai Ronsih', imagePath: 'assets/images/artist_ronsih.png', category: 'Pemeran'),

  // Kategori: Pelukis
  Artist(name: 'Djunaedi', imagePath: 'assets/images/artist_djunaedi.png', category: 'Pelukis'),
  Artist(name: 'Toha Mashudi', imagePath: 'assets/images/artist_toha.png', category: 'Pelukis'),
  Artist(name: 'Yusuf Susilo', imagePath: 'assets/images/artist_yusuf.png', category: 'Pelukis'),
  Artist(name: 'Rosid', imagePath: 'assets/images/artist_rosid.png', category: 'Pelukis'),
  
  // Kategori: Perupa
  Artist(name: 'Mujiadi', imagePath: 'assets/images/artist_mujiadi.png', category: 'Perupa'),
  Artist(name: 'Achmad Feri', imagePath: 'assets/images/artist_feri.png', category: 'Perupa'),
  Artist(name: 'Sutaryono', imagePath: 'assets/images/artist_sutaryono.png', category: 'Perupa'),
  Artist(name: 'Dolorasa Sinaga', imagePath: 'assets/images/artist_dolorasa.png', category: 'Perupa'),
];

// --- KELAS UTAMA (STATEFUL) ---
class SenimanScreen extends StatefulWidget {
  const SenimanScreen({super.key});

  @override
  State<SenimanScreen> createState() => _SenimanScreenState();
}

class _SenimanScreenState extends State<SenimanScreen> {
  
  String? selectedCategory = 'Semua Kategori';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  final List<String> categories = ['Semua Kategori', 'Pemeran', 'Pelukis', 'Perupa'];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_updateSearchQuery);
  }

  @override
  void dispose() {
    _searchController.removeListener(_updateSearchQuery);
    _searchController.dispose();
    super.dispose();
  }
  
  void _updateSearchQuery() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<Artist> _getFilteredArtists() {
    List<Artist> filteredList;
    
    // 1. Filter Kategori
    if (selectedCategory == 'Semua Kategori') {
      filteredList = allArtists;
    } else {
      filteredList = allArtists
          .where((artist) => artist.category == selectedCategory)
          .toList();
    }
    
    // 2. Filter Pencarian
    if (_searchQuery.isEmpty) {
      return filteredList;
    } else {
      return filteredList.where((artist) {
        return artist.name.toLowerCase().contains(_searchQuery);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCardColor, 
      body: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 1. HEADER (Memanggil widget _buildHeader)
            _buildHeader(context),
            
            // 2. KOTAK PUTIH KONTEN UTAMA (Dimulai tepat di bawah Header)
            Container(
              decoration: const BoxDecoration(
                color: kCardColor, 
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: [
                    _buildFilterAndSearch(),
                    const SizedBox(height: 20),
                    _buildArtistGrid(),
                  ],
                ),
              ),
            ),
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HEADER (Revisi Transparansi Warna) ---
  Widget _buildHeader(BuildContext context) {
    // Tinggi yang dibutuhkan Header
    final double headerHeight = 250; 
    
    return Stack(
      children: [
        // 1. Latar Belakang Merah Gelap (Gambar/Warna)
        Container(
          height: headerHeight, 
          decoration: BoxDecoration(
            color: kPrimaryColor, // Warna dasar Merah Gelap
            image: DecorationImage(
              image: const AssetImage('assets/images/background_seniman.png'), 
              fit: BoxFit.cover,
              // --- PERUBAHAN: Menggunakan kPrimaryColor70 untuk ColorFilter ---
              colorFilter: ColorFilter.mode(
                kPrimaryColor70, // Warna dengan opasitas 70%
                BlendMode.overlay,
              ),
              // -----------------------------------------------------------------
            ),
          ),
        ),
        
        // 2. Lapis Bawah: Judul, Subjudul, dan Lengkungan Putih
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding Kiri untuk Judul dan Subjudul
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    const Text(
                      'Seniman',
                      style: TextStyle(
                        color: kCardColor,
                        fontSize: 34, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Subjudul
                    const Text(
                      'Seniman-seniman Yang Pernah Berperan \ndalam pagelaran di Cak Durasim',
                      style: TextStyle(
                        color: kCardColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Lengkungan Putih (Di Bawah Judul/Subjudul)
              Container(
                height: 30, // Tinggi lengkungan
                decoration: const BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // 3. Lapis Atas: Tombol Kembali (Di SafeArea untuk menghindari notch)
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

  // --- WIDGET FILTER DAN PENCARIAN ---
  Widget _buildFilterAndSearch() {
    return Row(
      children: [
        // Dropdown Kategori
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedCategory,
                icon: const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                
                items: categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: kPrimaryColor)),
                  );
                }).toList(),
                
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 10),
        
        // Kolom Pencarian
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: kPrimaryColor),
                prefixIcon: Icon(Icons.search, color: kPrimaryColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- WIDGET GRID SENIMAN (DIFILTER) ---
  Widget _buildArtistGrid() {
    final filteredArtists = _getFilteredArtists();
    
    if (filteredArtists.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Text(
          'Tidak ada seniman yang cocok dengan kriteria saat ini.',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredArtists.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        childAspectRatio: 0.8, 
      ),
      itemBuilder: (context, index) {
        final artist = filteredArtists[index];
        return _buildArtistCard(artist);
      },
    );
  }

  // --- WIDGET CARD SENIMAN INDIVIDUAL ---
  Widget _buildArtistCard(Artist artist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${artist.name} (${artist.category}) diklik')),
                );
              },
              child: Image.asset(
                artist.imagePath, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.person_pin_circle, color: Colors.grey, size: 50),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          artist.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: kBlackColor,
          ),
        ),
      ],
    );
  }
  
  // --- WIDGET FOOTER ---
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'UPT Taman Budaya Jatim',
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          Text(
            'Ver 0.1 Beta',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}