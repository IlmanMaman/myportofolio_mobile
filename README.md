# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Assignment 7

1. Jelaskan apa itu widget tree di Flutter dan bagaimana hubungan parent-child bekerja antar-widget.
   * Pengertian Widget Tree: Widget tree adalah struktur hierarki berbentuk pohon yang merepresentasikan seluruh elemen antarmuka pengguna (UI) dalam aplikasi Flutter. Di Flutter, hampir semua komponen—mulai dari tata letak (layout), teks, ikon, pengaturan jarak (padding), hingga konfigurasi tema—merupakan sebuah widget.
   * Cara Kerja Hubungan Parent-Child: Setiap widget dapat membungkus satu widget tunggal (melalui properti `child`) atau sekumpulan widget sekaligus (melalui properti `children` bertipe `List<Widget>`). Proses tata letak di Flutter mengikuti prinsip "Constraints go down. Sizes go up. Parent sets position.":
     * Widget parent meneruskan batasan ukuran (constraints seperti lebar/tinggi minimum dan maksimum) serta data konteks ke widget child di bawahnya.
     * Widget child menentukan ukurannya sendiri sesuai batasan yang diberikan oleh parent-nya, lalu melaporkan ukuran tersebut kembali ke atas.
     * Widget parent kemudian mengatur posisi letak child tersebut di layar.
     * Sebagai contoh pada proyek ini, `Scaffold` bertindak sebagai parent bagi `Padding`, yang membungkus `Column`, dan di dalamnya terdapat beberapa children seperti `Row` (untuk 3 `InfoCard`) dan `Center` (untuk `GridView.count` berisi 3 `ItemCard`).

2. Sebutkan semua widget yang digunakan dalam proyek ini dan jelaskan masing-masing fungsinya.
   * `MyApp` (`StatelessWidget`): Widget akar (root) aplikasi yang menyimpan konfigurasi tingkat atas aplikasi.
   * `MaterialApp`: Membungkus seluruh aplikasi dengan sistem desain Material Design, mengatur judul aplikasi (`title`), tema warna global (`theme`), dan layar pertama yang ditampilkan (`home`).
   * `MyHomePage` (`StatelessWidget`): Widget halaman utama yang menampilkan kartu identitas pemilik portofolio dan menu tombol aksi.
   * `Scaffold`: Menyediakan kerangka struktur standar halaman Material Design, termasuk area `appBar` di bagian atas dan `body` untuk konten utama.
   * `AppBar`: Menampilkan bilah judul (header) di bagian atas halaman dengan warna latar belakang dari tema utama.
   * `Padding`: Memberikan ruang jarak kosong (inset) di sekeliling widget child agar konten tidak menempel langsung pada tepi layar.
   * `Column`: Menyusun daftar widget children secara vertikal dari atas ke bawah.
   * `Row`: Menyusun daftar widget children secara horizontal dari kiri ke kanan (digunakan untuk mensejajarkan ketiga `InfoCard`).
   * `SizedBox`: Membuat kotak dengan dimensi tertentu untuk memberikan jarak spasi antar-widget.
   * `Center`: Memposisikan widget child tepat di tengah ruang yang tersedia.
   * `Text`: Menampilkan string teks ke layar dengan pengaturan gaya tertentu seperti ukuran dan ketebalan huruf (`TextStyle`).
   * `GridView.count`: Menampilkan sekumpulan widget dalam format kisi (grid) dengan jumlah kolom tetap (`crossAxisCount: 3`).
   * `InfoCard` (`StatelessWidget`): Widget kustom reusable untuk menampilkan kartu informasi identitas mahasiswa (NPM, Nama, dan Kelas).
   * `Card`: Menampilkan panel kotak berbasis Material Design lengkap dengan sudut membulat dan bayangan (`elevation`).
   * `Container`: Widget pembungkus serbaguna untuk mengatur lebar (`width`), jarak dalam (`padding`), dan tata letak isi kartu.
   * `ItemCard` (`StatelessWidget`): Widget kustom reusable yang merepresentasikan setiap tombol aksi dengan ikon, teks label, serta warna latar belakang yang berbeda-beda.
   * `Material`: Menyediakan kanvas dasar Material Design untuk menerapkan warna latar belakang (`item.color`) dan kelengkungan sudut (`borderRadius`) agar efek riak sentuhan dapat dirender secara rapi.
   * `InkWell`: Menjadikan area kartu responsif terhadap sentuhan atau klik pengguna (`onTap`) sekaligus menampilkan efek animasi riak air (ripple effect).
   * `SnackBar`: Menampilkan bilah pesan notifikasi sementara di bagian bawah layar saat tombol aksi ditekan.
   * `Icon`: Menampilkan ikon grafis vektor bawaan Material Icons di dalam tombol menu.

3. Apa tujuan dari widget `MaterialApp`? Jelaskan mengapa widget ini umum digunakan sebagai root widget pada aplikasi Flutter.
   * Tujuan `MaterialApp`: `MaterialApp` berfungsi sebagai pembungkus tingkat atas yang menerapkan standar desain antarmuka Material Design ke seluruh bagian aplikasi. Widget ini menginisialisasi berbagai layanan esensial seperti sistem navigasi antar-halaman (`Navigator`), rute (`routes`), pengaturan tema warna dan tipografi global (`ThemeData`), serta lokalisasi bahasa.
   * Alasan Dijadikan Root Widget: Dengan menempatkan `MaterialApp` sebagai root widget aplikasi, seluruh widget turunan di bawahnya (seperti `Scaffold`, `AppBar`, `Card`, `Text`, dan `SnackBar`) otomatis mewarisi konteks tema, arah pembacaan teks (`Directionality`), dan layanan pesan layar (ScaffoldMessenger) secara seragam tanpa harus mendefinisikannya berulang kali di setiap halaman.

