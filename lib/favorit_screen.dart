import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'agenda_data.dart';

// --- KONSTANTA WARNA ---
const Color kPrimaryColor = Color(0xFF5E0821);
const Color kCardColor = Color(0xFFFFFFFF);

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  List<String> favoritIds = [];

  @override
  void initState() {
    super.initState();
    loadFavorit();
  }

  Future<void> loadFavorit() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('current_user');

    if (user != null) {
      List<String> data = prefs.getStringList('favorite_$user') ?? [];
      print("USER LOAD: $user");
      print("KEY LOAD: favorite_$user");
      print("DATA DIAMBIL: $data");

      setState(() {
        favoritIds = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          // HEADER
          _buildHeader(context),

          // BODY
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: favoritIds.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada favorit",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoritIds.length,
                      itemBuilder: (context, index) {
                        final favId = favoritIds[index];

                        final agenda = allAgendas.firstWhere(
                          (item) => item.id == favId,
                        );

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4),
                            ],
                          ),
                          child: Row(
                            children: [
                              // 🔹 GAMBAR
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  agenda.imagePath,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // 🔹 TEXT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      agenda.category,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      agenda.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 8, // dikit aja biar hampir nempel kiri
          right: 16,
          bottom: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BACK BUTTON (SUDAH FIX KE KIRI)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 8),

            // TITLE
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Menu favorit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
