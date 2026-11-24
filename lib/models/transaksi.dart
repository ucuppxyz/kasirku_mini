import 'bisa_dicetak.dart';
import 'item_transaksi.dart';
import 'produk.dart';

class Transaksi implements BisaDicetak {
  final String idTransaksi;
  final List<ItemTransaksi> _items = []; // private: hanya Transaksi yang boleh mengisi

  Transaksi(this.idTransaksi);

  // Satu-satunya cara menambah item: Transaksi sendiri yang membuat ItemTransaksi-nya.
  void tambahItem(Produk produk, int jumlah) {
    _items.add(ItemTransaksi(produk, jumlah));
  }

  List<ItemTransaksi> get items => List.unmodifiable(_items);
  double get totalHarga => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  @override
  String cetakStruk() {
    final buffer = StringBuffer()..writeln('=== STRUK: $idTransaksi ===');
    for (final item in _items) {
      buffer.writeln(
          '${item.produk.nama} x${item.jumlah} = Rp${item.subtotal.toStringAsFixed(0)}');
    }
    buffer.writeln('TOTAL: Rp${totalHarga.toStringAsFixed(0)}');
    return buffer.toString();
  }
}