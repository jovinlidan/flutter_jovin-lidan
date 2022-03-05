import 'dart:io';

int azimuth(int angka) {
  int masukkan = angka;

  if (angka >= 180)
    masukkan -= 180;
  else if (angka < 180) masukkan += 180;

  if (masukkan <= 0)
    return 0;
  else if (masukkan >= 360)
    return 0;
  else
    return masukkan;
}

void main() {
  int angka = int.parse(stdin.readLineSync()!);
  print(azimuth(angka));
}
