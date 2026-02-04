-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Feb 2026 pada 13.38
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
-- Database: `dbdata-obat`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bukus`
--

CREATE TABLE `bukus` (
  `idbuku` varchar(255) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `pengarang` varchar(255) NOT NULL,
  `penerbit` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2026_01_05_031123_create_obats_table', 1),
(6, '2026_01_05_032607_create_pasiens_table', 1),
(7, '2026_01_05_032828_create_bukus_table', 1),
(8, '2026_01_05_033118_create_motors_table', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `motors`
--

CREATE TABLE `motors` (
  `idmotor` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `obats`
--

CREATE TABLE `obats` (
  `idobat` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `obats`
--

INSERT INTO `obats` (`idobat`, `nama`, `stok`, `harga`, `created_at`, `updated_at`) VALUES
('001', 'Paracetamol', 10, 15000.00, '2026-02-04 07:24:10', '2026-02-04 07:24:10'),
('002', 'Paramex', 5, 8000.00, '2026-02-04 12:38:05', '2026-02-04 12:38:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasiens`
--

CREATE TABLE `pasiens` (
  `idpasien` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `umur` int(11) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'api-token', 'adbc6a977467595f5ea2787d87411da160be34a5dba83c32e5ec0ad217bda7b3', '[\"*\"]', NULL, NULL, '2026-02-04 04:01:45', '2026-02-04 04:01:45'),
(2, 'App\\Models\\User', 1, 'api-token', '5595b04622023e92f52ab45ff4c6c708e61c8e8f8bdecdf236fdb7cf011a516b', '[\"*\"]', NULL, NULL, '2026-02-04 04:07:28', '2026-02-04 04:07:28'),
(3, 'App\\Models\\User', 1, 'api-token', 'a9a3a1a6a964c71dc1447e675863a09001dc11e8c1f040bb37263cf4ddf9b2ad', '[\"*\"]', NULL, NULL, '2026-02-04 04:07:49', '2026-02-04 04:07:49'),
(4, 'App\\Models\\User', 1, 'api-token', '2d1fdb0abc62640591219944fd121a4721ec5118aa49701cdaa968332a762270', '[\"*\"]', NULL, NULL, '2026-02-04 04:33:45', '2026-02-04 04:33:45'),
(5, 'App\\Models\\User', 1, 'api-token', '0138732402ad4596bcb543b5201030883842214bb4464ecda67f9eda8373859e', '[\"*\"]', NULL, NULL, '2026-02-04 04:42:46', '2026-02-04 04:42:46'),
(6, 'App\\Models\\User', 2, 'api-token', '81c9299ec0b493ccdc6d57a6371d586400df3891696e2573cffeb5d1e2aefd80', '[\"*\"]', NULL, NULL, '2026-02-04 07:23:51', '2026-02-04 07:23:51'),
(7, 'App\\Models\\User', 1, 'api-token', 'f65c11651be4c68892c5da9160a6f99b24233d6b3c4816eb123658259b98eb22', '[\"*\"]', NULL, NULL, '2026-02-04 07:30:05', '2026-02-04 07:30:05'),
(8, 'App\\Models\\User', 1, 'api-token', 'd5082b10a6c594d7785ed85abf1cb71ba83c839bc2748fd81d8307dee0498001', '[\"*\"]', NULL, NULL, '2026-02-04 12:25:50', '2026-02-04 12:25:50'),
(9, 'App\\Models\\User', 1, 'api-token', '5c0691d6b680bcacbdb85dd688eaae8d22eb994bcc4f4d2063006b65e22b9b78', '[\"*\"]', NULL, NULL, '2026-02-04 12:37:49', '2026-02-04 12:37:49');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Bagus', 'Pejuangsejati22@gmail.com', NULL, '$2y$12$DYAPUFXwb6TP0Z/vro4Sk.fcD29u7RrlDdZq85gfI4PATTg7aB0Fi', NULL, '2026-02-04 07:22:55', '2026-02-04 07:22:55');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bukus`
--
ALTER TABLE `bukus`
  ADD PRIMARY KEY (`idbuku`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `motors`
--
ALTER TABLE `motors`
  ADD PRIMARY KEY (`idmotor`);

--
-- Indeks untuk tabel `obats`
--
ALTER TABLE `obats`
  ADD PRIMARY KEY (`idobat`);

--
-- Indeks untuk tabel `pasiens`
--
ALTER TABLE `pasiens`
  ADD PRIMARY KEY (`idpasien`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

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
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
