import 'package:flutter/material.dart';

// --- KONSTANTA WARNA ---
const Color kPrimaryColor = Color(0xFF5E0821);
const Color kCardColor = Color(0xFFFFFFFF);

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({super.key});

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
              child: const Center(
                child: Text(
                  "Belum ada favorit",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
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
          left: 8,   // dikit aja biar hampir nempel kiri
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