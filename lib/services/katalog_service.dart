import 'package:flutter/foundation.dart';
import '../models/models.dart';

class KatalogService extends ChangeNotifier {
  final List<Produk> _katalog = [];
  final Set<String> _kategoriUnik = {};

  List<Produk> get katalog => List.unmodifiable(_katalog);
  Set<String> get kategoriUnik => Set.unmodifiable(_kategoriUnik);

  void tambahProduk(Produk produk) {
    _katalog.add(produk);
    _kategoriUnik.add(produk.kategori);
    notifyListeners();
  }

  List<Produk> filterByKategori(String? kategori) {
    if (kategori == null || kategori == 'Semua') return katalog;
    return _katalog.where((p) => p.kategori == kategori).toList();
  }
}