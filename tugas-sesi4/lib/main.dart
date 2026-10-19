import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widget/app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile Card',
      theme: AppTheme.lightTheme,
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9), // Rounded card: 9px
            ),
            child: Padding(
              padding: const EdgeInsets.all(17), // Padding card: 17px
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 42, // Ukuran avatar: 42px
                    child: Icon(Icons.person, size: 42),
                  ),
                  const SizedBox(height: 16),
                  const Text('M. Faurel Al Farizi'),
                  const SizedBox(height: 9), // Jarak nama dan NIM: 9px
                  const Text('20240801021'),
                  const SizedBox(height: 8),
                  const Text('Teknik Informatika'),
                  const SizedBox(height: 8),
                  const Text('Suka bermain game'),
                  const SizedBox(height: 16),
                  const AppButton(
                    label: 'Kunjungi GitHub Saya',
                    icon: Icons.code,
                    url: 'https://github.com/Faurel30',
                    height: 41, // Tinggi tombol: 41px
                    borderRadius: 5, // Rounded tombol: 5px
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}