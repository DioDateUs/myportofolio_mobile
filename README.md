# MyPortfolio Mobile

Nama : Deodatus Kevin Sihaloho

NPM : 2506590920

Kelas : PBP F

## Deskripsi Proyek

Aplikasi ini adalah versi *mobile multiplatform* (berbasis Flutter) dari portofolio pribadi interaktif yang dirancang untuk menampilkan profil, latar belakang akademik (*education*), proyek, serta pengalaman organisasi. Proyek ini ditujukan untuk tugas individu mata kuliah Pemrograman Berbasis Platform Semester Gasal 2026/2027.

## Setup

Sebelum memulai, pastikan **Flutter SDK** dan **Dart SDK** sudah terpasang serta terdaftar pada variabel lingkungan `PATH`. Kamu dapat memverifikasi instalasi dengan menjalankan `flutter doctor` di terminal.

### 1. Clone repositori & masuk ke direktori proyek

Buka terminal, lalu jalankan:

```bash
git clone https://github.com/<username>/myportofolio_mobile.git
cd myportofolio_mobile
```

### 2. Pasang seluruh dependency

Unduh seluruh paket dan pustaka yang dibutuhkan proyek berdasarkan `pubspec.yaml`:

```bash
flutter pub get
```

### 3. Periksa kualitas & konfigurasi kode

Sebelum aplikasi dijalankan, pastikan tidak ada *error* atau *warning* sintaksis dengan menjalankan:

```bash
flutter analyze
```

### 4. Periksa perangkat target yang tersedia

Pastikan peramban (seperti Google Chrome), emulator Android, atau perangkat fisik sudah terdeteksi:

```bash
flutter devices
```

### 5. Jalankan aplikasi

Untuk menjalankan aplikasi di peramban Google Chrome:

```bash
flutter run -d chrome
```

Atau untuk menjalankan di emulator / perangkat yang sedang aktif:

```bash
flutter run
```

## Progres Mingguan

1. Tugas 7: Setup proyek Flutter `myportofolio_mobile`, pemisahan struktur `main.dart` dan `menu.dart`, pembuatan *reusable widgets* (`InfoCard` dan `ItemCard`), kustomisasi tema warna *Space*, serta implementasi umpan balik interaktif menggunakan `SnackBar`.
2. Tugas 8: Implementasi navigasi (`Navigator.push`, `pushReplacement`, `pop`), *Left Drawer*, *refactoring* direktori `screens/` dan `widgets/`, serta pembuatan halaman formulir baru `EducationFormPage` (`lib/screens/education_form.dart`) lengkap dengan `showDatePicker()`, validasi menyeluruh, dan `AlertDialog` ringkasan.

### Tugas 7

1. *Widget tree* di Flutter itu struktur hierarki berbentuk pohon yang nggambarin gimana seluruh elemen antarmuka (UI) disusun dari *widget-widget* yang saling bersarang (*nested*). Di Flutter, hampir semua hal itu adalah *widget*, mulai dari tata letak, teks, ikon, sampai struktur halaman. Hubungan induk-anak (*parent-child*) bekerja dengan cara *parent widget* membungkus satu anak lewat properti `child` (misalnya `Center`, `Padding`, `Container`, atau `Card`) atau membungkus banyak anak sekaligus lewat properti `children` dalam bentuk *list* (misalnya `Column`, `Row`, atau `GridView.count`). Dalam hubungan ini, *parent* bertugas ngasih konteks, batasan ukuran (*constraints*), dan posisi ke *child*-nya, terus *child* nentuin ukurannya sendiri sesuai batasan tersebut buat dirender di dalam *parent*. Contohnya di proyek ini, `Scaffold` jadi *parent* buat `AppBar` dan `Padding`, terus di dalam `Padding` ada `Column` yang punya `children` berupa `Row` (yang isinya tiga `InfoCard`) dan `Center` (yang di dalamnya ada `GridView.count` berisi daftar `ItemCard`).

