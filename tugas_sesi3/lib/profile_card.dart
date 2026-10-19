import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  });

  @override
  Widget build(BuildContext context) {
    // Ekstraksi digit NIM yang sudah diperbaiki
    int digitTerakhir = int.parse(
      nim.substring(nim.length - 1),
    );

    int digitKe2Belakang = int.parse(
      nim.substring(nim.length - 2, nim.length - 1),
    );

    // Rumus nilai wajib berdasarkan NIM
    double lebarKartu = 320.0 + (digitKe2Belakang * 5.0);
    double sudutMelengkung = 12.0 + (digitTerakhir * 1.5);
    double ukuranLogo = 60.0 + (digitTerakhir * 2.0);
    double jarakPemisah = 15.0 + digitTerakhir;

    return Container(
      width: lebarKartu,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sudutMelengkung),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu (Row)
          Row(
            children: [
              // Logo/Ikon berbingkai melengkung
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sudutMelengkung),
                  color: Colors.grey.shade100,
                ),
                child: FlutterLogo(size: ukuranLogo),
              ),
              SizedBox(width: jarakPemisah),
              // Judul & Nama
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kartu Praktikum',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(thickness: 1.5, height: 24),

          // Detail Identitas (Column)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NIM: $nim',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hobi: $hobi',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Skor Aktivitas: $skorAktivitas',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}