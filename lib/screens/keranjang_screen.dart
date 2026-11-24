import 'package:flutter/material.dart';
import '../models/models.dart';

class KeranjangScreen extends StatefulWidget {
  final Keranjang keranjang;
  final void Function(Transaksi) onCheckoutBerhasil;

  const KeranjangScreen({
    super.key,
    required this.keranjang,
    required this.onCheckoutBerhasil,
  });

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  final Kasir kasir = Kasir('Kasir 1'); // asosiasi dari Pertemuan 4, dipakai di sini

  void _checkout() {
    try {
      final transaksi = kasir.layani(widget.keranjang);
      widget.onCheckoutBerhasil(transaksi);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Checkout berhasil: ${transaksi.idTransaksi}'),
        ),
      );
    } on StokTidakCukupException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.pesan)),
      );
    } on KeranjangKosongException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.pesan)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: ListView(
        children: widget.keranjang.isi
            .map((p) => ListTile(
          title: Text(p.nama),
          subtitle: Text('Qty: ${widget.keranjang.jumlahPerProduk[p.kode]}'),
        ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _checkout,
        label: const Text('Checkout'),
      ),
    );
  }
}