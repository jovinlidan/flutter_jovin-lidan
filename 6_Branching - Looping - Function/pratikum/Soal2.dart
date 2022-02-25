BigInt fact(BigInt nilai) {
  BigInt ans = BigInt.from(1); // nilai awal adalah 1
  for (BigInt i = BigInt.from(2); i <= nilai; i = i + BigInt.from(1)) {
    //Melakukan perulangan
    ans *= i;
  }
  return ans; // Mengalikan nilai awal dengan setiap i dalam perulangan
}

void main() {
  print("Hasil Faktorial 10 = ${fact(BigInt.from(10))}"); // Mencetak Hasil
  print("Hasil Faktorial 20 = ${fact(BigInt.from(20))}"); // Mencetak Hasil
  print("Hasil Faktorial 30 = ${fact(BigInt.from(30))}"); // Mencetak Hasil
}
