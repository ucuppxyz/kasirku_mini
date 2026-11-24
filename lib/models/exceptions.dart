class StokTidakCukupException implements Exception {
  final String pesan;
  StokTidakCukupException(this.pesan);

  @override
  String toString() => 'StokTidakCukupException: $pesan';
}

class KeranjangKosongException implements Exception {
  final String pesan;
  KeranjangKosongException(this.pesan);

  @override
  String toString() => 'KeranjangKosongException: $pesan';
}