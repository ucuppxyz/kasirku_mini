import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/katalog_service.dart';
import '../widgets/produk_card.dart';
import 'detail_produk_screen.dart';

class KatalogScreen extends StatefulWidget {
  final KatalogService katalogService;
  final Keranjang keranjang;
  final VoidCallback onKeranjangBerubah;

  const KatalogScreen({
    super.key,
    required this.katalogService,
    required this.keranjang,
    required this.onKeranjangBerubah,
  });

  @override
  State<KatalogScreen> createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  @override
  void initState() {
    super.initState();
    widget.katalogService.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final produkList = widget.katalogService.katalog;
    return Scaffold(
      appBar: AppBar(title: const Text('KasirKu Mini')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: produkList.length,
        itemBuilder: (context, index) {
          final produk = produkList[index];
          return ProdukCard(
            produk: produk,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetailProdukScreen(
                  keranjang: widget.keranjang,
                  onKeranjangBerubah: widget.onKeranjangBerubah,
                  produk: produk,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}