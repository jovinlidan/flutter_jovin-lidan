double fact(double nilai) {
  double ans = 1; // nilai awal adalah 1
  for (double i = 2; i <= nilai; i++) {
    //Melakukan perulangan
    ans *= i; // Mengalikan nilai awal dengan setiap i dalam perulangan
  }
  return ans; // Mengembalikan nilai akhir
}

void main() {
  print("Hasil Faktorial 10 = ${fact(10)}"); // Mencetak Hasil
  print("Hasil Faktorial 20 = ${fact(20)}"); // Mencetak Hasil
  print("Hasil Faktorial 30 = ${fact(30)}"); // Mencetak Hasil
}
