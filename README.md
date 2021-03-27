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
Pada soal ini kita diminta untuk mengambil beberapa informasi, yaitu jenis log, pesan log, dan username untuk setiap baris lognya. Jika kita melihat pola pada `syslog.log`, maka dapat disimpulkan pola pada **ERROR** adalah `ERROR <log_error> (<username>)` dan pola pada **INFO** adalah `INFO <log_info> (<username>)`. Huruf **E** dapat menjadi penanda bahwa jenis log nya adalah **ERROR** dan huruf **I** dapat menjadi penanda bahwa jenis log nya adalah **INFO**. Maka lakukan `grep` pada `syslog.log` dengan karakter pertama **I atau E** dan dilanjutkan dengan semua karakter yang mengikutinya.

```bash
grep -o '[I|E].*' syslog.log
```

#
### Jawab 1b
Kita diminta untuk menampilkan semua pesan error yang muncul beserta jumlah kemunculannya. Maka dapat dilakukan seperti soal **1a**, yaitu `grep` pada `syslog.log` dengan karakter pertama **E** dan dilanjutkan dengan semua karakter yang mengikutinya. Untuk menampilkan jumlah kemunculannya, pertama-tama kita harus memotong bagian **username** sehingga jumlah kemunculan dapat dihitung dari kesamaan **log_message**. Potong hasil `grep` yang tadi dengan delimiter `(` dan buang semua karakter di belakangnya. Lakukan sort dan dilanjutkan `uniq -c` untuk menampilkan jumlah kemunculan tiap tipe error.

```bash
grep -o 'E.*' syslog.log | cut -d"(" -f 1 | sort | uniq -c
```

#
### Jawab 1c
Kita diminta untuk menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap *user*-nya. Maka dapat dilakukan seperti soal **1b**, yaitu `grep` pada `syslog.log` dengan karakter pertama **E** untuk log `ERROR` dan **I** untuk log `INFO`, lalu dilanjutkan dengan semua karakter yang mengikutinya. Untuk menampilkan jumlah kemunculan maka kita memerlukan **username** dari pemilik log tersebut. Potong `grep` yang tadi dengan delimiter `(` dan buang semua karakter di depannya. Potong juga dengan delimiter `)` dan buang semua karakter di belakangnya. Lakukan sort dan dilanjutkan `uniq -c` untuk menampilkan jumlah kemunculan log `ERROR` dan `INFO` untuk setiap *user*-nya. `echo` disini hanya sebagai penjelas log mana yang merupakan `ERROR` atau `INFO`.

```bash
echo "Error"
grep -o 'E.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c
echo "Info"
grep -o 'I.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c
```

#
### Jawab 1d
Kita diminta untuk menuliskan semua informasi yang didapatkan pada soal **1b** ke dalam file `error_message.csv` sesuai format yang diminta dan **diurutkan** berdasarkan jumlah kemunculan pesan error dari yang terbanyak. Lakukan `grep` seperti pada soal **1b** dengan tambahan perintah `sort -nr` untuk mengurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak. Masukkan hasil grep ke dalam variable array bernama error.

```bash
error=($(grep -o 'E.*' syslog.log | cut --complement -d" " -f 1 | cut -d"(" -f 1 | sort | uniq -c |sort -nr))
```

Lakukan iterasi pada semua kata di error. Variable idx berguna sebagai index untuk memilah pesan error. Jika kata ke-i yang memuat angka maka dimasukkan ke array angka sebagai kumpulan frekuensi banyaknya error. Sedangkan jika kata ke-i tidak memuat angka, maka cek kata ke-(i+1). Jika kata ke-(i+1) memuat angka, maka concat kata ke-i ke array kata sebagai kumpulan log error dan increment idx. Cek juga apakah i telah mencapai akhir dari array error. Jika belum, maka concat kata ke-i ditambahkan dengan spasi dikarenakan masih dalam 1 jenis error yang sama.

```bash
idx=0

for i in ${!error[@]}
do
	if [[ "${error[$i]}" =~ ^[0-9] ]]
	then
		angka[$idx]="${error[$i]}"
	elif [[ "${error[$i+1]}" =~ ^[0-9] ]]
	then
		kata[$idx]+="${error[$i]}"
		idx=$idx+1
	elif (($i+1 == ${#error[@]}))
	then
		kata[$idx]+="${error[$i]}"
	else
		kata[$idx]+="${error[$i]} "
	fi
done
```

Buat file `error_message.csv` dan masukkan header `Error,Count` kemudian iterasi sebanyak isi array angka. Masukkan pesan error dan jumlah kemunculannya sesuai format yang diminta.

