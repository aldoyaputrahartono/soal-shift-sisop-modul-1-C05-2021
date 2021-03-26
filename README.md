# soal-shift-sisop-modul-1-C05-2021

Repository Praktikum Sisop Modul 1
- 05111940000073_Aji Wahyu Admaja Utama
- 05111940000084_Aldo Yaputra Hartono
- 05111940000204_Muhammad Subhan

## Penyelesaian Soal No.1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, *ticky*. Terdapat 2 laporan yang harus dia buat, yaitu laporan **daftar peringkat pesan error** terbanyak yang dibuat oleh *ticky* dan laporan **penggunaan user** pada aplikasi *ticky*. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

**(a)** Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log (`ERROR/INFO`), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

**(b)** Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

**(c)** Ryujin juga harus dapat menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap *user*-nya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file `csv`.

**(d)** Semua informasi yang didapatkan pada poin **b** dituliskan ke dalam file `error_message.csv` dengan header `Error,Count` yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya **diurutkan** berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

Contoh :

```text
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

(e) Semua informasi yang didapatkan pada poin **c** dituliskan ke dalam file `user_statistic.csv` dengan header `Username,INFO,ERROR` **diurutkan** berdasarkan username secara **ascending**.

Contoh :

```text
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```

**Catatan** :

- Setiap baris pada file `syslog.log` mengikuti pola berikut:

```text
 <time> <hostname> <app_name>: <log_type> <log_message> (<username>)
```

- **Tidak boleh** menggunakan AWK

#
### Jawab 1a

#
### Jawab 1b

#
### Jawab 1c

#
### Jawab 1d

#
### Jawab 1e

#
## Penyelesaian Soal No.2
Steven dan Manis mendirikan sebuah *startup* bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “*Laporan-TokoShiSop.tsv*”.

**a.** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui **Row ID** dan **profit percentage terbesar** (jika hasil *profit percentage* terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari *profit percentage*, yaitu:

```text
Profit Percentage = (Profit / Cost Price) * 100
```

*Cost Price* didapatkan dari pengurangan *Sales* dengan *Profit*. (**Quantity diabaikan**).

**b.** Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar **nama *customer* pada transaksi tahun 2017 di Albuquerque.**

**c.** TokoShiSop berfokus tiga *segment customer*, antara lain: *Home Office, Customer*, dan *Corporate*. Clemong ingin meningkatkan penjualan pada segmen *customer* yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment *customer*** dan **jumlah transaksinya yang paling sedikit.**

**d.** TokoShiSop membagi wilayah bagian (*region*) penjualan menjadi empat bagian, antara lain: *Central, East, South*, dan *West*. Manis ingin mencari **wilayah bagian (region) yang memiliki total keuntungan (*profit*) paling sedikit** dan **total keuntungan wilayah tersebut.**

Agar mudah dibaca oleh Manis, Clemong, dan Steven, **(e)** kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:

```text
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```

**Catatan** :

- Gunakan bash, AWK, dan command pendukung
- Script pada poin (e) memiliki nama file ‘soal2_generate_laporan_ihir_shisop.sh’

#
### Jawab 2a

#
### Jawab 2b

#
### Jawab 2c

#
### Jawab 2d

#
### Jawab 2e

#
## Penyelesaian Soal No.3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :

**a.** Membuat script untuk **mengunduh** 23 gambar dari "https://loremflickr.com/320/240/kitten" serta **menyimpan** log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus **menghapus** gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian **menyimpan** gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan **tanpa ada nomor yang hilang** (contoh : Koleksi_01, Koleksi_02, ...)

**b.** Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut **sehari sekali pada jam 8 malam** untuk tanggal-tanggal tertentu setiap bulan, yaitu dari **tanggal 1 tujuh hari sekali** (1,8,...), serta dari **tanggal 2 empat hari sekali**(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta **log-nya, dipindahkan ke folder** dengan nama **tanggal unduhnya** dengan **format** "DD-MM-YYYY" (contoh : "13-03-2023").

**c.** Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk **mengunduh** gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara **bergantian** (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, **nama folder diberi awalan** "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

**d.** Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan **memindahkan seluruh folder ke zip** yang diberi nama “Koleksi.zip” dan **mengunci** zip tersebut dengan **password** berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

**e.** Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya **ter-zip** saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya **ter-unzip** dan **tidak ada file zip** sama sekali.

**Catatan** :
- Gunakan bash, AWK, dan command pendukung
- Tuliskan semua cron yang kalian pakai ke file cron3[b/e].tab yang sesuai

#
### Jawab 3a

#
### Jawab 3b

#
### Jawab 3c

#
### Jawab 3d

#
### Jawab 3e
