import 'package:flutter/material.dart';
import 'models/models.dart';
import 'screens/katalog_screen.dart';
import 'screens/keranjang_screen.dart';
import 'screens/riwayat_screen.dart';
import 'services/katalog_service.dart';

void main() => runApp(const KasirKuMiniApp());

class KasirKuMiniApp extends StatelessWidget {
  const KasirKuMiniApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
    home: BerandaKasir(),
  );
}

class BerandaKasir extends StatefulWidget {
  const BerandaKasir({super.key});

  @override
  State<BerandaKasir> createState() => _BerandaKasirState();
}

class _BerandaKasirState extends State<BerandaKasir> {
  final KatalogService _katalogService = KatalogService();
  final Keranjang _keranjang = Keranjang();
  final List<Transaksi> _riwayat = [];
  int _tabTerpilih = 0;

  @override
  void initState() {
    super.initState();
    // Data contoh sementara — akan diganti "muat dari database" di Pertemuan 15
    _katalogService.tambahProduk(
        ProdukMakanan.restok('MKN001', 'Nasi Goreng', 15000, 20));
    _katalogService.tambahProduk(
        ProdukMinuman.restok('MNM001', 'Es Teh Manis', 5000, 30));
  }

  @override
  Widget build(BuildContext context) {
    final layar = [
      KatalogScreen(
        katalogService: _katalogService,
        keranjang: _keranjang,
        onKeranjangBerubah: () => setState(() {}),
      ),
      KeranjangScreen(
        keranjang: _keranjang,
        onCheckoutBerhasil: (t) => setState(() => _riwayat.add(t)),
      ),
      RiwayatScreen(riwayat: _riwayat),
    ];

    return Scaffold(
      body: IndexedStack(index: _tabTerpilih, children: layar),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabTerpilih,
        onDestinationSelected: (i) => setState(() => _tabTerpilih = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}