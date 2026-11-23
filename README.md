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

### Assignment 8

1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode mana yang membuka formulir dari tombol kartu aksi (action card)? Jelaskan bagaimana opsi Home pada drawer membawa pengguna kembali ke halaman utama.
  - Perbedaan Ketiga Metode `Navigator`:
    - `Navigator.push()`: Menambahkan rute (halaman) baru ke puncak tumpukan (stack) navigasi di atas halaman yang sedang aktif saat ini. Halaman sebelumnya tetap tersimpan di bawahnya di dalam stack, sehingga pengguna dapat kembali ke halaman sebelumnya dengan mudah.
    - `Navigator.pushReplacement()`: Menghapus rute yang sedang tampil di puncak stack dan langsung menggantinya dengan rute baru yang dituju. Halaman lama tidak lagi berada di bawahnya pada stack navigasi.
    - `Navigator.pop()`: Menghapus rute paling atas yang sedang tampil di stack navigasi dan mengembalikan pengguna ke rute tepat di bawahnya (misalnya untuk menutup `AlertDialog` atau kembali dari halaman baru yang dibuka via `push()`).
  - Metode pada Tombol Kartu Aksi (Action Card): Tombol kartu `Add Education` di halaman utama (`ItemCard`) menggunakan `Navigator.push()`. Dengan demikian, `EducationFormPage` ditumpuk di atas `MyHomePage`, sehingga pengguna dapat kembali ke halaman utama menggunakan tombol Back sistem perangkat atau tombol Back pada browser.
  - Alur Opsi Home pada Drawer: Ketika pengguna membuka drawer dari halaman formulir (`EducationFormPage` atau `ProjectFormPage`) lalu menekan menu `Home`, `LeftDrawer` mengeksekusi `Navigator.pushReplacement()` menuju `MyHomePage()`. Metode ini menggantikan halaman formulir yang sedang aktif di puncak stack langsung dengan `MyHomePage()`, sehingga layar kembali ke beranda tanpa menumpuk riwayat navigasi secara berlebihan.

2. Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` menjaga struktur halaman tetap konsisten? Berikan satu contoh warna tema portofolio yang digunakan pada lebih dari satu halaman.
  - Konsistensi Struktur Halaman: Setiap layar utama aplikasi (`MyHomePage`, `ProjectFormPage`, dan `EducationFormPage`) dibungkus menggunakan widget kerangka standar `Scaffold` yang memiliki komposisi seragam: bilah atas `AppBar` untuk judul halaman, menu samping `Drawer` (`const LeftDrawer()`) yang diimpor dari komponen reusable yang sama di `lib/widgets/left_drawer.dart`, serta area `body` untuk konten masing-masing layar. Karena seluruh halaman menggunakan instance komponen `LeftDrawer` yang sama pada properti `drawer` milik `Scaffold`, ikon menu hamburger di kiri atas dan daftar navigasi antar-halaman selalu tampil dan berperilaku identik di setiap layar.
  - Contoh Penggunaan Warna Tema di Lebih dari Satu Halaman: Warna primer tema aplikasi yang diambil melalui `Theme.of(context).colorScheme.primary` (berbasis `seedColor: Colors.indigo` yang didefinisikan pada `MaterialApp` di `main.dart`) digunakan secara konsisten pada properti `backgroundColor` milik `AppBar` baik di halaman utama (`MyHomePage`) maupun di halaman formulir baru (`EducationFormPage`), serta pada warna latar tombol `Save` (`ElevatedButton`) di `EducationFormPage`.

3. Mengapa tata letak (layout) ini dipilih untuk formulir? Jelaskan fungsi widget spasi (spacing) dan pengguliran (scrolling) ketika ruang layar terbatas.
  - Alasan Pemilihan Tata Letak: Formulir `EducationFormPage` disusun menggunakan kombinasi `Form` -> `SingleChildScrollView` -> `Column` dengan perataan `CrossAxisAlignment.start`. Susunan vertikal satu kolom dipilih agar setiap elemen input (dari Institution Name hingga End Date dan tombol `Save`) memiliki ruang lebar penuh yang mudah dibaca, diisi, dan ditekan pada layar perangkat mobile yang sempit maupun desktop.
  - Fungsi Widget Spacing dan Scrolling saat Ruang Layar Terbatas:
    - Widget Scrolling (`SingleChildScrollView`): Secara bawaan, widget `Column` tidak dapat digulir (non-scrollable) dan akan memunculkan galat RenderFlex overflow jika tinggi total kontennya melebihi tinggi layar—terutama pada ponsel berlayar kecil atau saat on-screen keyboard muncul menutupi separuh layar. `SingleChildScrollView` membuat seluruh isi formulir dapat digulir ke atas dan ke bawah sehingga semua field input maupun tombol `Save` tetap dapat dijangkau pengguna dalam kondisi apa pun.
    - Widget Spacing (`Padding`): Pembungkusan setiap elemen input dan tombol dengan `Padding` (`EdgeInsets.only(bottom: 12.0)` / `16.0` serta `EdgeInsets.all(16.0)` di sekeliling `Column`) memberikan jarak pemisah visual yang jelas antar-kolom input serta mencegah tepi kotak input menempel langsung pada pinggir layar, sehingga mengurangi risiko salah sentuh (mis-tap) pada layar sentuh berukuran kecil.

4. Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` ketika tombol `Save` ditekan? Berikan satu contoh nilai yang ditolak oleh formulir dan jelaskan mengapa pemilihan widget input atau jenis keyboard saja tidak cukup.
  - Peran Masing-Masing Komponen Saat `Save` Ditekan:
    - `GlobalKey<FormState>` (`_formKey`): Bertindak sebagai pengenal unik yang memegang referensi langsung ke status internal (`FormState`) dari widget `Form` di dalam widget tree, memungkinkan tombol `Save` mengakses dan mengontrol seluruh field di dalamnya.
    - `validator`: Fungsi callback yang didefinisikan pada masing-masing `TextFormField` dan `FormField` untuk memeriksa apakah nilai masukan pengguna memenuhi aturan model tertentu. Jika tidak valid, `validator` mengembalikan string pesan galat; jika valid, mengembalikan `null`.
    - `_formKey.currentState!.validate()`: Metode yang dipanggil di dalam `onPressed` tombol `Save` untuk memicu eksekusi seluruh fungsi `validator` pada setiap field di dalam `Form` secara serentak. Metode ini akan menampilkan pesan galat tepat di bawah setiap kolom yang gagal validasi dan mengembalikan nilai `true` hanya jika seluruh input valid (sehingga `AlertDialog` ringkasan hanya muncul apabila semua data lolos pemeriksaan).
  - Contoh Nilai yang Ditolak & Alasan Widget Input/Keyboard Saja Tidak Cukup:
    - Contoh Nilai yang Ditolak: Pada kolom GPA (0.00 - 4.00), nilai seperti `"4.50"` atau `"-1.0"` akan ditolak dengan pesan `"Enter a valid GPA between 0.00 and 4.00."`; atau pada kolom Institution Name, input yang hanya berisi spasi seperti `"   "` akan ditolak oleh pengecekan `value.trim().isEmpty`.
    - Mengapa Widget Input / Jenis Keyboard Saja Tidak Cukup: Meskipun kolom GPA sudah dikonfigurasi menggunakan `keyboardType: TextInputType.numberWithOptions(decimal: true)`, pengaturan keyboard hanya memengaruhi tata letak tombol virtual yang muncul di perangkat mobile—pengguna tetap dapat mengetik angka di luar batas skala IPK (seperti `5.2`), memasukkan lebih dari satu tanda titik desimal (`"3..5"`), atau menempelkan (paste) teks sembarang dari clipboard maupun mengetik lewat keyboard fisik di web/desktop. Oleh karena itu, validasi logika eksplisit di dalam `validator` tetap mutlak diperlukan untuk menjamin integritas data.

