String cetakHurufAkhir(double nilai) {
  if (nilai > 70)
    return "A";
  else if (nilai > 40)
    return "B";
  else if (nilai > 0) return "C";
  return "";
}

void main() {
  print(cetakHurufAkhir(100));
  print(cetakHurufAkhir(80));
  print(cetakHurufAkhir(70));
  print(cetakHurufAkhir(50));
  print(cetakHurufAkhir(40));
  print(cetakHurufAkhir(10));
  print(cetakHurufAkhir(0));
}
