import 'package:flutter/material.dart';
import 'favorit_screen.dart'; // Import halaman favorit

const Color kPrimaryColor = Color(0xFF7A0C2E); 
const Color kCardColor = Colors.white;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    "Akun",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // AVATAR
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.grey),
            ),

            const SizedBox(height: 10),

            const Text(
              "Polines@gmail.com",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),

            const SizedBox(height: 25),

            // CARD MENU 1
            _buildMenuCard([
              _menuItem(context, Icons.person, "Edit Profile"), // Tambahkan context
              _divider(),
              _menuItem(context, Icons.confirmation_number, "Favorit"), // Tambahkan context
              _divider(),
              _menuItem(context, Icons.chat_bubble_outline, "Kritik dan Saran"), // Tambahkan context
            ]),

            const SizedBox(height: 15),

            // CARD MENU 2
            _buildMenuCard([
              _menuItem(context, Icons.headset_mic, "Pusat Bantuan"), // Tambahkan context
            ]),

            const SizedBox(height: 15),

            // LOGOUT
            _buildMenuCard([
              _menuItem(context, Icons.logout, "Logout", isLogout: true), // Tambahkan context
            ]),
          ],
        ),
      ),
    );
  }

  // CARD CONTAINER
  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: children),
    );
  }

  // MENU ITEM (Kata 'static' dihapus agar bisa menggunakan context)
  Widget _menuItem(BuildContext context, IconData icon, String title,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon,
          color: isLogout ? Colors.red : kPrimaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios,
          size: 16,
          color: isLogout ? Colors.red : Colors.black),
      onTap: () {
        // PERBAIKAN: Hanya pindah halaman jika judulnya adalah "Favorit"
        if (title == "Favorit") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FavoritScreen())
          );
        } else if (isLogout) {
           // Tambahkan logika logout jika perlu
        }
      },
    );
  }

  // DIVIDER
  Widget _divider() {
    return const Divider(height: 1, thickness: 0.5);
  }
}