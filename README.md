# Device Tree for Motorola Moto G73 5G (`devonf`) — Paranoid Android (AOSPA-CLO)

This repository provides the device configuration and build makefiles for bringing up the **Motorola Moto G73 5G** (`devonf` / `XT2237-2`) on **Paranoid Android (AOSPA)** utilizing CodeLinaro (CLO) based trees.

---

## Device Specifications

| Parameter | Specification |
|:---|:---|
| SoC | MediaTek Dimensity 930 (`MT6855`) |
| Architecture | ARM64-v8a (`armv8-2a-dotprod`, Cortex-A78 + Cortex-A55) |
| GPU | IMG BXM-8-256 |
| RAM | 8 GB / 12 GB LPDDR4X |
| Storage | 128 GB / 256 GB UFS 2.2 |
| Battery | 5000 mAh (30W TurboPower) |
| Display | 6.5" IPS LCD, 1080 x 2400 (120 Hz, 400 DPI) |
| Cameras | 50 MP main (f/1.8 PDAF) + 8 MP ultra-wide/macro (f/2.2 AF), 16 MP front |
| Baseline Firmware | Motorola `U1TNS34.82-12-7-25` |

---

## Key Bringup Architecture & Changes

1. **Product Configuration**:
   - `AndroidProducts.mk` targets `aospa_devonf.mk` with lunch target `aospa_devonf-userdebug`.
   - Inherits `vendor/aospa/target/product/aospa-target.mk` and core 64-bit telephony configurations.
   - Sets certified release build fingerprint:
     `motorola/devonf_g_sys/devonf:14/U1TNS34.82-12-7-25/86c959-5b006d:user/release-keys`.

2. **Kernel & DTBO Strategy**:
   - Kernel Image: 5.10.240-Tachyon (`device/motorola/devonf-kernel/Image.gz`).
   - DTB: `device/motorola/devonf-kernel/dtb/mt6855.dtb`.
   - **DTBO**: Uses Motorola stock signed DTBO from `U1TNS34.82-12-7-25` exclusively:
     - SHA-256: `da3b4938ea777bc03d89934b7a8fd9e8951da9fc84a60a0f5495fd7e6dc886ab`
     - *Safety Note*: Open-source (OSS) DTBO rebuilding is explicitly avoided to prevent hardbrick risks on physical hardware.
     - Wired to `BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img` and included in `AB_OTA_PARTITIONS`.

3. **Partitions & Filesystem**:
   - Dynamic Partitions: `system`, `system_ext`, `vendor`, `vendor_dlkm`, `product` formatted as `erofs`.
   - Data Partition: `f2fs`.
   - A/B virtual OTA with LZ4 compression.

4. **Security & Verified Boot (AVB 2.0)**:
   - Configured with testkey RSA2048 and `--set_hashtree_disabled_flag`.
   - Seamlessly pairs with Little Kernel Candidate v5 spoofing:
     - `ro.boot.vbmeta.device_state = locked`
     - `ro.boot.verifiedbootstate = green`

---

## Build Instructions

1. **Initialize Environment**:
   ```bash
   source build/envsetup.sh
   lunch aospa_devonf-userdebug
   ```

2. **Compile the ROM**:
   ```bash
   m bacon -j$(nproc)
   ```

---

## Dependencies (`aospa.dependencies`)

- `device/motorola/devonf-kernel`: Prebuilt Tachyon 5.10 kernel, modules, DTB, and stock -25 DTBO.
- `vendor/motorola/devonf`: Proprietary HAL libraries, firmware, and prebuilts.
- `hardware/mediatek`: MediaTek hardware abstraction layers.
- `device/mediatek/sepolicy_vndr`: MediaTek vendor SELinux policies.
- `hardware/google/pixel`: Pixel power HAL / libperfmgr integration.