2. Daftar *widget* yang aku pakai di proyek ini beserta fungsinya:
- `MyApp` (`StatelessWidget`): *Root widget* kustom aplikasi yang ngebungkus konfigurasi utama `MaterialApp`.
- `MaterialApp`: *Widget* pembungkus tingkat atas yang nyediain konfigurasi aplikasi bergaya Material Design, seperti `title`, `theme` (`ThemeData` dan `ColorScheme`), serta halaman awal (`home`).
- `MyHomePage` (`StatelessWidget`): *Widget* halaman menu utama portofolio yang nyusun seluruh struktur tampilan profil dan daftar tombol aksi.
- `Scaffold`: *Widget* kerangka dasar halaman Material Design yang nyediain slot standar buat `appBar`, `body`, dan tempat munculnya `SnackBar`.
- `AppBar`: *Bar* navigasi di bagian paling atas halaman yang nampilin judul aplikasi `'MyPortfolio'` dan warna latar dari tema utama.
- `Padding`: *Widget* buat ngasih jarak kosong di sekeliling *child*-nya, misalnya `EdgeInsets.all(16.0)` di body utama atau `EdgeInsets.only(top: 16.0)` di teks sambutan.
- `Column`: *Widget* *layout* buat nyusun beberapa *widget* anak (`children`) secara vertikal dari atas ke bawah, misalnya buat nyusun deretan `Row` kartu info dan bagian tengah menu, atau nyusun teks `title` dan `content` di dalam `InfoCard`.
- `Row`: *Widget* *layout* buat nyusun beberapa *widget* anak secara horizontal dari kiri ke kanan, yang di proyek ini dipakai buat ngejejerin tiga `InfoCard` (NPM, Name, Class) secara merata pakai `MainAxisAlignment.spaceEvenly`.
- `SizedBox`: *Widget* kotak dengan ukuran tetap yang aku pakai buat ngasih jarak vertikal antar-elemen, misalnya `SizedBox(height: 16.0)` dan `SizedBox(height: 8.0)`.
- `Center`: *Widget* buat nempatin *child*-nya tepat di tengah-tengah ruang yang tersedia dari *parent*-nya.
- `Text`: *Widget* buat nampilin tulisan ke layar lengkap dengan pengatur gayanya (`TextStyle`), seperti ukuran *font*, ketebalan (`FontWeight.bold`), dan warna teks.
- `GridView.count`: *Widget* *layout* berbentuk kisi (*grid*) dengan jumlah kolom tetap (`crossAxisCount: 3`) buat nampilin daftar kartu tombol `ItemCard` secara rapi.
- `InfoCard` (`StatelessWidget`): *Reusable widget* kustom yang aku buat buat nampilin kartu informasi identitas pemilik portofolio (judul dan isinya) biar ga perlu nulis ulang kode kartu tiga kali.
- `Card`: *Widget* Material Design yang bikin kotak dengan sudut agak membulat dan efek bayangan (*elevation*) buat membungkus tampilan `InfoCard`.
- `Container`: *Widget* serbaguna buat ngatur ukuran (misalnya `width` di `InfoCard` yang dibagi 3.5 dari lebar layar) dan `padding` dari elemen di dalamnya.
- `ItemCard` (`StatelessWidget`): *Reusable widget* kustom buat nampilin masing-masing objek `ItemHomepage` sebagai kartu tombol interaktif dengan warna latar berbeda.
- `Material`: *Widget* kanvas Material yang dipakai di `ItemCard` buat ngasih warna latar spesifik (`item.color`), sudut melengkung (`borderRadius`), sekaligus jadi alas supaya efek sentuh (*ripple effect*) dari `InkWell` bisa kelihatan.
- `InkWell`: *Widget* yang ngedeteksi interaksi ketukan pengguna (`onTap`) dan ngasih animasi efek riak air (*ripple*) waktu kartu tombol ditekan.
- `Icon`: *Widget* buat nampilin ikon grafis bawaan Material (`Icons.folder`, `Icons.add_circle`, `Icons.school`, `Icons.logout`) di dalam `ItemCard`.
- `SnackBar`: *Widget* pesan notifikasi pop-up sementara di bagian bawah layar yang muncul lewat `ScaffoldMessenger` waktu salah satu `ItemCard` ditekan.

