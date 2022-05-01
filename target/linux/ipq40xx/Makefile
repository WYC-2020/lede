include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=ipq40xx
BOARDNAME:=Qualcomm Atheros IPQ40XX
FEATURES:=squashfs fpu ramdisk nand
CPU_TYPE:=cortex-a7
CPU_SUBTYPE:=neon-vfpv4
SUBTARGETS:=generic

KERNEL_PATCHVER:=5.4
KERNEL_BATE_PATCHVER:=5.10
KERNEL_TESTING_PATCHVER:=5.15

KERNELNAME:=zImage Image dtbs

include $(INCLUDE_DIR)/target.mk
DEFAULT_PACKAGES += \
	kmod-usb-dwc3-qcom \
	kmod-leds-gpio kmod-gpio-button-hotplug swconfig \
	kmod-ath10k-ct wpad-openssl uboot-envtools \
	kmod-usb3 kmod-usb-dwc3 ath10k-firmware-qca4019-ct \
	autocore-arm automount autosamba ethtool htop \
	luci-app-adbyby-plus luci-app-cpufreq luci-app-ipsec-vpnd \
	luci-app-unblockmusic luci-app-zerotier

$(eval $(call BuildTarget))
