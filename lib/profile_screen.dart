import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorit_screen.dart';
import 'login_screen.dart'; // ⬅️ tambahkan ini

const Color kPrimaryColor = Color(0xFF7A0C2E);
const Color kCardColor = Colors.white;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('current_user');

    setState(() {
      userEmail = user ?? "Tidak diketahui";
    });
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('current_user'); // ⬅️ hapus user login

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false, // ⬅️ hapus semua stack
    );
  }

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

            // 🔥 EMAIL DINAMIS
            Text(
              userEmail,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),

            const SizedBox(height: 25),

            _buildMenuCard([
              _menuItem(context, Icons.person, "Edit Profile"),
              _divider(),
              _menuItem(context, Icons.confirmation_number, "Favorit"),
              _divider(),
              _menuItem(context, Icons.chat_bubble_outline, "Kritik dan Saran"),
            ]),

            const SizedBox(height: 15),

            _buildMenuCard([
              _menuItem(context, Icons.headset_mic, "Pusat Bantuan"),
            ]),

            const SizedBox(height: 15),

            _buildMenuCard([
              _menuItem(context, Icons.logout, "Logout", isLogout: true),
            ]),
          ],
        ),
      ),
    );
  }

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

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : kPrimaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isLogout ? Colors.red : Colors.black,
      ),
      onTap: () {
        if (title == "Favorit") {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FavoritScreen()),
          );
        } else if (isLogout) {
          logout(context); // 🔥 LOGOUT DIPANGGIL
        }
      },
    );
  }

  Widget _divider() {
    return const Divider(height: 1, thickness: 0.5);
  }
}