3. `MaterialApp` berfungsi sebagai pembungkus utama yang nyiapin seluruh infrastruktur dasar buat aplikasi bergaya Material Design, mulai dari sistem *routing* dan navigasi antarhalaman (`Navigator`), pengaturan tema global (`ThemeData` dan `ColorScheme`), lokalisasi bahasa, sampe `ScaffoldMessenger` buat nampilin `SnackBar`. `MaterialApp` umumnya dipakai sebagai *root widget* karena banyak *widget* Material di bawahnya kayak `Scaffold`, `AppBar`, `Card`, `InkWell`, dan `Theme.of(context)` butuh konteks dan konfigurasi yang disediain sama `MaterialApp` di puncak *widget tree*. Kalau ga ada `MaterialApp` di paling atas, *widget-widget* tersebut bakal *error* karena ga nemu arah teks (*directionality*), tema warna, atau *navigator* yang mereka butuhin buat jalan.

4. Perbedaan utamanya ada di pengelolaan keadaan (*state*) internalnya. `StatelessWidget` itu *widget* yang sifatnya *immutable* (tetap), artinya begitu *widget* itu dibuat dan dirender, data atau properti di dalamnya ga bakal berubah sendiri selama *widget* itu hidup, tampilannya cuma bergantung sama konfigurasi awal yang dikasih lewat konstruktor. Sedangkan `StatefulWidget` punya objek `State` terpisah yang sifatnya *mutable* (bisa berubah) selama aplikasi jalan, dan tiap kali ada perubahan data yang dipicu lewat fungsi `setState()`, Flutter bakal nge-render ulang (*rebuild*) bagian UI tersebut buat nampilin nilai terbaru. Kita sebaiknya milih `StatelessWidget` kalau tampilan komponen atau halamannya statis dan ga perlu nyimpen perubahan data lokal, kayak `MyHomePage`, `InfoCard`, dan `ItemCard` di proyek ini yang isinya (NPM, Nama, Kelas, dan daftar tombol menu) tetap. Sebaliknya, kita harus pakai `StatefulWidget` kalau antarmukanya dinamis dan berubah-ubah sesuai interaksi pengguna atau data yang masuk, misalnya halaman penghitung klik (*counter*), *form* input teks yang ada validasi langsungnya, *checkbox*, atau halaman yang narik data dari API dan punya status *loading*.

5. `BuildContext` itu objek penunjuk yang merepresentasikan lokasi atau posisi sebuah *widget* di dalam struktur *widget tree*. Setiap *widget* punya `BuildContext`-nya sendiri yang dikirim sebagai parameter di dalam metode `Widget build(BuildContext context)`. `BuildContext` ini penting banget karena di Flutter, sebuah *widget* sering butuh nyari informasi atau memanggil layanan dari *widget* leluhur (*ancestor*) yang posisinya ada di atasnya pada *widget tree*. Contoh penggunaannya di dalam metode `build` pada proyek ini ada tiga: pertama, `Theme.of(context)` di `AppBar` buat ngambil warna `primary` dari `ThemeData` milik `MaterialApp` di atasnya; kedua, `MediaQuery.of(context).size.width` di `InfoCard` buat baca ukuran lebar layar perangkat supaya lebar kartunya proporsional; dan ketiga, `ScaffoldMessenger.of(context)` di `ItemCard` buat nyari `Scaffold` terdekat di atasnya dan nampilin `SnackBar` waktu kartu ditekan.

