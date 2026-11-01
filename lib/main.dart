import 'package:flutter/material.dart';

void main() {
  runApp(const KasirApp());
}

class KasirApp extends StatelessWidget {
  const KasirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasir App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ======================================================
// HALAMAN LOGIN
// ======================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. Controller untuk membaca isi TextField
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();

  @override
  void dispose() {
    // Wajib: bebaskan memori controller saat halaman ditutup
    _namaController.dispose();
    _kodeController.dispose();
    super.dispose();
  }

  void _masuk() {
    final nama = _namaController.text.trim();
    final kode = _kodeController.text.trim();

    // Validasi sederhana: kedua field harus terisi
    if (nama.isEmpty || kode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama Kasir dan Kode Kasir wajib diisi')),
      );
      return;
    }

    // 2 & 3. Navigasi ke halaman utama + kirim data lewat constructor
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(namaKasir: nama, kodeKasir: kode),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Kasir')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.point_of_sale, size: 72, color: Colors.blue),
            const SizedBox(height: 8),
            const Text(
              'Toko Kopi Serba Ada',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Kasir',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kodeController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kode Kasir',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _masuk,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Masuk'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// HALAMAN UTAMA KASIR
// ======================================================
class HomePage extends StatelessWidget {
  final String namaKasir;
  final String kodeKasir;

  const HomePage({
    super.key,
    required this.namaKasir,
    required this.kodeKasir,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Struk'),
        automaticallyImplyLeading: false, // sembunyikan tombol back otomatis
        actions: [
          // 4. Tombol Logout -> Navigator.pop()
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ucapan selamat datang (data dari halaman login)
            Text(
              'Selamat datang, $namaKasir!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Kode Kasir: ${'*' * kodeKasir.length}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Container Header Informasi Toko
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toko Kopi Serba Ada',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Jl. Sudirman No. 12, Jakarta',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Item belanja
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Roti Bakar (x3)'),
                Text('Rp 54.000'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Es Kopi Susu (x1)'),
                Text('Rp 18.000'),
              ],
            ),
            const SizedBox(height: 12),

            const Divider(),

            // Total bayar
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Bayar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp 72.000',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}