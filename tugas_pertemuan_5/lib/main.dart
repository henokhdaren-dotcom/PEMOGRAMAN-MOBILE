import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCDT_t_W_4paTjD-IUjEYMEL7dZktFIohU",
      authDomain: "praktikumlima.firebaseapp.com",
      projectId: "praktikumlima",
      storageBucket: "praktikumlima.firebasestorage.app",
      messagingSenderId: "364296203214",
      appId: "1:364296203214:web:509a4e318b0f905e21999f",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pencatatan Stok Barang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StokBarangPage(),
    );
  }
}

class StokBarangPage extends StatefulWidget {
  const StokBarangPage({super.key});

  @override
  State<StokBarangPage> createState() => _StokBarangPageState();
}

class _StokBarangPageState extends State<StokBarangPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _tglMasukController = TextEditingController();
  final _tglKeluarController = TextEditingController();
  final _kodeController = TextEditingController();
  final _stokController = TextEditingController();

  bool _isLoading = false;

  // NIM 021 (Ganjil) -> Bilangan Desimal
  final bool isNimGenap = false;

  @override
  void dispose() {
    _namaController.dispose();
    _tglMasukController.dispose();
    _tglKeluarController.dispose();
    _kodeController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  Future<void> _simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      dynamic kodeBarangParsed;
      if (isNimGenap) {
        kodeBarangParsed = int.parse(_kodeController.text.trim());
      } else {
        kodeBarangParsed = double.parse(_kodeController.text.trim());
      }

      final int jumlahStokParsed = int.parse(_stokController.text.trim());

      await FirebaseFirestore.instance.collection('stok_barang').add({
        'nama_barang': _namaController.text.trim(),
        'tanggal_masuk': _tglMasukController.text.trim(),
        'tanggal_keluar': _tglKeluarController.text.trim(),
        'kode_barang': kodeBarangParsed,
        'jumlah_stok': jumlahStokParsed,
        'waktu': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data barang berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );

      _namaController.clear();
      _tglMasukController.clear();
      _tglKeluarController.clear();
      _kodeController.clear();
      _stokController.clear();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Stok Barang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama Barang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tglMasukController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Masuk Barang (DD-MM-YYYY)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal Masuk wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tglKeluarController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Keluar Barang (DD-MM-YYYY)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal Keluar wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kodeController,
                keyboardType: isNimGenap
                    ? TextInputType.number
                    : const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: isNimGenap
                      ? 'Kode Barang (Angka Bulat - NIM Genap)'
                      : 'Kode Barang (Desimal - NIM Ganjil)',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kode Barang wajib diisi';
                  }
                  if (isNimGenap) {
                    if (int.tryParse(value.trim()) == null) {
                      return 'Kode Barang harus berupa bilangan bulat';
                    }
                  } else {
                    if (double.tryParse(value.trim()) == null) {
                      return 'Kode Barang harus berupa bilangan desimal (cth: 21.0)';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Stok',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jumlah Stok wajib diisi';
                  }
                  final stok = int.tryParse(value.trim());
                  if (stok == null) {
                    return 'Jumlah Stok harus berupa angka bulat';
                  }
                  if (stok < 0) {
                    return 'Jumlah Stok tidak boleh negatif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _simpanData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Simpan Barang',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}