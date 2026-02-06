class Obat {
  final String idobat;
  final String nama;
  final int stok;
  final double harga;

  Obat({
    required this.idobat,
    required this.nama,
    required this.stok,
    required this.harga,
  });
  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      idobat: json['idobat']?.toString() ?? '',
      nama: json['nama'] ?? 'Tanpa Nama',
      stok: int.tryParse(json['stok']?.toString() ?? '0') ?? 0,
      harga: double.tryParse(json['harga']?.toString() ?? '0.0') ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'idobat': idobat,
      'nama': nama,
      'stok': stok,
      'harga': harga,
    };
  }
  Obat copyWith({
    String? idobat,
    String? nama,
    int? stok,
    double? harga,
  }) {
    return Obat(
      idobat: idobat ?? this.idobat,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
      harga: harga ?? this.harga,
    );
  }
  bool containsSearch(String query) {
    return nama.toLowerCase().contains(query.toLowerCase()) || 
           idobat.toLowerCase().contains(query.toLowerCase());
  }
  bool get isLowStock => stok < 5;
}