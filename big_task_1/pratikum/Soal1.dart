import 'dart:io';

bool cekGenap(int arg) => (arg % 2 == 0) ? true : false;

void main() {
  int angka = int.parse(stdin.readLineSync()!);

  print(cekGenap(angka));
}
