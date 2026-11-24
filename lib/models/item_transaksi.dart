import 'produk.dart';

class ItemTransaksi {
  final Produk produk;
  final int jumlah;

  ItemTransaksi(this.produk, this.jumlah);

  double get subtotal => produk.harga * jumlah;
}