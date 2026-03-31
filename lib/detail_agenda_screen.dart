import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- KONSTANTA WARNA (Disamakan dengan Proyek SiAdita) ---
const Color kPrimaryColor = Color(0xFF5E0821); // Maroon
const Color kCardColor = Color(0xFFFFFFFF); // Putih
const Color kGreyColor = Color(0xFFBDBDBD);

class DetailAgendaScreen extends StatelessWidget {
  final String agendaId;

  const DetailAgendaScreen({super.key, required this.agendaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor, // Background maroon sesuai gambar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // 1. POSTER (Sudut melengkung)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/agenda_kepaten.png',
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),

            // 2. JUDUL
            const Text(
              'Ludruk',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const Text(
              '“Kepaten Obor”',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // 3. METADATA (Tanggal, Durasi, Penyelenggara)
            const Text(
              '2023-05-20  •  120m  •  Disbudpar Jawa Timur',
              style: TextStyle(color: kGreyColor, fontSize: 14),
            ),
            const SizedBox(height: 30),

            // 4. DESKRIPSI / SINOPSIS
            const Text(
              'Pertiwi berjalan dengan membawa lentera (dari bangku penonton) menyusuri jalan mencari sejarahnya yang semakin hilang. Terdengar sayup-sayup suara tembang kesedihan yang menggambarkan sebuah bangsa yang melupakan sejarahnya. Pertiwi terus berjalan sambil bercerita (MONOLOG) tentang sebuah generasi yang semakin hari semakin tercerabut dari akarnya. Ditengah perjalanannya pertiwi menemukan sisa-sia sejarah yaitu patung Dr. Sutomo dan patung Cak Durasim. Kepada kedua patung tersebut pertiwi (MONOLOG) berkeluh kesah tentang generasi muda hari ini dan menanyakan bagaimana nasibnya kedepan. Setelah puas berkeluh kesah pertiwi (OUT) pergi meninggalkan kedua patung tersebut.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 40),

            // 5. TOMBOL TAMBAH FAVORIT
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();

                  String? user = prefs.getString('current_user');
                  if (user == null) return;

                  String key = 'favorite_$user';
                  List<String> favList = prefs.getStringList(key) ?? [];

                  if (!favList.contains(agendaId)) {
                    favList.add(agendaId);
                    await prefs.setStringList(key, favList);
                  }

                  print("USER SIMPAN: $user");
                  print("KEY SIMPAN: favorite_$user");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ditambahkan ke Favorit')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFD9D9D9,
                  ), // Warna abu terang sesuai SS
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Tambah Favorit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
