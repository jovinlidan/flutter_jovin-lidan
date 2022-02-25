void main() {
  List<List<int>> lists = [
    //Membuat list 2D
    [1, 2],
    [3, 4],
    [5, 6]
  ];

  Map<int, List<int>> maps = {}; //Membuat Map

  for (int i = 0; i < lists.length; i++) {
    // Loop pertama
    for (int j = 0; j < lists[i].length; j++) {
      // Loop kedua (Nested Loop)
      if (maps.containsKey(i + 1)) {
        // Cek apabila didalam map sudah ada nilai dengan key i+1
        maps.update(i + 1, (value) {
          // Jika ada, update nilai dari key
          var newValue = value; // buat variabel baru
          newValue.add(lists[i][j]); // tambahkan dengan nilai di posisi i , j
          return newValue; // kembalikan nilai yang sudah diupdate
        });
        continue; // continue agar tidak melanjutkan yang dibawah
      }
      maps[i + 1] = [lists[i][j]]; // Jika belum ada key, maka assign key dengan nilai baru
    }
  }

  print(maps); // Cetak nilai dari maps
}
