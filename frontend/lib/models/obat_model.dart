class Obat {
  final String idobat; // Primary Key
  final String nama; // Nama obat
  final int stok; // Stok obat
  final double harga; // Harga obat

  Obat({
    required this.idobat,
    required this.nama,
    required this.stok,
    required this.harga,
  });

  // Memetakan JSON dari API Laravel ke Objek Dart
  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      idobat: json['idobat'].toString(),
      nama: json['nama'] ?? '',
      stok: int.parse(json['stok'].toString()),
      harga: double.parse(json['harga'].toString()),
    );
  }
}
