# (10) Dart Object Oriented Programming 2

## Resume

Sifat:
Contructor
Overriding
Polymor
Inheritance
Interface
Extends

Abstract

Generics

Dalam materi ini, mempelajari :

1. Lanjutan dan Sifat Object Oriented Programming (OOP)
2. Abstract Class
3. Generic Type

### Lanjutan dan Sifat Object Oriented Programming (OOP)

#### Constructor

Fungsi yang dijalankan pertama kali bersamaan saat sebuah objek dari kelas dibuat. Berbeda dengan fungsi biasa, di constructor tidak terdapat pengembalian nilai, namun dapat memiliki parameter.
Constructor biasanya digunakan untuk memasukkan nilai awal dari property class.

```
class Mahasiswa{
    var nama;
    var nim;

    Mahasiswa(){ // Ini adalah constructor
        nama = "Jovin Lidan";
        nim = "191111525";
    }
}
```

#### Overriding

Dengan overriding pada bagian method, maka class anak akan menulis ulang isi dari method class induxnya.
Overriding dilakukan ketika class anak mewarisi suatu class (class induk), dan method yang diwariskan harus terdapat dalam class induk.
`@override` ditambahkan sebelum baris method.

#### Inheritance

Pewarisan yang terdapat didalam kelas, dimana class anak dapat mewarisi property dan method yang dimiliki class induk.
Keyword untuk pewarisan yang digunakan :

- `implements` , pada implements seluruh method pada class induk wajib diwariskan ke class anaknya. Biasanya dengan menggunakan Implements maka class induknya akan disebut sebagai _interface_.
  ```
  class MahasiswaAkhir implements Mahasiswa{
  }
  ```
- `extends` , pada extends tidak seluruh method pada class induk wajib diwariskan ke class anaknya.
  ```
  class MahasiswaBaru extends Mahasiswa{
  }
  ```

#### Polymorphism

Pada class anak , kita dapat membuat objeknya dan menggunakan tipe data class indux sebagai tipe data dari objek tersebut menggunakan keyword `extends` atau `implements`.

```
void main() {
  Mahasiswa jovin = MahasiswaAkhir();
  jovin.belajar();
}
```

### Abstract Class

abstract class adalah class yang tidak dapat dibuat objek nya, dan hanya dapat diwarisi oleh class-class anaknya.
Cara pewarisan pada class anak menggunakan keyword `extends`.

```
abstract class Mahasiswa {
  Mahasiswa() {
  }
  belajar() {
    print("mahasiswa belajar");
  }
}

class MahasiswaAkhir extends Mahasiswa {
  MahasiswaAkhir() {
  }
  @override
  belajar() {
    print("mahasiswaAkhir belajar");
  }
}
```

### Generics

Suatu cara yang digunakan dalam class ataupun fungsi agar keduanya dapat menerima data dengan tipe yang dinamis sesuai dengan tipe yang kita masukkan ketika membuat objek dari class atau memanggil fungsi.

```
class Mahasiswa<T, S> {
  late T data1;
  late S data2;
  Mahasiswa(T data1, S data2) {
    this.data1 = data1;
    this.data2 = data2;
  }
  cetakUmur<Z>(Z umur) {
    print(umur);
  }
}
void main() {
  Mahasiswa jovin = Mahasiswa<int, String>(1, "Jovin");
  jovin.cetakUmur<String>("asd");
}
```

## Task
