class Hewan {
  late int berat; // Membuat variabel berat

  Hewan(int berat) {
    // membuat constructor untuk menginisialisasikan nilai berat saat membuat instance dari class
    this.berat = berat; // Masukkan nilai berat dari parameter ke property dalam kelas
  }
}

class Mobil {
  late final int kapasitas; // Membuat variabel kapasitas
  List<Hewan> muatan = []; // Membuat list dari hewan

  Mobil({required int totalKapasitas}) {
    // membuat constructor untuk menginisialisasikan nilai totalKapasitas saat membuat instance dari class
    this.kapasitas = totalKapasitas;
  }

  int totalMuatan() {
    //Fungsi untuk mencari total muatan dari list hewan
    int temp = 0; // Variabel penampung berat sementara
    for (Hewan item in muatan) {
      // Looping seluruh hewan dalam muatan
      temp += item.berat; // tambahkan berat ke variabel temp
    }
    return temp; // kembalikan nilai temp
  }

  void tambahMuatan(Hewan hewan) {
    // Fungsi tambah muatan dengan parameter Hewan
    if (totalMuatan() + hewan.berat <= kapasitas) {
      // Jika total muatan yang ada dilist ditambah berat hewan di parameter masi lebih kecil dari totalkapasitas mobil, maka masukkan hewan kedalam muatan
      muatan.add(hewan);
    }
  }
}

void main() {
  // Soal 1
  Hewan kucing = Hewan(20); // Membuat objek dari Hewan dengan berat 20

  print("Berat Kucing = ${kucing.berat}\n"); // Cetak berat hewan

  // Soal 2
  Hewan kambing = Hewan(20); // Membuat objek dari hewan
  Hewan kerbau = Hewan(10); // Membuat objek dari hewan
  Hewan gajah = Hewan(30); // Membuat objek dari hewan
  Mobil lambo = Mobil(totalKapasitas: 50); // Membuat objek dari mobil dengan total kapasitas 50

  lambo.tambahMuatan(kambing); // Tambah muatan lambo dengan kambing(20)
  lambo.tambahMuatan(gajah); // Tambah muatan lambo dengan gajah(30)
  lambo.tambahMuatan(kerbau); // Tambah muatan lambo dengan kerbau(10)

  print("Total Muatan Mobil Lambo = ${lambo.totalMuatan()}"); // Cetak total muatan lambo
}