```bash
printf "Error,Count\n" > "error_message.csv"
for i in ${!angka[@]}
do
	word="${kata[$i]}"
	number="${angka[$i]}"
	printf "%s,%d\n" "${kata[$i]}" "${angka[$i]}" >> "error_message.csv"
done
```

#
### Jawab 1e

Kita diminta untuk menuliskan semua informasi yang didapatkan pada soal **1c** ke dalam file `user_statistic.csv` sesuai format yang diminta dan **diurutkan** berdasarkan username secara **ascending**. Lakukan `grep` seperti pada soal **1c**. Hasil `grep` sudah sekaligus mengurutkan username karena ada perintah `sort`. Masukkan hasil grep ke dalam variable array bernama error dan info.

```bash
error=($(grep -o 'E.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c))
info=($(grep -o 'I.*' syslog.log | cut --complement -d"(" -f 1 | cut -d")" -f 1 | sort | uniq -c))
```

Gunakan idxe sebagai index array error dan idxi sebagai index array info. Buat file `user_statistic.csv` dan masukkan header `Username,INFO,ERROR` kemudian iterasi array error dan info bersamaan berdasarkan idxe dan idxi. Selama idxe belum menyentuh akhir array error, maka cek pada 3 kasus:

1. `error ke-(idxe+1) < info ke-(idxi+1)` yang berarti nama yang ada di error tidak terdapat di info sehingga info=0. Masukkan ke file csv lalu geser idxe. Hal ini juga berlaku saat idxi telah menyentuh akhir array info sehingga sudah tidak ada lagi info yang dapat dimasukkan.
2. `error ke-(idxe+1) == info ke-(idxi+1)` yang berarti nama yang ada di error juga terdapat di info. Masukkan ke file csv lalu geser idxe dan idxi.
3. `error ke-(idxe+1) > info ke-(idxi+1)` yang berarti nama yang ada di info tidak terdapat di error sehingga error=0. Masukkan ke file csv lalu geser idxe dan idxi.

```bash
idxe=0
idxi=0

printf "Username,INFO,ERROR\n" > "user_statistic.csv"
while (( $idxe < ${#error[@]} ))
do
	if [[ "${error[$idxe+1]}" < "${info[$idxi+1]}" || $idxi -eq ${#info[@]} ]]
	then
		printf "${error[$idxe+1]},0,${error[$idxe]}\n" >> "user_statistic.csv"
		idxe=$idxe+2
	elif [[ "${error[$idxe+1]}" == "${info[$idxi+1]}" ]]
	then
		printf "${error[$idxe+1]},${info[$idxi]},${error[$idxe]}\n" >> "user_statistic.csv"
		idxe=$idxe+2
		idxi=$idxi+2
	else
		printf "${info[$idxi+1]},${info[$idxi]},0}\n" >> "user_statistic.csv"
		idxe=$idxe+2
		idxi=$idxi+2
	fi
done
```

Terakhir, jika idxe telah menyentuh akhir array error dan idxi belum menyentuh akhir array info. Maka iterasi semua isi array info dan masukkan ke file csv dengan error=0.

```bash
while (( $idxi < ${#info[@]} ))
do
	printf "${info[$idxi+1]},${info[$idxi]},0}\n" >> "user_statistic.csv"
	idxi=$idxi+2
done
```

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
Pada soal ini kita diminta untuk menampilkan informasi berupa **Row ID** dan **profit percentage terbesar**. Hal yang pertama dilakukan yakni dengan menggunakan awk digunakan :
-F "\t" yang artinya kita mendifinisikan "  " sebagai field separator dari file yang diolah.
```bash
awk -F"\t" '
```
Lalu pada BEGIN kita inisialisasi variabel max_profit yang nanti akan digunakan sebagai pembanding dan akan ditampilkan di akhir sesi
```bash
BEGIN {max_profit=0;}
```
Selanjutnya pada bagian utama kita akan membuat variabel baru temp_profit untuk menghitung persentase profit sementara dengan rumus yang ada. Jika profit yang ada pada max_profit sama dengan yang ada pada temp_profit maka kita hanya perlu mengganti **Row ID** nya saja karena yang ditampilkan nanti hanya satu tampilan data dengan **profit percentage terbesar** pada transaksi terakhir. Namun jika nilai profit yang ada pada max_profit lebih kecil daripada temp_profit maka perlu adanya penggantian pada **Row ID** dan **profit percentage terbesar**.
```bash
{
	temp_profit = ($21/($18-$21))*100;
	if(max_profit == temp_profit){
		if(max_row_id < $1){
			max_row_id = $1;
			max_order_id = $2;
		}
	}
	if(max_profit < temp_profit){
		max_profit = temp_profit;
		max_row_id = $1;
		max_order_id = $2;
	}
}
```
Untuk langkah terakhir yaitu menampilkan **Row ID** dan **profit percentage terbesar** pada transaksi terakhir dari hasil operasi yang telah dilakukan sebelumnya  lalu memasukkannya pada file dengan nama ```hasil.txt```.
```bash
END {printf("Transaksi terakhir dengan profit percentage terbesar yaitu %s dengan persentase %.2f%%.\n\n",max_order_id,max_profit);}
' Laporan-TokoShiSop.tsv > hasil.txt
```

