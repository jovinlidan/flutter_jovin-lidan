class Matematika {
  int hasil() {
    return 0;
  }
}

class KelipatanPersekutuanTerkecil implements Matematika {
  late int x;
  late int y;

  KelipatanPersekutuanTerkecil(int x, int y) {
    this.x = x;
    this.y = y;
  }
  @override
  int hasil() {
    int temp = x;
    if (x < y) temp = y;
    while (true) {
      if (temp % x == 0 && temp % y == 0) {
        return temp;
      }
      temp++;
    }
  }
}

class KelipatanPersekutuanTerbesar implements Matematika {
  late int x;
  late int y;

  KelipatanPersekutuanTerbesar(int x, int y) {
    this.x = x;
    this.y = y;
  }
  @override
  int hasil() {
    int tx = x, ty = y, temp;
    while (ty != 0) {
      temp = tx;
      tx = ty;
      ty = temp % ty;
    }
    return tx;
  }
}

void main() {
  Matematika kpk = KelipatanPersekutuanTerkecil(3, 4);
  Matematika fpb = KelipatanPersekutuanTerbesar(30, 30);

  print("Kelipatan Persekutuan Terkecil (KPK) : ${kpk.hasil()}");
  print("Kelipatan Persekutuan Terbesar (FPB) : ${fpb.hasil()}");
}
