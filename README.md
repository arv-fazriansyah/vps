Dari output `df -h` yang Anda berikan, tampaknya Anda memiliki ruang kosong yang tersedia di partisi `/dev/vdb`, yang memiliki kapasitas total 12GB dan hanya digunakan sekitar 417MB. Karena Anda memiliki ruang yang cukup di partisi tersebut, Anda bisa membuat file swap di sana.

Berikut langkah-langkahnya:

1. **Buat File Swap**:
   Anda dapat membuat file swap dengan perintah berikut:
   ```
   sudo fallocate -l 1G /swapfile
   ```

   Ini akan membuat file bernama `/swapfile` dengan ukuran 1GB. Jika Anda ingin membuat file swap dengan ukuran yang berbeda, gantilah `1G` sesuai kebutuhan.

2. **Ubah Hak Akses File Swap**:
   Agar hanya bisa dibaca dan ditulis oleh pengguna root, jalankan perintah berikut:
   ```
   sudo chmod 600 /swapfile
   ```

3. **Aktifkan Swap**:
   Sekarang, Anda harus mengaktifkan swap pada file yang telah Anda buat dengan perintah:
   ```
   sudo mkswap /swapfile
   ```

4. **Gunakan Swap**:
   Terakhir, gunakan file swap tersebut dengan perintah:
   ```
   sudo swapon /swapfile
   ```

5. **Setel Pengaturan Permanent**:
   Agar swap space aktif setiap kali sistem di-boot, tambahkan baris berikut ke dalam file `/etc/fstab`:
   ```
   echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
   ```

Setelah langkah-langkah ini, swap space akan aktif dan digunakan oleh sistem Ubuntu Anda. Pastikan untuk memantau penggunaan swap space dan kapasitas disk secara berkala, terutama jika penggunaan swap space terus meningkat, ini bisa menjadi indikasi bahwa kapasitas RAM fisik mungkin perlu ditingkatkan.
