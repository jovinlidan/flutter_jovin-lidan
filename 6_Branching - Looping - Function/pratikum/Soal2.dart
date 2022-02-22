double fact(double nilai) {
  if (nilai == 0 || nilai == 1) return 1;
  return nilai * fact(nilai - 1);
}

void main() {
  print(fact(10));
  print(fact(20));
  print(fact(30));
}
