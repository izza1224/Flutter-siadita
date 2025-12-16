import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen

// --- KONSTANTA
const Color kPrimaryColor = Color(0xFF5E0821); 
const Color kBlackColor = Color(0xFF000000); 
const Color kCardColor = Color(0xFFFFFFFF); 

// Konstruktor tidak menggunakan const karena ini StatefulWidget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); 

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  TextEditingController emailController = TextEditingController();
  bool isOtpSent = false;
  TextEditingController otpController = TextEditingController();
  
  String simulatedOtp = ''; 

  // --- FUNGSI CUSTOM TRANSITION ---
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

  void _sendOtp() {
    if (emailController.text.isNotEmpty) {
      final otp = '123456'; 
      
      setState(() {
        isOtpSent = true;
        simulatedOtp = otp; 
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kode OTP Anda: $simulatedOtp'),
          duration: const Duration(seconds: 10), 
          backgroundColor: kPrimaryColor,
        ),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan alamat email yang valid.')),
      );
    }
  }

  void _login() {
    if (!isOtpSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kirim OTP terlebih dahulu.')),
      );
      return;
    }
    
    if (otpController.text == simulatedOtp && otpController.text.isNotEmpty) {
      // Navigasi ke HomeScreen jika OTP benar
      Navigator.pushReplacement(
        context,
        _createRoute(HomeScreen()), // Menggunakan Custom Transition
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode OTP salah atau belum diisi.')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCardColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.15), 
            
            _buildLogoAndTitle(),
            
            const SizedBox(height: 50),
            
            _buildEmailSection(),
            
            const SizedBox(height: 20), 

            _buildOtpSection(),
            
            const SizedBox(height: 50),
            
            _buildLoginButton(),

            const SizedBox(height: 30),
            
            _buildFooterText(),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildLogoAndTitle() {
    return Column(
      children: [
        // --- Memanggil Logo ---
        Image.asset(
          'assets/images/logo_cakdurasim.png', 
          height: 150, 
        ),
        // ------------------------------------
        
        const SizedBox(height: 30),
        const Text(
          'Login Sekarang!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kBlackColor, 
            fontSize: 24, 
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Masuk untuk melakukan pemesanan tiket',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey, 
            fontSize: 14,
          ),
        ),
      ],
    );
  }


  Widget _buildEmailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none, 
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  enabled: !isOtpSent, 
                ),
              ),
              // Tombol Kirim OTP
              TextButton(
                onPressed: isOtpSent ? null : _sendOtp, 
                child: Text(
                  'Kirim OTP',
                  style: TextStyle(
                    color: isOtpSent ? Colors.grey : kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: kPrimaryColor, 
              width: 2
            ),
          ),
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center, 
            maxLength: 6, 
            decoration: const InputDecoration(
              hintText: 'Masukkan OTP',
              counterText: "", 
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            enabled: isOtpSent, 
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        'LOGIN',
        style: TextStyle(
          color: kCardColor, 
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Belum punya akun?',
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                // Aksi ke halaman register
              },
              child: const Text(
                'DAFTAR',
                style: TextStyle(
                  color: kPrimaryColor, 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        const Text(
          'UPT Taman Budaya Jatim',
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        const Text(
          'Ver 0.1 Beta',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}