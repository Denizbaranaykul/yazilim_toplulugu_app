import 'package:flutter/material.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page/appbar_profile_page.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page/profile_page_buttons.dart';
import 'package:yazilim_toplulugu_app/pages/profile_page/profile_page_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar_profile_page(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profil Fotoğrafı (yuvarlak)
            profile_icon(),
            const SizedBox(height: 24),

            // Ad
            email_field(),
            const SizedBox(height: 16),

            // Şifre
            password_field(),
            const SizedBox(height: 32),

            // Butonlar
            profile_buttons(context),
          ],
        ),
      ),
    );
  }
}
