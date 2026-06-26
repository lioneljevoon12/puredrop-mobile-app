# 📱 Roadmap Flutter — PUREDROP Mobile App

> Dibuat berdasarkan prototype HTML 7 screen + backend Laravel yang sudah ada.
> Developer: Lionel

---

## Gambaran Umum

```
Backend Laravel  ◄──── REST API (/api/app/*) ────► Flutter App
(sudah jalan)         (Sanctum token auth)         (yang akan dibuat)
```

Backend sudah punya endpoint untuk ESP32 & web browser.
Flutter butuh endpoint terpisah di `/api/app/*` — **Sanctum sudah terpasang**, tinggal dibuatkan controllernya.

---

## 🛠️ Tech Stack Flutter

| Kebutuhan | Package | Alasan |
|---|---|---|
| HTTP Client | `dio` | Interceptor mudah untuk inject token |
| State Management | `flutter_riverpod` | Lightweight, cocok untuk project skala ini |
| Navigation | `go_router` | Declarative, mudah handle auth redirect |
| Secure Storage | `flutter_secure_storage` | Simpan Sanctum token |
| Chart | `fl_chart` | Ring chart + bar chart (sesuai prototype) |
| Barcode Scanner | `mobile_scanner` | Scan barcode botol langsung dari kamera |
| Local Notif | `flutter_local_notifications` | Reminder minum per X menit |
| Push Notif | `firebase_messaging` | Opsional — notif dari server |
| Health Data | `health` | Baca langkah + detak jantung (Android Health Connect / iOS HealthKit) |
| Cache | `shared_preferences` | Simpan preferensi ringan (bukan token) |
| Env | `flutter_dotenv` | Pisah base URL dev vs production |

---

## 🔌 API Baru yang Perlu Dibuat Backend

> Koordinasikan ini dengan backend sebelum mulai coding Flutter.
> Semua pakai `Authorization: Bearer <sanctum_token>`.
> Prefix: `/api/app/`

| Method | Endpoint | Kegunaan |
|---|---|---|
| `POST` | `/api/app/auth/login` | Login → dapat token Sanctum |
| `POST` | `/api/app/auth/logout` | Revoke token |
| `GET` | `/api/app/user` | Data profil (nama, email, berat, usia) |
| `PUT` | `/api/app/user` | Update profil (berat, usia) |
| `GET` | `/api/app/membership` | Daftar botol + kuota tersisa bulan ini |
| `GET` | `/api/app/hydration/today` | Total ml hari ini + target WHO |
| `GET` | `/api/app/hydration/history` | Data 7/30 hari (untuk chart) |
| `GET` | `/api/app/fills` | Riwayat isi ulang (paginated) |
| `GET` | `/api/app/transactions` | Riwayat tagihan / transaksi |
| `POST` | `/api/app/bottles/activate` | Aktifkan botol via barcode (dari HP) |

> **Catatan:** Endpoint scan & fill tetap lewat mesin (ESP32), tidak direplikasi ke app.
> App hanya untuk **monitoring + histori + profil + aktivasi botol**.

---

## 📅 Fase Development

---

### 🟡 Fase 0 — Persiapan (Estimasi: 3–4 hari)

**Goal:** Project bisa jalan di emulator, design system siap.

- [ ] `flutter create puredrop_app` — setup project
- [ ] Konfigurasi `go_router` (auth guard: kalau belum login → redirect login)
- [ ] Setup `riverpod` + folder structure

```
lib/
├── core/
│   ├── api/         ← Dio client, interceptors
│   ├── theme/       ← Colors, typography dari prototype
│   └── router/      ← go_router setup
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── ai_health/
│   ├── membership/
│   ├── history/
│   └── profile/
└── shared/
    ├── widgets/     ← komponen reusable
    └── models/      ← data classes
```

- [ ] Ekstrak design tokens dari prototype HTML ke `AppTheme`:

```dart
// core/theme/app_colors.dart
class AppColors {
  static const aqua500  = Color(0xFF2A96D4);
  static const aqua600  = Color(0xFF1C77B4);
  static const aqua700  = Color(0xFF1A608F);
  static const teal400  = Color(0xFF36C9C0);
  static const teal500  = Color(0xFF16B0A8);
  static const ink      = Color(0xFF0D2A3F);
  static const inkSoft  = Color(0xFF4A647A);
  // ...
}
```

