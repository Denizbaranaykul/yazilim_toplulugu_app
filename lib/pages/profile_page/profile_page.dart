import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page/appbar_profile_page.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page/profile_page_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      surnameController.text = data['surname'] ?? '';
      emailController.text = data['email'] ?? '';
    }
  }

  Future<void> updateUserInfo() async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      'name': nameController.text.trim(),
      'surname': surnameController.text.trim(),
      'email': emailController.text.trim(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 48, 176, 1),
        content: Text('Profil başarıyla güncellendi'),
      ),
    );
  }

  Future<void> changePassword() async {
    final user = _auth.currentUser!;
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();

    try {
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Şifre başarıyla değiştirildi'),
          backgroundColor: Color.fromARGB(255, 0, 120, 0),
        ),
      );

      oldPasswordController.clear();
      newPasswordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_profile_page(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              profile_icon(),
              const SizedBox(height: 24),

              profile_field("isim", nameController),
              const SizedBox(height: 24),

              profile_field("soy isim", surnameController),
              const SizedBox(height: 24),

              profile_field("e-mail", emailController, read: true),
              const SizedBox(height: 24),

              profile_field(
                "eski şifre",
                oldPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 16),

              profile_field(
                "yeni şifre",
                newPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(child: update_button()),
                  const SizedBox(width: 16),
                  Expanded(child: change_password_button()),
                ],
              ),
              const SizedBox(height: 20),
              sign_out_button(context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton update_button() {
    return ElevatedButton(
      onPressed: updateUserInfo,
      child: const Text("Bilgileri Güncelle"),
    );
  }

  ElevatedButton change_password_button() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(226, 243, 182, 0),
      ),
      onPressed: changePassword,
      child: const Text("Şifreyi Değiştir"),
    );
  }
}

ElevatedButton sign_out_button(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(245, 255, 0, 0),
    ),
    onPressed: () async {
      await FirebaseAuth.instance.signOut();
    },
    child: const Text("Çıkış yap"),
  );
}