#
### Jawab 2b
Pada soal ini kita diminta untuk menampilkan daftar nama customer di Albuquerque pada tahun 2017, maka hal pertama yang dilakukan dengan awk sama seperti sebelumnya menggunakan -F "\t" sebagai separator dan pada BEGIN terdapat variabel idx yang nantinya akan digunakan sebagai index.
```bash
awk -F"\t" '
BEGIN {idx=0;}
```
Lalu dengan tanda /2017/ sebagai penyeleksi bahwa data yang digunakan hanya yang mengandung '2017'. Jika pada kolom 'city' mengandung kata 'Albuquerque' dan tidak ada nama yang sama pada kolom 'Customer Name' maka nama customer akan disimpan kedalam array.
```bash
/2017/ {
	if($10 == "Albuquerque" && !kembar[$7]){
		customer[idx] = $7;
		idx++;
		kembar[$7] = 1;
	}
}
```
Langkah terakhir yaitu dengan menampilkan daftar customer yang ada pada array lalu memasukkannya pada file dengan nama ```hasil.txt```.
```bash
END {
	printf("Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n");
	for(i in customer) printf("%s\n",customer[i]);
	printf("\n");
}
' Laporan-TokoShiSop.tsv >> hasil.txt
```

#
### Jawab 2c
Pada soal ini kita diminta untuk menampilkan **segment customer** dan **jumlah transaksinya yang paling sedikit**. Seperti biasa kita akan menggunakan awk dengan pendefinisian pada BEGIN yaitu variabel 'hom' sebagai Home Office, 'con' untuk Consumer, dan 'cor' untuk Corporate.
```bash
awk -F"\t" '
BEGIN {hom=0; con=0; cor=0;}
```
Selanjutnya untuk data yang akan ditampilkan hanya data yang mengandung kata 'Home Office', 'Consumer' atau 'Corporate' dan akan dihitung jumlah tiap segmennya.
```bash
/Home Office/ {hom++}
/Consumer/ {con++}
/Corporate/ {cor++}
```
Langkah terakhir yaitu dengan menampilkan segmen mana yang jumlah transaksinya paling sedikit dengan membandingkan jumlah tiap segmennya lalu memasukkannya pada file dengan nama ```hasil.txt```.
```bash
END {
	printf("Tipe segmen customer yang penjualannya paling sedikit adalah ");
	if(hom < con && hom < cor) printf("Home Office dengan %d transaksi.",hom);
	if(con < hom && con < cor) printf("Consumer dengan %d transaksi.",con);
	if(cor < hom && cor < con) printf("Corporate dengan %d transaksi.",cor);
	printf("\n\n");
}
' Laporan-TokoShiSop.tsv >> hasil.txt
```

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
pada soal ini kita diminta untuk mengunduh 23 gambar dari sebuah website dan menyimpan log nya ke dalam file yg sudah dinamakan Foto.log,untuk melakukan hal tersebut kita memasukan

```max_kitten=23;

for ((i=1; i<=$max_kitten; ))
```

lalu kita memastikan tidak ada penamaan file yang double seperti koleksi_12 dan koleksi_012 sekaligus kita mendownload menggunakan `wget`,untuk melakukan hal tersebut kita memasukan

```do
	if [ $i -le 9 ]
		then
		wget -O $curdir/Koleksi_0$i.jpg --append-output=$curdir/Foto.log https://loremflickr.com/320/240/kitten
	else
		wget -O $curdir/Koleksi_$i.jpg --append-output=$curdir/Foto.log https://loremflickr.com/320/240/kitten
	fi	
```

setelah itu kita mengecek setiap gambar yang telah di unduh memiliki kesamaan atau tidak dalam variable flag,ketika ada kesamaan maka gambar tersebut akan dilanjutkan ke code yang akan menghapus file tersebut

```flag=0
location=($(awk '/Location/ {print $2}' $curdir/Foto.log))
	for ((j=0; j<${#location[@]}-1; j++))
		do
		if [ "${location[$j]}" == "${location[${#location[@]}-1]}" ]
		then
		flag=1
		break
```


