var fungsiPengali = (List<int> list, int pengali) async {
  // Membuat fungsi baru dengan 2 parameter
  print("Fungsi Start"); // Cetak ketika fungsi dimulai
  List<int> hasil = []; // buat List kosong untuk menampung hasil pengalian
  await Future.forEach(list, (item) async {
    // await pada tiap foreach untuk menunggu proses nya selesai secara asynchronous
    hasil.add((item as int) * pengali); // Tambahkan hasil pengalian kedalam list baru yang sudah dibuat diatas
    print("loop ${item}"); // Cetak setiap perulangan untuk keperluan pembuktian
  });
  print("Fungsi End"); // Cetak ketika fungsi berakhir
  return hasil; // Kembalikan nilai hasil pengalian
};

Future<void> main() async {
  print("Program start"); // Cetak program berjalan
  print(await fungsiPengali([1, 2, 3], 2)); // Cetak hasil yang direturn oleh fungsi kemudian await untuk menunggu fungsi berjalan hingga selesai
  print("Program end"); // Cetak program berhenti
}
