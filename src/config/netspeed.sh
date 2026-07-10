#!/bin/bash

# Ganti dengan nama interface internetmu (cek pake: ip a)
INTERFACE="wlp0s29u1u1" 

while true; do
    # 1. AMBIL DATA INTERNET
    R1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    T1=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
    sleep 1
    R2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    T2=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)

    # Hitung selisih (bytes per second)
    TBPS=$((T2 - T1))
    RBPS=$((R2 - R1))

    # Konversi ke KB/s
    TKBPS=$((TBPS / 1024))
    RKBPS=$((RBPS / 1024))

    # 2. AMBIL DATA WAKTU DAN TANGGAL (Format ala iPhone)
    # WAKTU: Jam:Menit (Contoh: 14:05)
    WAKTU=$(date +"%H:%M")
    # TANGGAL: Hari Singkat, Tanggal Bulan Singkat (Contoh: Sab, 11 Jul)
    # Jika ingin pakai bahasa Indonesia, pastikan locale sistem sudah diatur ke id_ID.
    TANGGAL=$(date +"%a, %d %b")

    # ---- ATUR INTERFACE / TAMPILAN DI SINI ----
    # Menggabungkan Kecepatan Internet, Tanggal, dan Jam dengan format minimalis
    TAMPILAN=" ⬇ $RKBPS KB/s  ⬆ $TKBPS KB/s  |  $TANGGAL  |  $WAKTU "
    
    # Kirim ke root window name (status bar)
    xsetroot -name "$TAMPILAN"
done
