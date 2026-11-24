import 'package:flutter/material.dart';
import '../models/models.dart';

class ProdukCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback onTap;

  const ProdukCard({super.key, required this.produk, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap, // event handling: diteruskan ke pemanggil, bukan di-print di sini
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                produk.nama,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(produk.kategori),
              const Spacer(),
              Text('Rp${produk.harga.toStringAsFixed(0)}'),
              Text('Stok: ${produk.stok}'),
            ],
          ),
        ),
      ),
    );
  }
}