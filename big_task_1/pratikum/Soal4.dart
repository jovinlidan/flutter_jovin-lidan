import 'dart:io';

void cetakDiagonalAngka(int n) {
  for (int i = 1; i <= n; i++) {
    for (int j = 1; j < i; j++) {
      stdout.write(" ");
    }
    print(i);
  }
}

void main() {
  int n = int.parse(stdin.readLineSync()!);

  cetakDiagonalAngka(n);
}
