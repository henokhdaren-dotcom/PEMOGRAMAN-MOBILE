import 'package:flutter/material.dart';
import 'profile_card.dart'; // Pastikan file profile_card.dart ada di folder 'lib'

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Identitas mahasiswa
  final String nimMahasiswa = '20240801111';
  final String namaMahasiswa = 'Daren Henokh Tololiu';
  final String hobiMahasiswa = 'Musik & Game';

  @override
  Widget build(BuildContext context) {
    // Digit terakhir NIM: 1 (ganjil)
    final int digitTerakhir = int.parse(
      nimMahasiswa.substring(nimMahasiswa.length - 1),
    );

    final bool isGanjil = digitTerakhir % 2 != 0;

    // Dua digit terakhir NIM: 11
    // Skor aktivitas = 11 + 50 = 61
    final int duaDigitTerakhir = int.parse(
      nimMahasiswa.substring(nimMahasiswa.length - 2),
    );

    final int skorDinamis = duaDigitTerakhir + 50;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Layout Flutter',
      theme: ThemeData(
        scaffoldBackgroundColor: isGanjil
            ? Colors.tealAccent[100]
            : Colors.amber[100],
      ),
      home: HomePage(
        nama: namaMahasiswa,
        nim: nimMahasiswa,
        hobi: hobiMahasiswa,
        skorAktivitas: skorDinamis,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const HomePage({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProfileCard(
          nama: nama,
          nim: nim,
          hobi: hobi,
          skorAktivitas: skorAktivitas,
        ),
      ),
    );
  }
}