String cetakHurufAkhir(double nilai) {
  if (nilai > 70)
    return "A"; // Jika nilai diatas 70 kembalikan nilai A
  else if (nilai > 40)
    return "B"; // Jika nilai diatas 40 kembalikan nilai B
  else if (nilai > 0) return "C"; // Jika nilai diatas 0 kembalikan nilai C
  return ""; //Langsung kembalikan string kosong jika tidak masuk kedalam percabangan manapun atau dapat dimasukkan kedalam else;
}

void main() {
  print("Nilai Huruf Akhir 100 = ${cetakHurufAkhir(100)}"); // Mencetak nilai
  print("Nilai Huruf Akhir 80 = ${cetakHurufAkhir(80)}"); // Mencetak nilai
  print("Nilai Huruf Akhir 70 = ${cetakHurufAkhir(70)}"); // Mencetak nilai
  print("Nilai Huruf Akhir 50 = ${cetakHurufAkhir(50)}"); // Mencetak nilai
  print("Nilai Huruf Akhir 40 = ${cetakHurufAkhir(40)}"); // Mencetak nilai
  print("Nilai Huruf Akhir 10 = ${cetakHurufAkhir(10)}"); // Mencetak nilai
  print("Nilai Huruf Akhir 0 = ${cetakHurufAkhir(0)}"); // Mencetak nilai
}
