# Talent Insider App

## Petunjuk Tentang Cara Menjalankan Project
1. clone Project ini di github
2. cd nama-repo
3. flutter pub get
4. flutter run

## Struktur Proyek
 Menggunakan State Management Provider dan Architecture MVVM
```
lib/
├── core/
│ ├── assets/ # Path aset (gambar, ikon, dll.)
│ │ └── resource_path.dart
│ ├── components/ # Widget reusable
│ │ └── button.dart
│ ├── constants/ # Konstanta teks dan warna
│ │ ├── app_label.dart
│ │ └── color.dart
│ └── themes/style/ # Gaya teks dan tema
│ └── textstyle.dart
├── models/
│ ├── apis/ # Controller API
│ │ ├── course_api_controller/
│ │ └── login_api_controller/
│ ├── courses_model/
│ └── user_model/
├── view/ # Tampilan UI
│ ├── audio_book/
│ ├── courses/
│ ├── home/
│ ├── login/
│ ├── nav_bar/
│ ├── onboarding/
│ └── profile/
├── view_model/ # ViewModel untuk manajemen data
│ ├── audio_book_view_model/
│ └── courses_view_model/
└── main.dart # Entry point aplikasi
```

## Informasi Tambahan
- Pastikan versi Flutter yang digunakan kompatibel dengan versi package pada pubspec.yaml.
- Jika menggunakan plugin atau package tertentu, baca dokumentasi resmi package tersebut untuk konfigurasi tambahan.

## Hasil
   ![alt text](talent_insider.gif)
