import 'package:flutter/material.dart';
import '../models/models.dart';

class DetailProdukScreen extends StatelessWidget {
  final Keranjang keranjang;
  final VoidCallback onKeranjangBerubah;
  final Produk produk;

  const DetailProdukScreen({
    super.key,
    required this.keranjang,
    required this.onKeranjangBerubah,
    required this.produk,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(produk.nama)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Harga: Rp${produk.harga.toStringAsFixed(0)}'),
            Text('Stok: ${produk.stok}'),
            Text('Pajak per item: Rp${produk.hitungPajak()}'), // polimorfik dari Pertemuan 7
            const SizedBox(height: 16),
            FilledButton(
              onPressed: produk.stok == 0
                  ? null
                  : () {
                keranjang.tambah(produk); // event handling -> method model, bukan print()
                onKeranjangBerubah();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${produk.nama} ditambahkan ke keranjang'),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}