- [ ] Setup `flutter_dotenv` → `.env.dev` dan `.env.prod`
- [ ] Setup Dio dengan `AuthInterceptor` (auto-inject token + handle 401)
- [ ] Koordinasi dengan backend: minta endpoint `/api/app/*` dibuat

---

### 🟢 Fase 1 — Auth (Estimasi: 3–4 hari)

**Screens:** Login

**Goal:** User bisa login, token tersimpan, session persistent.

- [ ] **Login Screen** (sesuai prototype screen #1)
  - Logo PUREDROP + animasi drop
  - Field email kampus + password
  - Tombol "Masuk"
  - Validasi client-side (format email)
- [ ] `AuthRepository` → `POST /api/app/auth/login`
- [ ] Simpan token ke `flutter_secure_storage`
- [ ] `AuthNotifier` (Riverpod) — state: `loading | authenticated | unauthenticated`
- [ ] Auto-login saat app dibuka (cek token di secure storage)
- [ ] Logout (revoke token + hapus dari storage)

**Deliverable:** Bisa login, token tersimpan, restart app tetap login.

---

### 🟢 Fase 2 — Dashboard Hidrasi (Estimasi: 5–6 hari)

**Screens:** Dashboard (screen #2)

**Goal:** Layar utama fully functional dengan data real.

- [ ] **Hydration Ring** (fl_chart — PieChart/RadialChart)
  - Progress lingkaran biru muda → teal
  - Angka ml di tengah + label target
- [ ] **Stats Row** — 3 kartu kecil (isi ulang hari ini, kuota tersisa, streak)
- [ ] **Bar Chart 7 Hari** — `BarChart` dari fl_chart
  - Hari ini pakai warna teal (berbeda)
- [ ] `HydrationRepository` → `GET /api/app/hydration/today` + `GET /api/app/hydration/history`
- [ ] Pull-to-refresh
- [ ] Skeleton loading state (jangan tunjukkan data kosong)
- [ ] Bottom Navigation Bar (4 tab: Hidrasi, AI, Member, Profil)

**Deliverable:** Dashboard live dengan data dari API.

---

### 🟢 Fase 3 — Profil (Estimasi: 3–4 hari)

**Screens:** Profil (screen #6)

**Goal:** User bisa lihat & edit data diri, lihat dampak lingkungan.

- [ ] Avatar inisial (huruf pertama nama, gradient biru)
- [ ] Grid stats: berat badan, target ml/hari, usia
- [ ] Info card: target hidrasi, status smartwatch, notifikasi, jumlah botol
- [ ] **Dampak kamu 🌱** — tampilkan jumlah botol plastik yang diganti
- [ ] Tombol Edit Profil → bottom sheet / screen baru
  - Ubah nama, berat badan, usia
  - Recalculate target otomatis (0,033 L × berat kg)
- [ ] `PUT /api/app/user`

**Deliverable:** Profil bisa dilihat & diedit.

---

### 🟢 Fase 4 — Membership & Botol (Estimasi: 6–7 hari)

**Screens:** Membership (screen #4) + Tambah Botol (screen #7)

**Goal:** User lihat kuota, daftar botol, bisa tambah/aktivasi botol.

- [ ] **Quota Card** (gradient biru gelap)
  - Progress bar kuota terpakai
  - Tier badge + tarif efektif
  - Tanggal aktif sampai
- [ ] **Daftar Botol Terdaftar** — list card dengan drop icon
- [ ] Tombol **+ Tambah Botol** → screen Tambah Botol
- [ ] **Screen Tambah Botol:**
  - Jalur 1 — Sudah punya botol:
    - [ ] Scan barcode via kamera (`mobile_scanner`)
    - [ ] Atau ketik manual nomor barcode
    - [ ] `POST /api/app/bottles/activate`
  - Jalur 2 — Beli botol baru:
    - [ ] Pilih Tier A (600 ml) / Tier B (1 L)
    - [ ] Tampilkan harga
    - [ ] Redirect ke Midtrans Snap (WebView atau browser)
- [ ] Tombol **Perbarui Langganan** & **Riwayat Tagihan**
- [ ] `MembershipRepository` → `GET /api/app/membership`

**Deliverable:** Bisa lihat status membership dan tambah botol via kamera.

---

### 🟢 Fase 5 — Riwayat (Estimasi: 3–4 hari)

**Screens:** Riwayat (screen #5)

**Goal:** User bisa lihat histori konsumsi & transaksi.

- [ ] **Chart Konsumsi Mingguan** (bar chart per minggu / bulan)
- [ ] **Daftar Transaksi** — list tile dengan icon, nama, waktu, jumlah
  - Tipe: isi ulang (kurangi L) vs perpanjang (Rp)
- [ ] Pagination / infinite scroll
- [ ] Filter: semua / isi ulang saja / tagihan saja
- [ ] `HistoryRepository` → `GET /api/app/fills` + `GET /api/app/transactions`

**Deliverable:** Riwayat lengkap bisa diakses.

---

### 🟡 Fase 6 — AI Kesehatan (Estimasi: 4–5 hari)

**Screens:** Analisis AI (screen #3)

**Goal:** Tampilkan analisis hidrasi + data smartwatch (jika tersedia).

- [ ] **AI Hero Card** — verdict + penjelasan
  - Data ini bisa dari backend (dihitung server) atau digenerate di client
- [ ] **Korelasi Data Smartwatch:**
  - Pakai package `health` → baca langkah & BPM dari Health Connect (Android) / HealthKit (iOS)
  - Minta permission: `ActivityRecognition`, `HealthKit`
  - Fallback elegan kalau tidak ada izin / tidak ada smartwatch
- [ ] **Rekomendasi AI** — 3 bullet rekomendasi
  - MVP: rule-based (kalau langkah > 8000 dan hidrasi < 70%, tampilkan pesan X)
  - Future: kirim data ke endpoint backend yang pakai LLM / model ML
- [ ] `HealthRepository` → local dari package `health` + `GET /api/app/hydration/today`

**Deliverable:** Screen AI terbuka, data smartwatch terbaca (atau fallback graceful).

---

### 🟠 Fase 7 — Notifikasi & Polish (Estimasi: 3–4 hari)

**Goal:** App terasa lengkap dan siap dipakai sehari-hari.

- [ ] **Reminder Minum** (`flutter_local_notifications`)
  - User set interval (misal: setiap 45 menit)
  - Notifikasi lokal terjadwal
  - Toggle di Profil → Notifikasi
- [ ] **Splash Screen** — logo PUREDROP + animasi
- [ ] **Empty States** — tampilkan ilustrasi kalau data kosong
- [ ] **Error States** — pesan yang user-friendly kalau API gagal
- [ ] **Offline Banner** — deteksi koneksi dengan `connectivity_plus`
- [ ] Animasi transisi halaman (fade / slide)
- [ ] Responsif untuk berbagai ukuran layar Android

---

### 🔴 Fase 8 — Testing & Release (Estimasi: 4–5 hari)

**Goal:** App stabil, siap distribusi.

- [ ] **Unit Test** — Repository & Notifier logic
- [ ] **Widget Test** — Login screen, Dashboard widget
- [ ] **Integration Test** — flow login → dashboard → logout
- [ ] Build APK release:

```bash
flutter build apk --release
# atau
flutter build appbundle --release  # untuk Play Store
```

- [ ] Setup signing keystore (jangan commit ke git)
- [ ] Obfuscate code: `--obfuscate --split-debug-info=./debug-info`
- [ ] Test di device fisik (bukan cuma emulator)
- [ ] Distribusi internal: Firebase App Distribution atau link APK langsung

---

## 📊 Estimasi Waktu Total

| Fase | Durasi | Status |
|---|---|---|
| 0 — Persiapan | 3–4 hari | ⬜ Belum |
| 1 — Auth | 3–4 hari | ⬜ Belum |
| 2 — Dashboard | 5–6 hari | ⬜ Belum |
| 3 — Profil | 3–4 hari | ⬜ Belum |
| 4 — Membership & Botol | 6–7 hari | ⬜ Belum |
| 5 — Riwayat | 3–4 hari | ⬜ Belum |
| 6 — AI Kesehatan | 4–5 hari | ⬜ Belum |
| 7 — Polish & Notif | 3–4 hari | ⬜ Belum |
| 8 — Testing & Release | 4–5 hari | ⬜ Belum |
| **Total** | **~35–43 hari kerja** | |

> Sekitar **7–9 minggu** kerja penuh, atau lebih lama kalau paralel dengan skripsi / kuliah.

---

## 🧠 Keputusan Penting yang Perlu Disepakati Lebih Awal

### 1. Urutan pengerjaan screen
Prioritas disarankan:
```
Login → Dashboard → Membership → Riwayat → Profil → AI
```
Karena Dashboard + Membership = inti value app.

### 2. AI Kesehatan — rule-based atau LLM?
- **Rule-based (MVP):** cepat dibuat, tidak butuh endpoint baru di backend
- **LLM (future):** butuh endpoint backend baru + biaya API

### 3. Smartwatch integration — wajib atau opsional?
- Kalau wajib: test harus di device fisik yang punya Health Connect
- Disarankan: opsional, dengan fallback "sambungkan smartwatch untuk analisis lebih akurat"

### 4. Apakah ada fitur **scan botol dari app** untuk isi ulang?
- Saat ini alur scan tetap di mesin (ESP32)
- App hanya untuk **aktivasi botol baru** (scan barcode → daftarkan ke akun)
- Kalau mau scan dari app untuk mulai isi ulang, butuh koordinasi firmware ESP32 + endpoint baru

---

## ⚠️ Hal yang Harus Dikoordinasikan dengan Backend (Sebelum Fase 1)

1. **Buat endpoint `/api/app/*`** — tanpa ini Flutter tidak bisa mulai Fase 1+
2. **Konfirmasi field profil user** — apakah `weight` dan `age` sudah ada di tabel `users`? Kalau belum, perlu migrasi
3. **Cara hitung `hydration today`** — dari `membership_fills` yang `completed_at` = hari ini?
4. **Streak sehat** — ada kolom/logika ini di backend? Atau dihitung Flutter dari data fills?
5. **Token lifetime Sanctum** — berapa lama token valid? Ada refresh token?

---

## 📁 Struktur Folder Lengkap (Target)

```
lib/
├── core/
│   ├── api/
│   │   ├── api_client.dart         ← Dio instance
│   │   ├── auth_interceptor.dart   ← inject token + handle 401
│   │   └── endpoints.dart          ← konstanta URL
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── router/
│       └── app_router.dart         ← go_router + auth guard
│
├── features/
│   ├── auth/
│   │   ├── data/auth_repository.dart
│   │   ├── domain/auth_notifier.dart
│   │   └── presentation/login_screen.dart
│   │
│   ├── dashboard/
│   │   ├── data/hydration_repository.dart
│   │   ├── domain/hydration_notifier.dart
│   │   └── presentation/
│   │       ├── dashboard_screen.dart
│   │       ├── widgets/hydration_ring.dart
│   │       └── widgets/week_bar_chart.dart
│   │
│   ├── ai_health/
│   │   ├── data/health_repository.dart
│   │   └── presentation/ai_health_screen.dart
│   │
│   ├── membership/
│   │   ├── data/membership_repository.dart
│   │   └── presentation/
│   │       ├── membership_screen.dart
│   │       └── add_bottle_screen.dart
│   │
│   ├── history/
│   │   ├── data/history_repository.dart
│   │   └── presentation/history_screen.dart
│   │
│   └── profile/
│       ├── data/user_repository.dart
│       └── presentation/profile_screen.dart
│
└── shared/
    ├── widgets/
    │   ├── app_bottom_nav.dart
    │   ├── gradient_card.dart
    │   ├── stat_chip.dart
    │   └── loading_skeleton.dart
    └── models/
        ├── user_model.dart
        ├── membership_model.dart
        ├── fill_model.dart
        └── hydration_summary_model.dart
```

---

*Last updated: Juni 2026*