## AI Disclosure

Sebagian besar pengerjaan Individual Assignment 7 dan Individual Assignment 8—mulai dari inisialisasi proyek, penataan struktur direktori (`lib/screens/` dan `lib/widgets/`), kustomisasi komponen UI (`InfoCard`, `ItemCard`, dan `LeftDrawer`), pembangunan formulir `EducationFormPage` beserta validasinya, hingga pengujian—dikerjakan secara mandiri. Saya hanya memanfaatkan Gemini secara terbatas sebagai alat bantu troubleshooting dan referensi cepat.

- Alat yang Digunakan: Gemini.
- Peran AI (Terbatas):
  - Membantu mencari solusi saat terjadi kendala pendaftaran Environment Variables (`PATH`) Flutter SDK di Windows.
  - Memberikan referensi sintaks dasar widget Flutter (termasuk penggunaan `FormField<DateTime>` bersama `showDatePicker()`) dan kerangka awal dokumentasi.
- Pengerjaan Mandiri & Perbaikan Manual:
  - Membangun dan menyusun langsung seluruh tampilan antarmuka aplikasi, data identitas (`NPM`, `Nama`, dan kelas `PBP F`), logika warna tombol pada `menu.dart`, serta integrasi navigasi tombol dan drawer (`project_card.dart` dan `left_drawer.dart`).
  - Merancang aturan validasi pada `education_form.dart` (pengecekan input kosong/spasi, batas rentang GPA `0.00 - 4.00`, serta validasi urutan tanggal mulai dan lulus) beserta ringkasan datanya pada `AlertDialog`.
  - Memperbaiki galat kompilasi serta unused import secara manual pada `lib/main.dart` dan `lib/screens/project_form.dart` (termasuk menghapus parameter `useMaterial3: true` yang sudah deprecated pada versi Flutter SDK terbaru) hingga `flutter analyze` berjalan bersih (`No issues found!`).
  - Meninjau, merumuskan ulang, dan memverifikasi seluruh jawaban pertanyaan reflektif di dalam `README.md`. 