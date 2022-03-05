import 'dart:io';

void cetakJamPasir(int n) {
  for (int i = n; i > 0; i--) {
    for (int j = 0; j < n - i; j++) {
      stdout.write(" ");
    }
    for (int j = 0; j < i; j++) {
      stdout.write("* ");
    }
    print("");
  }

  for (int i = 1; i < n; i++) {
    for (int j = 1; j < n - i; j++) {
      stdout.write(" ");
    }
    for (int j = 0; j <= i; j++) {
      stdout.write("* ");
    }
    print("");
  }
}

void main() {
  int n = int.parse(stdin.readLineSync()!);
  cetakJamPasir(n);
}
