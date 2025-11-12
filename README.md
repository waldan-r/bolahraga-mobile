# bolahraga





Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements
1. Navigator.push() adalah method untuk menambahkan suatu route ke dalam 'stack route' pada Navigator sehingga route yang di-push ini akan berada pada paling atas stack dan muncul kepada pengguna. Navigator.pushReplacement() adalah method untuk menggantikan posisi route teratas pada stack dengan route yang baru ditambahkan sehingga route teratas sebelumnya akan terhapus dan route baru muncul, ditampilkan kepada pengguna. Pergantian ini tidak mengubah kondisi route lain di bawah route teratas sebelumnya pada stack. Implementasi pada tugas kali ini adalah ketika user menekan create product (pada card di menu), route baru mengarah pada ProductFormPage() yang kemudian ditampilkan (Navigation.push()). Untuk Navigation.pushReplacement() ini cocok untuk mengganti stack route teratas apabila kita sedang mengakses fitur lain yang sejajar, misal pada drawer sehingga apabila kita melakukan navigasi balik (pop), ini tidak akan memunculkan route pada fitur sebelumnya.

2. Pada dasarnya, hampir semua bagian kerangka halaman dalam dart didefinisikan sebagai objek widget masing-masing. Secara hierarkis, kita bisa bentuk widget scaffold yang terdiri atas widget lain seperti appbar dan drawer untuk membentuk pola yang rapi. Drawer pada tugas ini menggunakan LeftDrawer() yang akan membentuk struktur widget yang dapat ditampilkan/disembunyikan dari kiri halaman. untuk seluruh halaman yang memanggil/mengimplementasikan halaman dengan scaffold, maka akan ada leftDrawer sehingga setiap halaman memilki desain struktur yang konsisten.

3. Padding merupakan layout widget yang berguna untuk memberikan jarak antar elemen agar terlihat rapi dan tidak berdempetan. Biasanya ini dipakai ketika elemen disejajarkan dalam baris ataupun kolom (seperti menampilkan card, form, dll). SingleChildScrollView memberikan kemudahan untuk melihat konten yang melebihi available space yang diberikan dengan cara scrolling. ListView juga kurang lebih sama tetapi biasanya digunakan pada scrollable list yang disusun secara vertikal (defaultnya).

4. Pada tugas sebelumnya, di main.dart terdapat pendefinisian tema utama yang akan diaplikasikan ke seluruh aplikasi yang berisikan skema warna sehingga untuk setiap halaman akan menggunakan tema warna yang sesuai.


Tugas 7: Elemen Dasar Flutter
1. Widget tree adalah struktur kerangka pada flutter yang berupa rangkaian sebuah widget dalam widget dalam widget yang memiliki hubungan induk-anak. Polanya mungkin agak sama seperti div div pada html namun pada widget ini, atribut child itu biasanya diperlukan sebagai struktur pembangun widget parentnya. 

2. widget MaterialApp berfungsi sebagai sebuah wadah utama untuk beberapa fungsionaltias seperti management navigasi, penyesuaian tema warna, integrasi desain material, dan sebagai pembungkus widget keseluruhan karena MaterialApp pada dasarnya bisa dikatakan sebagai root widget.

3. Stateful widget adalah widget-widget pada flutter yang dinamis dan dapat berubah sesuai dengan interaksi yang terjadi dengan user maupun perubahan data. stateful widget ditandai dengan method setState() yang akan memberikan informasi perubahan state yang akan men-trigger perubahan widget sesuai dengan state baru. Pada tugas ini contohnya adalah widget seperti textField, Scaffold, dan lainnya yang bisa menampilkan perubahan saat ditekan mendapatkan interaksi user. Stateless widget sebaliknya, adalah widget yang tidak dibentuk dari state yang mutable sehingga atribut tidak akan berubah kecuali dibuat ulang dengan data baru. Stateless widget ini idealnya digunakan untuk menampilkan static content yang mungkin tidak perlu berubah ketika ada interaksi pengguna atau perubahan data. Contohnya seperti widget text, icon, image, dan sebagainya.

4. BuildContext adalah sebuah objek yang bisa memberikan context yang sedang terjadi (state) pada sebuah objek. Biasanya ini digunakan sebagai bentuk perantara interaksi GET/POST dengan parents widget. Sebuah method build() yang menerima object BuildContext akan meneruskan suatu state yang di-assign sehingga dapat diteruskan ke child tanpa harus membuat ulang pada tiap konfigurasi widget sehingga context tersebut dapat diakses di mana aja (selama masih meng-inherit objek tersebut).

5. Hot reload adalah sistem untuk melakukan perubahan (refreshment) instant pada logic dan UI tanpa mengubah state yang berhubungan. Bedanya dengan hot restart adalah hot restart akan melakukan perubahan tetapi akan menghapus state yang ada pada app dan kode akan dikompilasi ulang dari awal dengan state default. Keduanya sebenarnya tetap memberikan efisiensi dan kemudahan dibandingkan melakukan full restart function.