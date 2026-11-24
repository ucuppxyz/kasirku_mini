import 'exceptions.dart';

abstract class Produk {
  final String kode;
  String nama;
  String kategori;
  double _harga; // private: tidak bisa diakses produk._harga = -5000 dari luar
  int _stok;
  bool tersedia;
  String? catatan; // tidak semua produk punya catatan
  DateTime? waktuRestockTerakhir; // null sampai produk pernah direstok

  Produk(this.kode, this.nama, this.kategori, this._harga, this._stok)
      : tersedia = _stok > 0;

  Produk.baru(String kode, String nama, String kategori, double harga)
      : this(kode, nama, kategori, harga, 0);

  Produk.restok(
      String kode, String nama, String kategori, double harga, int stokAwal)
      : this(kode, nama, kategori, harga, stokAwal);

  // Getter: cara BACA harga dari luar class.
  double get harga => _harga;

  // Setter: cara UBAH harga dari luar class, sekaligus tempat validasi.
  set harga(double nilai) {
    if (nilai < 0) throw ArgumentError('Harga tidak boleh negatif');
    _harga = nilai;
  }

  int get stok => _stok;

  // Positional biasa: parameter wajib, urutan penting.
  String tampilkanInfo(String prefix) =>
      '$prefix$nama Rp${harga.toStringAsFixed(0)}';

  // Optional positional: catatan boleh diisi, boleh tidak (diapit []).
  void tambahStok(int jumlah, [String? catatan]) {
    _stok += jumlah;
    tersedia = _stok > 0;
    waktuRestockTerakhir = DateTime.now();
    if (catatan != null) this.catatan = catatan;
  }

  void kurangiStok(int jumlah) {
    if (jumlah > stok) {
      throw StokTidakCukupException(
        'Stok $nama tidak cukup (tersedia: $stok, diminta: $jumlah)',
      );
    }
    _stok -= jumlah;
    tersedia = _stok > 0;
  }

  // Named wajib: persen HARUS diisi lewat nama parameternya, alasan opsional.
  void aturDiskon({required double persen, String? alasan}) {
    final potongan = harga * persen / 100;
    harga -= potongan;
    print('Diskon $persen% diterapkan${alasan != null ? ' ($alasan)' : ''}');
  }

  // Optional named dengan default value: includeDiskon boleh diabaikan.
  String cetakStruk({bool includeDiskon = false}) {
    final buffer = StringBuffer()
      ..writeln('$nama ($kategori)')
      ..writeln('Harga: Rp${harga.toStringAsFixed(0)}')
      ..writeln('Stok tersisa: $stok');
    return buffer.toString();
  }

  // Tidak ada isi/body: setiap subclass WAJIB menyediakan implementasinya sendiri.
  double hitungPajak();
}