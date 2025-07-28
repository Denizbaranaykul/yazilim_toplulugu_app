import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Sayfası"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profil Fotoğrafı (yuvarlak)
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),

            // Ad
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "İsim",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Soyad
            TextField(
              controller: surnameController,
              decoration: InputDecoration(
                labelText: "Soyisim",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Şifre
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // Butonlar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Değişiklik işlemi
                    print("Değiştirildi: ${nameController.text}");

                    // Kullanıcıya bilgi ver
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Bilgiler başarıyla güncellendi."),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text("Değiştir"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(245, 255, 0, 0),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login_page()),
                      (route) => false,
                    );
                  },
                  child: Text("Çıkış yap"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
