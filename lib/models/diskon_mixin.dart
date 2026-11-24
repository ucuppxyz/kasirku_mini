import 'produk_makanan.dart';

mixin BisaDiskon {
  double terapkanDiskon(double harga, double persenDiskon) =>
      harga - (harga * persenDiskon / 100);
}

// extends (satu induk) + with (kemampuan tambahan) digabung dalam satu class
class ProdukPromo extends ProdukMakanan with BisaDiskon {
  double persenPromo;

  ProdukPromo(super.kode, super.nama, super.kategori, super.harga, super.stok,
      {required this.persenPromo});

  double get hargaPromo => terapkanDiskon(harga, persenPromo);
}