program cashier;
uses crt, sysUtils;

type
    item = record
        nama : string;
        harga, jumlah : real;
    end;

var 
    noSTR, jmlhSTR, jawaban, kodeMember : string;
    i, nomor, belanjaan, banyakBarang : integer;
    jumlah, total : real;
    barang : array[1..1000] of item;
    member : array[1..1000] of string;

{function hitung Total Harga}
function hitungTotal(pilihan : integer; jumlah : real) : real;
begin
    case pilihan of
        1: 
        begin
            barang[belanjaan].nama := 'Pasta Gigi';
            barang[belanjaan].harga := 16000;
        end;
        2: 
        begin
            barang[belanjaan].nama := 'Sabun';
            barang[belanjaan].harga := 7000;
        end;
        3: 
        begin
            barang[belanjaan].nama := 'Es Krim';
            barang[belanjaan].harga := 20000;
        end;
        4: 
        begin
            barang[belanjaan].nama := 'Es Loli';
            barang[belanjaan].harga := 15000;
        end;
        5: 
        begin
            barang[belanjaan].nama := 'Senter';
            barang[belanjaan].harga := 60000;
        end;
        6: 
        begin
            barang[belanjaan].nama := 'Lampu LED 18 Watt';
            barang[belanjaan].harga := 40000;
        end;
        7: 
        begin
            barang[belanjaan].nama := 'Susu';
            barang[belanjaan].harga := 10000;
        end;
        8: 
        begin
            barang[belanjaan].nama := 'Yogurt';
            barang[belanjaan].harga := 15000;
        end;
    end;
    barang[belanjaan].jumlah := trunc(jumlah);
    hitungTotal := barang[belanjaan].harga * trunc(jumlah);
end;    

{function validasi Jumlah}
function validasiJumlah(a : string) : real;
var 
    code : integer;
    angka : real;
begin
    Val(a, angka, code);

    if (code <> 0) or (angka <= 0) then
        begin
            WriteLn('Input tidak valid! Harap Masukkan yang Benar');
            validasiJumlah := -1; 
        end
    else
        begin
            validasiJumlah := angka;
        end;
end;

{function VALIDASI Pilihan}
function validasiPilihan(a : string) : integer;
var 
    code, angka : integer;
begin
    Val(a, angka, code);
    if (code <> 0) or (angka < 0) or (angka > banyakBarang) then
        begin
           WriteLn('Input tidak valid! Harap Masukkan yang Benar');
           validasiPilihan := -1; 
        end
    else
        begin
            validasiPilihan := angka;
        end;
end;

{function check member}
function checkMember(kode : string) : boolean;
var 
    Terkonfirmasi : boolean;
begin
    member[1] := 'M132435';
    member[2] := 'M534231';

    Terkonfirmasi:= false;

    for i := 1 to length(member) do
        begin
            if (LowerCase(kode) = LowerCase(member[i])) then
                begin
                    Terkonfirmasi := true;
                    writeln('Terkonfirmasi Seorang Member!');
                    checkMember := Terkonfirmasi;
                    break;
                end;
        end;

    if (not Terkonfirmasi) then
        begin
            writeln('Nama Tidak Ditemukan');
            repeat
                write('Mau Coba Lagi? (y/t): '); readln(jawaban);
                jawaban := LowerCase(jawaban);
            until (jawaban = 'y') or (jawaban = 't');

            if (jawaban = 'y') then
                begin
                    write('Masukkan Kode Member: '); readln(kodeMember);
                    checkMember(kodeMember);
                end
            else
                begin
                    checkMember := false;                
                end;
        end;      
end;

{prosedur menampilkan barang-barang}
procedure tampilkanBarang;
begin
    writeln('=========TOKO JOE MAMA=========');
    writeln('1) Pasta Gigi----------Rp16.000');
    writeln('2) Sabun---------------Rp7.000');
    writeln('3) Es Krim-------------Rp20.000');
    writeln('4) Es Loli-------------Rp15.000');
    writeln('5) Senter--------------Rp60.000');
    writeln('6) Lampu LED 18 Watt---Rp40.000');
    writeln('7) Susu----------------Rp10.000');
    writeln('8) Yogurt--------------Rp15.000');
    writeln('0) Keluar');
    writeln('===============================');
