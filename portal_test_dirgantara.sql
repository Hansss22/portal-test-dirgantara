-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Jul 2026 pada 09.20
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `portal_test_dirgantara`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('portal-test-dirgantara-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1784185865),
('portal-test-dirgantara-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1784185865;', 1784185865),
('portal-test-dirgantara-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1784185980),
('portal-test-dirgantara-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1784185980;', 1784185980);

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_event` varchar(255) NOT NULL,
  `nama_event` varchar(255) NOT NULL,
  `tanggal_event` date NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `status` enum('draft','aktif') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `events`
--

INSERT INTO `events` (`id`, `kode_event`, `nama_event`, `tanggal_event`, `jam_mulai`, `jam_selesai`, `status`, `created_at`, `updated_at`) VALUES
(1, 'TA2026DEMO', 'Demo Tes Assessment K3LH', '2026-07-16', '05:11:00', '09:11:00', 'aktif', '2026-07-15 23:11:31', '2026-07-15 23:11:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `event_peserta`
--

CREATE TABLE `event_peserta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` bigint(20) UNSIGNED NOT NULL,
  `peserta_id` bigint(20) UNSIGNED NOT NULL,
  `waktu_mulai` timestamp NULL DEFAULT NULL,
  `waktu_selesai` timestamp NULL DEFAULT NULL,
  `status_pengerjaan` enum('belum','berlangsung','selesai') NOT NULL DEFAULT 'belum',
  `skor_pg` int(10) UNSIGNED DEFAULT NULL,
  `skor_esai_manual` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `event_peserta`
--

INSERT INTO `event_peserta` (`id`, `event_id`, `peserta_id`, `waktu_mulai`, `waktu_selesai`, `status_pengerjaan`, `skor_pg`, `skor_esai_manual`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-07-15 23:53:31', '2026-07-15 23:53:39', 'selesai', 0, NULL, '2026-07-15 23:11:31', '2026-07-15 23:11:31'),
(2, 1, 2, '2026-07-16 00:05:34', '2026-07-16 00:11:30', 'selesai', 3, NULL, '2026-07-16 00:01:58', '2026-07-16 00:01:58');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `hasil_jawaban_pesertas`
--

CREATE TABLE `hasil_jawaban_pesertas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` bigint(20) UNSIGNED NOT NULL,
  `peserta_id` bigint(20) UNSIGNED NOT NULL,
  `soal_id` bigint(20) UNSIGNED NOT NULL,
  `jawaban_soal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `jawaban_esai` longtext DEFAULT NULL,
  `is_benar` tinyint(1) DEFAULT NULL,
  `nilai_manual` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `hasil_jawaban_pesertas`
--

INSERT INTO `hasil_jawaban_pesertas` (`id`, `event_id`, `peserta_id`, `soal_id`, `jawaban_soal_id`, `jawaban_esai`, `is_benar`, `nilai_manual`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, 10, NULL, 1, NULL, '2026-07-16 00:11:30', '2026-07-16 00:11:30'),
(2, 1, 2, 2, 16, NULL, 0, NULL, '2026-07-16 00:11:30', '2026-07-16 00:11:30'),
(3, 1, 2, 4, 8, NULL, 1, NULL, '2026-07-16 00:11:30', '2026-07-16 00:11:30'),
(4, 1, 2, 8, 34, NULL, 1, NULL, '2026-07-16 00:11:30', '2026-07-16 00:11:30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jawaban_soals`
--

CREATE TABLE `jawaban_soals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `soal_id` bigint(20) UNSIGNED NOT NULL,
  `jawaban` text DEFAULT NULL,
  `gambar_jawaban` varchar(255) DEFAULT NULL,
  `nilai` tinyint(1) NOT NULL DEFAULT 0,
  `urutan` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jawaban_soals`
--

INSERT INTO `jawaban_soals` (`id`, `soal_id`, `jawaban`, `gambar_jawaban`, `nilai`, `urutan`, `created_at`, `updated_at`) VALUES
(8, 4, 'pkl', NULL, 1, 0, '2026-07-16 00:09:29', '2026-07-16 00:09:29'),
(9, 4, 'gehu', NULL, 0, 0, '2026-07-16 00:09:29', '2026-07-16 00:09:29'),
(10, 1, 'Kesehatan, Keselamatan Kerja, dan Lingkungan Hidup', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(11, 1, 'Kebijakan Keselamatan Kerja dan Lindungan Hukum', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(12, 1, 'Kerja, Keamanan, Ketertiban, dan Lingkungan', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(13, 1, 'Kesejahteraan Karyawan dan Lingkungan Hidup', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(14, 2, 'Melindungi pekerja dari risiko bahaya di tempat kerja', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(15, 2, 'Meningkatkan produktivitas kerja', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(16, 2, 'Mempercepat proses produksi', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(17, 2, 'Mengurangi biaya operasional', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(18, 5, 'Putih', NULL, 0, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(19, 5, 'Kuning', NULL, 1, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(20, 5, 'Biru', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(21, 5, 'Merah', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(22, 6, 'Segera padamkan dengan APAR jika memungkinkan dan aman', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(23, 6, 'Membiarkannya dan melanjutkan pekerjaan', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(24, 6, 'Merekam video kejadian', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(25, 6, 'Menunggu instruksi atasan tanpa tindakan', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(26, 7, 'Peringatan bahaya umum', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(27, 7, 'Larangan merokok', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(28, 7, 'Wajib memakai APD', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(29, 7, 'Jalur evakuasi', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(30, 3, 'Identifikasi bahaya (hazard identification)', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(31, 3, 'Transfer risiko ke pihak asuransi', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(32, 3, 'Membuat laporan akhir tahun', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(33, 3, 'Menghentikan seluruh proses produksi', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(34, 8, 'Kombinasi antara kemungkinan (likelihood) dan dampak (impact) suatu kejadian', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(35, 8, 'Kejadian yang pasti terjadi', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(36, 8, 'Biaya operasional perusahaan', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(37, 8, 'Jumlah karyawan yang terlibat proyek', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(38, 9, 'Eliminasi (menghilangkan sumber bahaya)', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(39, 9, 'Alat Pelindung Diri (APD)', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(40, 9, 'Administratif (SOP/pelatihan)', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(41, 9, 'Substitusi', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(42, 10, 'Terakhir/paling bawah dalam hierarki pengendalian', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(43, 10, 'Pertama/paling utama', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(44, 10, 'Satu-satunya metode yang diperlukan', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(45, 10, 'Tidak termasuk hierarki pengendalian', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(46, 11, 'Memeriksa kondisi mesin dan memastikan APD terpasang', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(47, 11, 'Langsung menyalakan mesin', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(48, 11, 'Menghubungi supplier mesin', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(49, 11, 'Mencatat jam kerja', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(50, 12, 'Isolasi area, gunakan APD sesuai SDS, dan laporkan ke petugas K3', NULL, 1, 1, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(51, 12, 'Membersihkan dengan tangan kosong', NULL, 0, 2, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(52, 12, 'Membiarkan sampai mengering sendiri', NULL, 0, 3, '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(53, 12, 'Menutup dengan kain tanpa pelaporan', NULL, 0, 4, '2026-07-16 00:10:08', '2026-07-16 00:10:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_titles`
--

CREATE TABLE `job_titles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_jobtitle` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `job_titles`
--

INSERT INTO `job_titles` (`id`, `nama_jobtitle`, `created_at`, `updated_at`) VALUES
(1, 'Staff K3LH', '2026-07-15 23:11:31', '2026-07-15 23:11:31'),
(2, 'Teknisi Produksi', '2026-07-16 00:10:08', '2026-07-16 00:10:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kata_pengantars`
--

CREATE TABLE `kata_pengantars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tipe_soal_id` bigint(20) UNSIGNED NOT NULL,
  `deskripsi` longtext NOT NULL,
  `status` enum('draft','publish') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kata_pengantars`
--

INSERT INTO `kata_pengantars` (`id`, `tipe_soal_id`, `deskripsi`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '<p>Jawablah seluruh pertanyaan berikut dengan jujur dan teliti.</p>', 'publish', '2026-07-15 23:11:31', '2026-07-15 23:11:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_01_01_000001_add_role_to_users_table', 1),
(5, '2026_01_01_000002_create_job_titles_table', 1),
(6, '2026_01_01_000003_create_tipe_soals_table', 1),
(7, '2026_01_01_000004_create_kata_pengantars_table', 1),
(8, '2026_01_01_000005_create_events_table', 1),
(9, '2026_01_01_000006_create_pesertas_table', 1),
(10, '2026_01_01_000007_create_event_peserta_table', 1),
(11, '2026_01_01_000008_create_soals_table', 1),
(12, '2026_01_01_000009_create_jawaban_soals_table', 1),
(13, '2026_01_01_000010_create_hasil_jawaban_pesertas_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesertas`
--

CREATE TABLE `pesertas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nik` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `organisasi` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `job_title_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pesertas`
--

INSERT INTO `pesertas` (`id`, `nik`, `nama`, `organisasi`, `email`, `job_title_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '3201010101010001', 'Budi Santoso', 'PT Dirgantara Indonesia', 'budi.santoso@dirgantara-indonesia.com', 1, 2, '2026-07-15 23:11:31', '2026-07-15 23:11:31'),
(2, '22222', 'Bagas', 'PT', 'bagas@example.com', 1, 3, '2026-07-15 23:59:18', '2026-07-15 23:59:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('zqu2VPUeEMDO9cp9RXkhVL9Q2WxhrnthwyECPgxA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiRE5BWWJ6cVkwSHVPeVM3eWlYZzluNkx3YlFydnR1VkVaSmcyOWM3MSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9oYXNpbC10ZXN0cyI7czo1OiJyb3V0ZSI7czo0MjoiZmlsYW1lbnQuYWRtaW4ucmVzb3VyY2VzLmhhc2lsLXRlc3RzLmluZGV4Ijt9czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjgwZDQwMmMxYjQ3NDlkMmQ0NWRjNTBkOTkzYjU0NzdlNmJhNmQ1ODBiOGExNmFmN2NhYWFjZTY4MzRmZDc4MzMiO30=', 1784185938);

-- --------------------------------------------------------

--
-- Struktur dari tabel `soals`
--

CREATE TABLE `soals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_title_id` bigint(20) UNSIGNED NOT NULL,
  `tipe_soal_id` bigint(20) UNSIGNED NOT NULL,
  `kode_soal` varchar(255) NOT NULL,
  `pertanyaan` text NOT NULL,
  `gambar_pertanyaan` varchar(255) DEFAULT NULL,
  `kategori` varchar(255) DEFAULT NULL,
  `status` enum('draft','publish') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `soals`
--

INSERT INTO `soals` (`id`, `job_title_id`, `tipe_soal_id`, `kode_soal`, `pertanyaan`, `gambar_pertanyaan`, `kategori`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '001A', 'Apa singkatan dari K3LH?', NULL, 'K3LH', 'publish', '2026-07-15 23:24:44', '2026-07-16 00:10:26'),
(2, 1, 1, '001B', 'Apa fungsi utama Alat Pelindung Diri (APD)?', NULL, 'K3LH', 'publish', '2026-07-15 23:24:45', '2026-07-16 00:10:39'),
(3, 1, 1, '002A', 'Langkah pertama dalam proses manajemen risiko adalah?', NULL, 'Risk Management', 'draft', '2026-07-15 23:24:45', '2026-07-16 00:10:08'),
(4, 1, 1, '00000', 'apa kepanjangan pkl', NULL, 'K3LH', 'publish', '2026-07-16 00:09:29', '2026-07-16 00:09:29'),
(5, 1, 1, '001C', 'Warna helm proyek yang umum dipakai untuk mandor/supervisor adalah?', NULL, 'K3LH', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(6, 1, 1, '001D', 'Apa yang harus dilakukan pertama kali saat menemukan kebakaran kecil di area kerja?', NULL, 'K3LH', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(7, 1, 1, '001E', 'Simbol segitiga kuning dengan tanda seru pada rambu K3 menandakan?', NULL, 'K3LH', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(8, 1, 1, '002B', 'Yang dimaksud dengan \'risiko\' dalam manajemen risiko adalah?', NULL, 'Risk Management', 'publish', '2026-07-16 00:10:08', '2026-07-16 00:10:52'),
(9, 1, 1, '002C', 'Metode hierarki pengendalian risiko yang paling efektif adalah?', NULL, 'Risk Management', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(10, 1, 1, '002D', 'APD merupakan pengendalian risiko pada level?', NULL, 'Risk Management', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(11, 2, 1, '003A', 'Sebelum mengoperasikan mesin produksi, hal pertama yang wajib dilakukan adalah?', NULL, 'K3LH', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08'),
(12, 2, 1, '003B', 'Apa yang harus dilakukan jika terjadi tumpahan bahan kimia di area kerja?', NULL, 'K3LH', 'draft', '2026-07-16 00:10:08', '2026-07-16 00:10:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tipe_soals`
--

CREATE TABLE `tipe_soals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `tipe_soals`
--

INSERT INTO `tipe_soals` (`id`, `kode`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'pg', 'Pilihan Ganda', '2026-07-15 23:11:31', '2026-07-15 23:11:31'),
(2, 'esai', 'Esai', '2026-07-15 23:11:31', '2026-07-15 23:11:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('admin','peserta') NOT NULL DEFAULT 'peserta',
  `sso_id` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `sso_id`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin Portal Test', 'admin@dirgantara-indonesia.com', 'admin', NULL, NULL, '$2y$12$4iYkCXWll2a8jGqZm0sby.va3pxZI3Hu/brY72PJuZwxf9lCVxsZa', NULL, '2026-07-15 23:11:31', '2026-07-15 23:11:31'),
(2, 'Budi Santoso', 'budi.santoso@dirgantara-indonesia.com', 'peserta', NULL, NULL, '$2y$12$AxgkfsxX.mN4oVvvZ/DQMOerMOhrkqHBImYzmIdPD629tGAyg87Mm', NULL, '2026-07-15 23:11:31', '2026-07-15 23:11:31'),
(3, 'Bagas', 'bagas@example.com', 'peserta', NULL, NULL, '$2y$12$Ue0d0rlx3k04wTyZtzMmU.I8Xs.4s.C8Tl9AOAKkeCk/f.lqtArEe', NULL, '2026-07-15 23:59:38', '2026-07-15 23:59:38');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `events_kode_event_unique` (`kode_event`);

--
-- Indeks untuk tabel `event_peserta`
--
ALTER TABLE `event_peserta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `event_peserta_event_id_peserta_id_unique` (`event_id`,`peserta_id`),
  ADD KEY `event_peserta_peserta_id_foreign` (`peserta_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `hasil_jawaban_pesertas`
--
ALTER TABLE `hasil_jawaban_pesertas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hasil_jawaban_pesertas_event_id_peserta_id_soal_id_unique` (`event_id`,`peserta_id`,`soal_id`),
  ADD KEY `hasil_jawaban_pesertas_peserta_id_foreign` (`peserta_id`),
  ADD KEY `hasil_jawaban_pesertas_soal_id_foreign` (`soal_id`),
  ADD KEY `hasil_jawaban_pesertas_jawaban_soal_id_foreign` (`jawaban_soal_id`);

--
-- Indeks untuk tabel `jawaban_soals`
--
ALTER TABLE `jawaban_soals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jawaban_soals_soal_id_foreign` (`soal_id`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `job_titles`
--
ALTER TABLE `job_titles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kata_pengantars`
--
ALTER TABLE `kata_pengantars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kata_pengantars_tipe_soal_id_foreign` (`tipe_soal_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `pesertas`
--
ALTER TABLE `pesertas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pesertas_nik_unique` (`nik`),
  ADD UNIQUE KEY `pesertas_email_unique` (`email`),
  ADD KEY `pesertas_job_title_id_foreign` (`job_title_id`),
  ADD KEY `pesertas_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `soals`
--
ALTER TABLE `soals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `soals_job_title_id_foreign` (`job_title_id`),
  ADD KEY `soals_tipe_soal_id_foreign` (`tipe_soal_id`);

--
-- Indeks untuk tabel `tipe_soals`
--
ALTER TABLE `tipe_soals`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `event_peserta`
--
ALTER TABLE `event_peserta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `hasil_jawaban_pesertas`
--
ALTER TABLE `hasil_jawaban_pesertas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `jawaban_soals`
--
ALTER TABLE `jawaban_soals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `job_titles`
--
ALTER TABLE `job_titles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `kata_pengantars`
--
ALTER TABLE `kata_pengantars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `pesertas`
--
ALTER TABLE `pesertas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `soals`
--
ALTER TABLE `soals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `tipe_soals`
--
ALTER TABLE `tipe_soals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `event_peserta`
--
ALTER TABLE `event_peserta`
  ADD CONSTRAINT `event_peserta_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_peserta_peserta_id_foreign` FOREIGN KEY (`peserta_id`) REFERENCES `pesertas` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `hasil_jawaban_pesertas`
--
ALTER TABLE `hasil_jawaban_pesertas`
  ADD CONSTRAINT `hasil_jawaban_pesertas_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hasil_jawaban_pesertas_jawaban_soal_id_foreign` FOREIGN KEY (`jawaban_soal_id`) REFERENCES `jawaban_soals` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hasil_jawaban_pesertas_peserta_id_foreign` FOREIGN KEY (`peserta_id`) REFERENCES `pesertas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hasil_jawaban_pesertas_soal_id_foreign` FOREIGN KEY (`soal_id`) REFERENCES `soals` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `jawaban_soals`
--
ALTER TABLE `jawaban_soals`
  ADD CONSTRAINT `jawaban_soals_soal_id_foreign` FOREIGN KEY (`soal_id`) REFERENCES `soals` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kata_pengantars`
--
ALTER TABLE `kata_pengantars`
  ADD CONSTRAINT `kata_pengantars_tipe_soal_id_foreign` FOREIGN KEY (`tipe_soal_id`) REFERENCES `tipe_soals` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pesertas`
--
ALTER TABLE `pesertas`
  ADD CONSTRAINT `pesertas_job_title_id_foreign` FOREIGN KEY (`job_title_id`) REFERENCES `job_titles` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `pesertas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `soals`
--
ALTER TABLE `soals`
  ADD CONSTRAINT `soals_job_title_id_foreign` FOREIGN KEY (`job_title_id`) REFERENCES `job_titles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `soals_tipe_soal_id_foreign` FOREIGN KEY (`tipe_soal_id`) REFERENCES `tipe_soals` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
