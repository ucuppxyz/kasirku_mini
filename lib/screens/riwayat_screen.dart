import 'package:flutter/material.dart';
import '../models/models.dart';

class RiwayatScreen extends StatelessWidget {
  final List<Transaksi> riwayat;

  const RiwayatScreen({super.key, required this.riwayat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Transaksi')),
      body: ListView.builder(
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          final transaksi = riwayat[index];
          return ListTile(
            title: Text(transaksi.idTransaksi),
            subtitle: Text('Rp${transaksi.totalHarga.toStringAsFixed(0)}'),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text(transaksi.cetakStruk()),
              ),
            ),
          );
        },
      ),
    );
  }
}