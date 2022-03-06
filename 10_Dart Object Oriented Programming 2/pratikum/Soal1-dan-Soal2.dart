class BangunRuang {
  late int panjang;
  late int lebar;
  late int tinggi;

  BangunRuang(int p, int l, int t) {
    this.panjang = p;
    this.lebar = l;
    this.tinggi = t;
  }

  int volume() {
    return panjang * lebar * tinggi;
  }
}

class Kubus extends BangunRuang {
  late int sisi;
  Kubus(int sisi) : super(sisi, sisi, sisi) {
    this.sisi = sisi;
  }

  @override
  int volume() {
    return sisi * sisi * sisi;
  }
}

class Balok extends BangunRuang {
  Balok(int p, int l, int t) : super(p, l, t);

  @override
  int volume() {
    return panjang * lebar * tinggi;
  }
}

void main() {
  BangunRuang bangun = BangunRuang(2, 4, 6);
  Kubus kubus = Kubus(4);
  Balok balok = Balok(1, 2, 3);

  print("BangunRuang Volume : ${bangun.volume()}");
  print("Kubus Volume : ${kubus.volume()}");
  print("Balok Volume : ${balok.volume()}");
}