4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan sebaiknya memilih `StatelessWidget`, dan kapan `StatefulWidget` diperlukan?.
   * Perbedaan Utama:
     * `StatelessWidget` bersifat immutable (tidak dapat diubah setelah dirender). Widget ini tidak memiliki state internal yang berubah selama siklus hidupnya; tampilannya hanya bergantung pada parameter konfigurasi awal yang diterima saat konstruksi.
     * `StatefulWidget` bersifat dinamis (mutable). Widget ini dipasangkan dengan objek `State` terpisah yang menyimpan data yang dapat berubah sewaktu-waktu selama aplikasi berjalan, serta dapat memicu pembangunan ulang tampilan layar (rebuild) secara spesifik melalui pemanggilan metode `setState()`.
   * Kapan Memilih Masing-Masing:
     * Pilih `StatelessWidget` ketika bagian antarmuka hanya menyajikan data statis atau tampilan yang tidak perlu berubah secara lokal saat berinteraksi dengan pengguna—contohnya kartu identitas `InfoCard`, judul halaman, maupun tombol menu `ItemCard` yang hanya memicu notifikasi `SnackBar`.
     * Pilih `StatefulWidget` ketika tampilan UI perlu diperbarui secara interaktif berdasarkan masukan pengguna atau perubahan data waktu nyata—contohnya formulir input teks (Form/TextField), penghitung (counter), tombol toggle/checkbox, animasi, atau halaman yang memuat data asinkron dari API.

5. Apa itu `BuildContext` dan mengapa hal ini krusial di Flutter? Bagaimana penggunaannya di dalam metode `build`?
   * Pengertian & Peran Krusial: `BuildContext` adalah objek referensi (pegangan) yang merepresentasikan lokasi spesifik sebuah widget di dalam struktur widget tree. Objek ini sangat krusial karena berperan sebagai jembatan komunikasi yang memungkinkan suatu widget mengakses informasi atau layanan dari widget leluhur (ancestor) di atasnya dalam hierarki pohon.
   * Penggunaan di Dalam Metode `build`: Setiap metode `Widget build(BuildContext context)` menerima `context` sebagai parameter wajib. Dalam proyek ini, `context` dimanfaatkan di dalam metode `build` untuk:
     * Mengambil konfigurasi warna tema global melalui `Theme.of(context).colorScheme.primary`.
     * Mendapatkan ukuran lebar layar perangkat secara responsif melalui `MediaQuery.of(context).size.width`.
     * Mengakses `ScaffoldMessenger` terdekat di atas hierarki untuk menampilkan notifikasi `SnackBar` lewat `ScaffoldMessenger.of(context).showSnackBar(...)`.

6. Jelaskan konsep hot reload di Flutter dan perbedaannya dengan hot restart. Kapan kita tidak bisa mengandalkan hot reload dan harus melakukan hot restart atau full restart?
   * Konsep Hot Reload: Fitur pengembangan Flutter yang menyuntikkan berkas kode Dart yang baru diubah langsung ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Flutter kemudian membangun ulang widget tree secara instan (dalam hitungan milidetik) tanpa menghapus atau mereset nilai state aplikasi yang sedang aktif.
   * Perbedaan dengan Hot Restart: Hot restart memuat ulang seluruh kode Dart aplikasi dari awal sekaligus menghapus seluruh state yang tersimpan di memori dan mengeksekusi ulang fungsi `main()`, namun tetap jauh lebih cepat dibandingkan full restart karena tidak mengompilasi ulang kode native platform (Android/iOS/Web).
   * Kapan Harus Melakukan Hot Restart atau Full Restart:
     * Perlu Hot Restart: Ketika mengubah kode di dalam fungsi `main()`, memodifikasi inisialisasi variabel state (`initState`), mengubah nilai variabel global atau konstanta `static`, serta mengubah tipe kelas dari `StatelessWidget` menjadi `StatefulWidget` (atau sebaliknya).
     * Perlu Full Restart (Stop lalu Run ulang): Ketika menambahkan atau memperbarui dependensi package di `pubspec.yaml`, menambahkan aset baru (seperti gambar atau font), atau melakukan perubahan pada konfigurasi kode native platform (seperti `AndroidManifest.xml` atau `Info.plist`).

## AI Disclosure

Sebagian besar pengerjaan Individual Assignment 7—mulai dari inisialisasi proyek, penataan struktur kode (`main.dart` dan `menu.dart`), kustomisasi komponen UI (`InfoCard` dan `ItemCard`), hingga pengujian dikerjakan secara mandiri. Saya hanya memanfaatkan Gemini secara terbatas sebagai alat bantu troubleshooting dan referensi cepat.

* Alat yang Digunakan: Gemini.
* Peran AI (Terbatas):
  * Membantu mencari solusi saat terjadi kendala pendaftaran Environment Variables (`PATH`) Flutter SDK di Windows.
  * Memberikan referensi sintaks dasar widget Flutter dan kerangka awal dokumentasi.
* Pengerjaan Mandiri & Perbaikan Manual:
  * Membangun dan menyusun langsung seluruh tampilan antarmuka aplikasi, data identitas (`NPM`, `Nama`, dan kelas `PBP F`), serta logika warna tombol pada `lib/menu.dart`.
  * Memperbaiki galat kompilasi secara manual pada `lib/main.dart` dengan menghapus parameter `useMaterial3: true` yang sudah deprecated pada versi Flutter SDK terbaru hingga `flutter analyze` berjalan bersih (`No issues found!`).
  * Meninjau, merumuskan ulang, dan memverifikasi seluruh jawaban pertanyaan reflektif di dalam `README.md`.    