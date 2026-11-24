import 'exceptions.dart';
import 'produk.dart';
import 'transaksi.dart';

class Keranjang {
  final List<Produk> isi = [];
  final Map<String, int> jumlahPerProduk = {};

  void tambah(Produk produk, {int jumlah = 1}) {
    if (!jumlahPerProduk.containsKey(produk.kode)) {
      isi.add(produk);
      jumlahPerProduk[produk.kode] = jumlah;
    } else {
      jumlahPerProduk[produk.kode] = jumlahPerProduk[produk.kode]! + jumlah;
    }
  }

  void kosongkan() {
    isi.clear(); // Produk TIDAK ikut terhapus dari katalog, hanya referensinya di sini yang dilepas
    jumlahPerProduk.clear();
  }

  Transaksi checkout() {
    if (isi.isEmpty) {
      throw KeranjangKosongException(
          'Keranjang masih kosong, tidak bisa checkout');
    }
    for (final produk in isi) {
      final jumlah = jumlahPerProduk[produk.kode] ?? 0;
      if (jumlah > produk.stok) {
        throw StokTidakCukupException('Stok ${produk.nama} tidak cukup');
      }
    }

    final transaksi =
    Transaksi('TRX${DateTime.now().millisecondsSinceEpoch}');
    for (final produk in isi) {
      final jumlah = jumlahPerProduk[produk.kode] ?? 0;
      produk.kurangiStok(jumlah);
      transaksi.tambahItem(produk, jumlah);
    }
    kosongkan();
    return transaksi;
  }
}