6. *Hot reload* adalah fitur di Flutter yang nyuntikkan perubahan kode sumber Dart yang baru disimpan langsung ke dalam Dart Virtual Machine (VM) yang lagi jalan, terus Flutter otomatis membangun ulang (*rebuild*) *widget tree* dalam hitungan milidetik **tanpa** menghapus *state* aplikasi yang lagi aktif. Bedanya sama *hot restart*, kalau *hot restart* itu ngulang eksekusi aplikasi dari awal lagi (mulai dari fungsi `main()` dan `initState()`), sehingga seluruh *state* yang tadinya tersimpan di memori bakal di-reset ke nilai awal, meskipun prosesnya tetap jauh lebih cepat daripada *full restart* karena ga perlu mengompilasi ulang kode native (Gradle/Xcode). Kita ga bisa cuma ngandalin *hot reload* dan harus melakukan *hot restart* kalau kita ngubah nilai inisialisasi variabel global/`static`, ngubah isi fungsi `main()` atau `initState()`, atau ngubah struktur kelas dari `StatelessWidget` jadi `StatefulWidget` (dan sebaliknya), serta waktu kita ngubah daftar `final List<ItemHomepage> items` yang diinisialisasi saat objek halaman pertama kali dibuat. Sedangkan *full restart* (stop lalu `flutter run` ulang) harus dilakukan kalau kita nambahin *dependency*/paket baru di `pubspec.yaml`, nambahin aset gambar/font baru, atau ngubah konfigurasi native di folder `android/`, `ios/`, atau `web/`.


### Tugas 8

1. Ketiga metode *Navigator* ini kerjanya di atas tumpukan (*stack*) halaman atau *route*:
- `Navigator.push()` itu nambahin *route* baru di paling atas *stack* tanpa ngehapus halaman sebelumnya, jadi halaman lama tetep ada di bawahnya dan pengguna bisa balik pakai tombol *Back* bawaan perangkat atau browser.
- `Navigator.pushReplacement()` itu ngegantiin *route* yang lagi tampil di puncak *stack* secara langsung sama *route* baru, jadi halaman sebelumnya dihapus dari puncak *stack* dan ga numpuk riwayat perpindahan yang berulang.
- `Navigator.pop()` itu ngehapus *route* yang lagi aktif di puncak *stack* supaya aplikasi balik ke *route* yang ada tepat di bawahnya (atau buat nutup *pop-up* `AlertDialog`, karena dialog di Flutter juga dihitung sebagai *route*).

Untuk membuka halaman formulir dari kartu aksi (`ItemCard` di `lib/widgets/project_card.dart`), aku pakai `Navigator.push()` baik untuk kartu **Tambah Proyek** maupun **Tambah Edukasi**, supaya setelah dibuka dari halaman utama, pengguna bisa langsung balik ke `MyHomePage` lewat tombol *Back* sistem. Sedangkan opsi **Home** di `LeftDrawer` (`lib/widgets/left_drawer.dart`) pakai `Navigator.pushReplacement()` menuju `MyHomePage()`, sehingga *route* halaman formulir yang lagi dibuka langsung diganti dengan halaman utama tanpa bikin *stack* menumpuk bolak-balik (misalnya `Home -> Form -> Home -> Form`).

2. Susunan `Scaffold`, `AppBar`, dan `Drawer` ngebantu ngejaga konsistensi karena setiap halaman (`MyHomePage`, `ProjectFormPage`, dan `EducationFormPage`) pakai kerangka struktural yang sama persis: `Scaffold` nyediain tata letak standar Material, `AppBar` selalu ada di bagian atas dengan judul halaman dan ikon menu *hamburger* putih yang posisinya tetap, dan `drawer: const LeftDrawer()` ngebawa komponen navigasi samping yang identik di semua halaman. Jadi di halaman mana pun pengguna berada, cara buka menu navigasinya selalu sama. Salah satu contoh penggunaan warna tema portofolio di lebih dari satu halaman adalah `Theme.of(context).colorScheme.primary` (warna *Cosmic Midnight Navy* `0xFF0F172A` yang didefinisikan sekali di `lib/main.dart`): warna ini aku pakai ulang untuk `backgroundColor` pada `AppBar` di `MyHomePage`, `ProjectFormPage`, dan `EducationFormPage`, untuk `BoxDecoration` di `DrawerHeader` pada `LeftDrawer`, sekaligus untuk warna latar tombol **Simpan** / **Save** di kedua halaman formulir.

