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
