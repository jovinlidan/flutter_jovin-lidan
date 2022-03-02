void main() {
  List<List<int>> lists = [
    //Membuat list 2D
    [1, 2],
    [3, 4],
    [5, 6]
  ];

  Map<int, int> maps = {}; //Membuat Map
  for (int i = 0; i < lists.length; i++) {
    // Loop pertama
    for (int j = 0; j < lists[i].length; j++) {
      // Loop kedua (Nested Loop)
      if (j == 1) {
        // apabila berada pada looping nested ke dua, maka masukkan nilai map dari lists sebelumnya sebagai key dan nilai lists sekarang sebagai value
        maps[lists[i][j - 1]] = lists[i][j];
      }
    }
  }
  print("List = $lists"); // Cetak nilai dari lists
  print("Map = $maps"); // Cetak nilai dari maps
}