3. Untuk formulir di `EducationFormPage` (`lib/screens/education_form.dart`), aku pakai susunan `Form` -> `SingleChildScrollView` -> `Column` dengan `crossAxisAlignment: CrossAxisAlignment.start`, karena input formulir secara alami paling enak diisi berurutan dari atas ke bawah dalam satu kolom vertikal. Peran *widget* pengatur jarak seperti `Padding` (`EdgeInsets.all(16.0)` di sekeliling form dan `EdgeInsets.symmetric(vertical: 8.0)` di setiap field) serta `SizedBox(height: 16.0)` sebelum tombol **Simpan** adalah ngasih ruang bernapas antar-komponen supaya label, *border*, dan pesan *error* validasi ga saling dempet dan tombol tetap nyaman ditekan. Sementara peran *widget* penggulir `SingleChildScrollView` itu krusial banget waktu layar sempit (ukuran ponsel) atau pas *keyboard* virtual muncul dari bawah: karena `Column` secara bawaan ga bisa di-*scroll* dan bakal kena *render overflow* kalau tingginya melebihi sisa layar, `SingleChildScrollView` bikin seluruh field dan tombol **Simpan** tetap bisa digulir dan dijangkau dengan lancar tanpa terpotong.

4. Saat tombol **Simpan** ditekan, alur validasinya melibatkan tiga hal itu:
- `GlobalKey<FormState>` (`_formKey`) bertindak sebagai pengenal unik yang dipasang di `Form(key: _formKey)` supaya kode di luar *widget* `Form` (yaitu di `onPressed` tombol **Simpan**) bisa ngakses `FormState` yang sedang aktif lewat `_formKey.currentState`.
- `validator` adalah fungsi *callback* yang dipasang di masing-masing *form field* (`TextFormField`) buat ngecek apakah nilai input memenuhi aturan model (kalau melanggar, ngembaliin teks pesan *error*; kalau lolos, ngembaliin `null`).
- `validate()` (`_formKey.currentState!.validate()`) bakal manggil semua `validator` di dalam `Form` tersebut sekaligus; kalau ada satu aja yang ngembaliin pesan *error*, pesan itu langsung ditampilin di bawah kolom terkait dan `validate()` ngembaliin `false` sehingga `AlertDialog` ga bakal muncul.

Contoh nilai yang ditolak oleh validasi di `EducationFormPage`:
- Input hanya berisi spasi (`"   "`) pada **Nama Institusi** atau **Jurusan**, ditolak karena kita cek `value.trim().isEmpty`.
- **IPK** bernilai `"5.5"` atau `"abc"`, ditolak karena harus berupa angka desimal valid di rentang `0.00` sampai `4.00`.
- **Tanggal Selesai** yang lebih awal dari **Tanggal Mulai**, ditolak oleh pengecekan `_endDate!.isBefore(_startDate!)`.
- **Tautan Institusi** seperti `"ui.ac.id"` tanpa skema `http://` atau `https://`, ditolak oleh `Uri.tryParse`.

Memilih jenis input atau `keyboardType` (seperti `TextInputType.numberWithOptions(decimal: true)` atau `TextInputType.url`) aja belum cukup karena `keyboardType` cuma sekadar saran tampilan papan ketik ke OS—pengguna tetap bisa menempel (*paste*) teks sembarangan, mengetik di keyboard fisik (misalnya pas dijalankan di web/Chrome), mengosongkan input, atau memasukkan angka di luar rentang logis (kayak IPK `99.9` atau `-1`). Jadi validasi eksplisit lewat `validator` tetap wajib ada buat menjamin integritas data.

## Keterangan Penggunaan AI (AI Disclosure)

- **Bagian yang dibantu AI**: Merapikan struktur impor `material_ui`, menyusun kerangka awal `EducationFormPage`.
- **Strategi prompting**: aku memberikan file spesifikasi tugas/tutorial dan memverifikasi langsung konteks proyek yang sedang aktif (`lib/main.dart`, `lib/screens/`, `lib/widgets/`) agar kode yang dihasilkan tetap konsisten dengan tema warna *Space* dan struktur proyek yang sudah ada.
- **Evaluasi & perbaikan manual**: aku meninjau ulang hasil kode dari AI, memastikan pengujian manual berjalan di Chrome, lalu memperbaiki bagian yang dirasa tidak sesuai dengan kesesuaian pada bagian lain yang dikejrakan manual.
