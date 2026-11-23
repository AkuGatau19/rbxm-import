# RBXM Importer (Delta)

Script untuk mengimpor file `.rbxm` / `.rbxmx` ke game Roblox lewat executor Delta.

## Cara pakai
1. Taruh file `.rbxm` di folder `workspace` Delta.
2. Jalankan di Delta:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/rbxm-importer/main/rbxm_importer.lua"))()
```

3. Tap nama file di daftar untuk import.

## Batasan
- Mesh/texture hanya tampil jika memakai asset ID Roblox yang masih tersedia.
- Hanya terlihat di sisi client (pemain lain tidak melihatnya).
- Executor harus mendukung `getcustomasset`, `listfiles`, dan `game:GetObjects`.

> Memakai executor melanggar ToS Roblox dan berisiko ban akun.