end;

{prosedur Pembayaran}
procedure pembayaran(totalHarga : real);
var
    uangSTR : string; 
    uang : real;
begin
    repeat
        writeln;
        write('Masukkan Jumlah Uang Pembayaran: Rp'); readln(uangSTR);
        uang := validasiJumlah(uangSTR);
        if (uang > 0) and (uang < totalHarga) then
            begin
                writeln('Uang Tidak Cukup!, Silahkan Coba Lagi');
            end;
    until (uang >= totalHarga);

    writeln;
    if (uang > totalHarga) then
        begin
            writeln('PEMBAYARAN SUKSES!');
            writeln('Uang Kembalian: Rp', (uang - totalHarga):0:2);
        end
    else
        begin
            writeln('PEMBAYARAN SUKSES!');
        end;     
end;

{prosedur menampilkan hasil belanja}
procedure tampilkanBelanjaan(member : boolean);
var
    finalTotal: real;
begin
    writeln('==========DAFTAR BELANJA==========');
    for nomor := 1 to belanjaan do
        begin
            writeln(nomor, ') ', barang[nomor].nama, ' x', barang[nomor].jumlah:0:0, ' = Rp', (barang[nomor].harga * barang[nomor].jumlah):0:2);
        end;
    writeln('==================================');
    writeln('Total Belanja: Rp', total:0:2);

    if (member) then
        begin
            writeln('Diskon Member: 10%');
            finalTotal := total * 0.9;
            writeln('Total Belanja Setelah Diskon 10%: Rp', finalTotal:0:2);
        end
    else
        begin
            finalTotal := total;
        end;

    pembayaran(finalTotal);
end;

{prosedur untuk memeriksa dan menambah barang}
procedure periksaDanTambahBarang(nomor : integer; jumlah: real);
var
    i: integer;
    barangDitemukan: boolean;
begin
    barangDitemukan := false;
    { Periksa apakah barang sudah ada di daftar belanja }
    for i := 1 to belanjaan do
        begin
            if (barang[i].nama = barang[nomor].nama) then
                begin
                    barang[i].jumlah := barang[i].jumlah + jumlah;
                    total := total + barang[i].harga * jumlah;
                    barangDitemukan := true;
                    break;
                end;
        end;

    { Jika barang baru, tambahkan ke daftar belanja }
    if (not barangDitemukan) then
        begin
            belanjaan := belanjaan + 1;
            total := total + hitungTotal(nomor, jumlah);
        end;
end;

{PROGRAM UTAMA}
begin
clrscr;

    belanjaan := 0;
    total := 0;
    banyakBarang := 8;

    repeat
        tampilkanBarang;
        write('Pilih Barang (1-8): '); readln(noSTR);
        nomor := validasiPilihan(noSTR);

        if (nomor = 0) and (belanjaan = 0) then
            begin
                writeln('PROGRAM SELESAI KARENA TIDAK ADA BELANJAAN.');
                exit;
            end
        else if (nomor > 0) then
            begin
                write('Masukkan Jumlah: '); readln(jmlhSTR);
                jumlah := validasiJumlah(jmlhSTR);

                if (jumlah > 0) then
                begin
                    periksaDanTambahBarang(nomor, jumlah);
                end;
            end;
    until (nomor = 0);
    clrscr;

    {MENANYAKAN APAKAH SEORANG MEMBER ATAU TIDAK}
    repeat
        write('APAKAH MEMILIKI AKUN MEMBER? (y/t): '); readln(jawaban);
        jawaban := LowerCase(jawaban);
    until (jawaban = 'y') or (jawaban = 't');

    if (jawaban = 'y') then
        begin
            write('Masukkan Kode Member: '); readln(kodeMember);
            tampilkanBelanjaan(checkMember(kodeMember));
        end
    else
        begin
            tampilkanBelanjaan(false); 
        end;
end.
