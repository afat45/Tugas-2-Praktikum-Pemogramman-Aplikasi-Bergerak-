# 🐉 Long Xuan: Barongsai Visit & Performance Management System

**Long Xuan** merupakan aplikasi manajemen reservasi pertunjukan Barongsai berbasis mobile yang dikembangkan menggunakan **Flutter** dan **Supabase**. Aplikasi ini dirancang untuk menggantikan sistem pencatatan manual menjadi sistem digital yang terpusat, aman, dan efisien.

Aplikasi ini mengadopsi standar industri dengan pola arsitektur **MVC (Model-View-Controller)**, memastikan pemisahan logika bisnis dari antarmuka pengguna, sehingga aplikasi memiliki skalabilitas yang tinggi.

---

## 👨‍💻 Profil Pengembang
- **Nama Pengembang** : Dharma Pala Candra
- **NIM** : 2409116065
- **Program Studi** : Sistem Informasi
- **Angkatan** : 2024 (Kelas B)
- **Handle/GitHub** : @afat45

---

## 📸 App Preview & Screenshot

| 1. Updated Home Screen | 2. Dark Mode Experience |
|:---:|:---:|
| ![Home Screen](ss\Screenshot 2026-03-14 104105.png) | ![Dark Mode](ss\Screenshot 2026-03-14 104114.png) |
| *Tampilan utama dengan Sliver Parallax & List Data* | *Antarmuka elegan dengan proteksi mata* |

| 3. Form Input System | 4. Data Persistence Result |
|:---:|:---:|
| ![Form Input](ss\Screenshot 2026-03-14 104207.png) | ![Read Data](ss\Screenshot 2026-03-14 104222.png) |
| *Validasi input & Integration DatePicker* | *Data berhasil tersinkronisasi dari Supabase* |

---

## 🏛️ Arsitektur Aplikasi: Pola Design MVC

Aplikasi ini dipecah menjadi beberapa layer modular untuk menjaga kebersihan kode (*clean code*):

### 1. Model Layer (`lib/models/`)
Layer ini mendefinisikan struktur data tunggal yang digunakan di seluruh aplikasi.
- **`Registration Model`**: Mengelola objek pendaftaran. Dilengkapi dengan *factory constructor* `fromJson` untuk memproses data mentah dari PostgreSQL (Supabase) dan method `toJson` untuk memformat data sebelum diunggah.

### 2. Controller Layer (`lib/controllers/`)
Layer ini bertanggung jawab penuh atas logika pertukaran data.
- **`Registration Controller`**: Bertindak sebagai otak yang berkomunikasi dengan API Supabase. Semua fungsi CRUD (Create, Read, Update, Delete) diisolasi di sini agar View tidak memiliki akses langsung ke database.

### 3. View Layer (`lib/views/`)
Layer ini hanya fokus pada presentasi data dan interaksi pengguna.
- **`Home Screen`**: Dashboard utama menggunakan `CustomScrollView` dan `SliverAppBar` untuk menciptakan UI yang modern dan dinamis.
- **`Form Screen`**: Antarmuka input data yang dilengkapi dengan validasi *real-time* dan integrasi `DatePicker` sistem.

---

## 🛠️ Detail Implementasi Teknis

### 📦 Integrasi Database Supabase
Aplikasi terhubung secara asinkron dengan Supabase menggunakan `supabase_flutter`. 
- **Read**: Mengambil data secara *real-time* dan menampilkannya dalam bentuk list yang responsif.
- **Create/Update**: Menggunakan satu form yang cerdas untuk mendeteksi apakah pengguna sedang menambah data baru atau memperbarui data lama berdasarkan keberadaan `ID`.
- **Delete**: Dilengkapi dengan dialog konfirmasi (*Alert Dialog*) untuk mencegah penghapusan data secara tidak sengaja.

### 🛡️ Keamanan & Environment
Aplikasi ini menerapkan standar keamanan dengan menggunakan file `.env` melalui package `flutter_dotenv`.
- Kredensial sensitif seperti `SUPABASE_URL` dan `SUPABASE_ANON_KEY` disimpan di luar source code utama.
- File `.env` telah didaftarkan dalam `.gitignore` untuk mencegah kebocoran kunci API di repository publik.

### 🎨 UI/UX Profesional (Senior Level Design)
- **Glassmorphism & Parallax**: Header menggunakan gambar latar Barongsai dengan efek parallax dan gradasi warna merah gelap yang memberikan kesan elegan dan profesional.
- **Theming System**: Implementasi `ValueNotifier` untuk fitur **Dark Mode** dan **Light Mode** tanpa menyebabkan *rebuild* yang berat pada seluruh widget tree.
- **Input Validation**: Mencegah data kosong atau format yang salah masuk ke database.
- **Native DatePicker**: Memastikan input tanggal selalu valid dengan kalender asli sistem Android/iOS.

---

## 📂 Struktur Proyek Secara Detail

```text
.
├── lib/
│   ├── controllers/
│   │   └── registration_controller.dart  # Menangani query Supabase
│   ├── models/
│   │   └── registration_model.dart       # Blueprint data (Object Mapping)
│   ├── views/
│   │   ├── home_screen.dart              # UI Dashboard & List Data
│   │   └── form_screen.dart              # UI Input & Edit Data
│   └── main.dart                         # Inisialisasi app & Theme Config
├── assets/                               # Folder untuk file statis
├── screenshot/                           # Folder dokumentasi gambar
├── .env                                  # Kredensial API (Hidden)
├── .gitignore                            # Konfigurasi pengabaian file Git
└── pubspec.yaml                          # Daftar dependensi & aset

```

---

## 🚀 Fitur Unggulan

1. **Dual Theme Support**: Transisi mulus antara tema terang dan gelap.
2. **Real-time Database Connection**: Sinkronisasi data langsung dengan cloud.
3. **Advanced Sliver UI**: Tampilan header yang interaktif saat di-scroll.
4. **Automated Form Filling**: Saat mengedit, form secara otomatis terisi dengan data lama.
5. **Robust Error Handling**: Menampilkan pesan error yang jelas jika koneksi internet terputus atau query gagal.

---

## 📖 Instruksi Instalasi

1. **Persiapkan Database**:
Buat tabel `registrations` di Supabase dengan kolom: `id`, `client_name`, `phone_number`, `address`, `visit_date`, dan `created_at`.
2. **Konfigurasi .env**:
Buat file `.env` di root folder dan isi dengan URL serta Anon Key proyek Supabase Anda.
3. **Download Dependensi**:
Jalankan `flutter pub get` di terminal.
4. **Jalankan Aplikasi**:
Gunakan perintah `flutter run`.

---

© 2026 Dharma Pala Candra - Sistem Informasi 2024 B.
