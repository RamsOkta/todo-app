class Food {
  final int? id;
  final String nama;
  final int waktuPembuatan;
  final String deskripsi;
  final String jenis;
  final String images;
  final String resep;

  Food({
    this.id,
    required this.nama,
    required this.waktuPembuatan,
    required this.deskripsi,
    required this.jenis,
    required this.images,
    required this.resep,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      waktuPembuatan: json['waktuPembuatan'],
      jenis: json['jenis'],
      images: json['images'],
      resep: json['resep'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'jenis': jenis,
      'waktuPembuatan': waktuPembuatan,
      'images': images,
      'resep': resep,
    };
  }
}
