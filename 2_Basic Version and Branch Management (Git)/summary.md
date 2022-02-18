# (2) Basic Version and Branch Management (Git)

---

## Resume Materi

### 1. Definisi Git

Git merupakan sebuah tools yang digunakan untuk mengatur versi dan menyimpan source code dari program kita. Git dapat digunakan secara local maupun remote, yang berarti meskipun server sedang bermasalah, kita tetap dapat melakukan aktivitas kita di local. Github merupakan salah satu hosting server untuk git di server atau remote\*\*

Cara paling rapi menggunakan git pada saat berkolaborasi dengan orang lain adalah dengan membiarkan branch master tidak disentuh langsung, kemudian membuka branch development yang akan menerima seluruh merge request dari branch featureA , featureB dan sebagainya. Kemudian apabila pada branch development sudah tidak ada bug dan codenya sudah clean, maka dilakukan merge ke branch master.

### 2. Cara menggunakan Git

#### Cara menyimpan sebuah catatan perubahan dalam git :

1. Memanggil perintah `git add .` , "." berarti menambahkan seluruh perubahan yang terjadi dalam repository kita ke area staging dari working directory. (_dapat digantikan dengan nama file_)
2. Memanggil perintah `git commit -m "pesan atau catatan yang mendeskripsikan perubahan yang dilakukan"`
3. Jika kita ingin menyimpan perubahan kita ke remote / server, maka dapat memanggil perintah `git push origin {nama branch}`. (_Nama branch diisi dengan nama branch dimana commit dilakukan_)

### 3.Perintah Git

- `git status`, untuk melihat status perubahan atau staged area kita.
- `git stash`, untuk menyimpan perubahan kedalam stash
- `git diff` , untuk melihat perbedaan antara working dengan staging
- `git log`, untuk melihat log commit sebelumnya
- `git checkout`, untuk berpindah branch ataupun commit
- `git pull` , untuk mengambil perubahan dari remote pada suatu branch
- `git fetch`, untuk memperbaharui repository local agar sync dengan remote
- `git reset`, untuk mundur ke commit sebelumnya
- `git branch`, untuk mendapatkan informasi branch
- `git merge`, untuk melakukan merge antar branch