pada code dibawah berisikan code yang mengecek setiap bagian foto yang memiliki gambar yang sama lalu menghapusnya dan mengurangi slot dari 23 foto yang harus dimasukan,jika gambar tidak sama maka akan menambah gambar yang diunduh

```if [ $flag -eq 0 ]
	then
		i=$(($i+1))
	elif [ $i -le 9 ]
		then
			rm $curdir/Koleksi_0$i.jpg
			max_kitten=$(($max_kitten-1))
		else
		rm $curdir/Koleksi_$i.jpg
		max_kitten=$(($max_kitten-1))
```

untuk gambar gambar tersebut yang telah didownload kita mengganti namanya menjadi koleksi_xx dengan nomor yang berurut.

#
### Jawab 3b
pada soal ini kita diminta untuk melakukan script yang dijalankan pada soal a tetapi dengan penambahan kita diharuskan untuk melakukan pemindahan file tersebut kedalam folder yang bernama tanggal ketika kita mendownload file koleksi tersebut.lalu kita melakukan pendownloadan otomatis pada waktu waktu yang telah ditentukan,untuk melakukan hal tersebut kita memulai dengan:
```
curdir=`pwd`
bash $curdir/soal3a.sh
```
kode diatas digunakan untuk menjalankan program pada soal3a,lalu kita membuat folder yang bernamakan tanggal pada hari itu menggunakan perintah ```mkdir``` :
```
tanggal=$(date +"%d-%m-%Y")
 mkdir "$tanggal"
```
lalu kita memindahkan file yang sudah didownload beserta log yang sudah disimpan di```foto.log``` kedalam folder yang telah kita buat menggunakan tanggal dengan menggunakan perintah ```mv```:
```
mv $curdir/Foto.log "$curdir/$tanggal/"
mv $curdir/Koleksi_* "$curdir/$tanggal/"
```
untuk pendownloadan secara otomatis dengan waktu tertentu kami menggukanan ```crontab -e``` yang berisikan :
```
0 20 1-31/7,2-31/4 * * bash /home/aldo/Sisop/Modul1/soal3/soal3b.sh
```
crontah diatas bisa dibaca sebagai berikut:
```
setiap jam 20:00 malam pada hari ke 7 dari tanggal 1-31
```
dan
```
setiap jam 20:00 malam pada hari ke 4 dari tanggal 2-31
```

#
### Jawab 3c

#
### Jawab 3d
pada soal ini kita diharuskan untuk memasukan folder kelinci dan kucing yang kita buat sebelumnya untuk dimasukan kedalam folder zip menggunakan perintah ```zip -rem```,lalu folder zip tersebut dikunci dan diberikan password dengan isi berupa tanggal saat ini sehingga code tersebut seperti :
```
#!/bin/bash

tanggal=$(date +"%m%d%Y")
```
code diatas berfungsi memasukan tanggal saat ini kedalam variable tanggal untuk dimasukan ke password lalu :
```
zip -rem -P "$tanggal" Koleksi.zip Kelinci_* Kucing_*
```
kode diatas berisikan perintah seperti ```zip -rem``` yang berfungsi untuk melakukan pembuatan folder zip lalu ```-P "$tanggal"``` yang berfungsi sebagai mengisi password zip untuk menjadi tanggal yang telah diisi dengan tanggal saat ini,lalu kita mengganti nama file zip tersebut dengan nama ```koleksi.zip``` dan memasukan folder ```kelinci_* kucing_*``` .


#
### Jawab 3e
pada soal ini kita diminta untuk membuka zip yang telah kita buat pada waktu tertentu dan menghapus folder zip yang ada,hal pertama yang bisa kita lakukan adalah membuka folder zip menggunakan password denga code:
```
#!/bin/bash

tanggal=$(date +"%m%d%Y")
unzip -P "$tanggal" Koleksi.zip
```
pada code diatas kita telah membuka folder zip dengan tanggal yang sebelumnya diisi dengan tanggal saat ini,lalu kita menghapus folder zip tersebut dengan code 
```
rm koleksi.zip
```
dikarenakan pada soal kita diminta untuk membuat folder zip pada pukul 07:00 setiap hari senin sampai jumat dan melakukan unzip folder pada pukul 18:00 setiap hari senin sampai jumat maka kita bisa menggunakan ```crontab -e``` pada soal 3d dan soal 3e dengan isi:
```
#SOAL 3D
0 7 * * 1-5 bash /home/aldo/Sisop/Modul1/soal3/soal3d.sh

pada 07:00 setiap hari dalam seminggu dari senin sampai jumat
```
dan 
```
#SOAL 3E
0 18 * * 1-5 bash /home/aldo/Sisop/Modul1/soal3/soal3e.sh

pada 18:00 setiap hati dalam seminggu dari senin sampai jumat
```
