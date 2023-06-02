
# Use the default kernel version if the Makefile doesn't override it
LINUX_RELEASE?=1

ifdef CONFIG_TESTING_KERNEL
  KERNEL_PATCHVER:=$(KERNEL_TESTING_PATCHVER)
endif

ifdef CONFIG_BETA_KERNEL
  KERNEL_PATCHVER:=$(KERNEL_BETA_PATCHVER)
endif

ifdef CONFIG_RC_KERNEL
  KERNEL_PATCHVER:=$(KERNEL_RC_PATCHVER)
endif

ifdef CONFIG_ALPHA_KERNEL
  KERNEL_PATCHVER:=$(KERNEL_ALPHA_PATCHVER)
endif

KERNEL_DETAILS_FILE=$(INCLUDE_DIR)/kernel-$(KERNEL_PATCHVER)
ifeq ($(wildcard $(KERNEL_DETAILS_FILE)),)
  $(error Missing kernel version/hash file for $(KERNEL_PATCHVER). Please create $(KERNEL_DETAILS_FILE))
endif
include $(KERNEL_DETAILS_FILE)

ifdef KERNEL_TESTING_PATCHVER
  KERNEL_TESTING_DETAILS_FILE=$(INCLUDE_DIR)/kernel-$(KERNEL_TESTING_PATCHVER)
  ifeq ($(wildcard $(KERNEL_TESTING_DETAILS_FILE)),)
    $(error Missing testing kernel version/hash file for $(KERNEL_TESTING_PATCHVER). Please create $(KERNEL_TESTING_DETAILS_FILE))
  endif

  include $(KERNEL_TESTING_DETAILS_FILE)
endif

ifdef KERNEL_BETA_PATCHVER
  KERNEL_BETA_DETAILS_FILE=$(INCLUDE_DIR)/kernel-$(KERNEL_BETA_PATCHVER)
  ifeq ($(wildcard $(KERNEL_BETA_DETAILS_FILE)),)
    $(error Missing beta kernel version/hash file for $(KERNEL_BETA_PATCHVER). Please create $(KERNEL_BETA_DETAILS_FILE))
  endif

  include $(KERNEL_BETA_DETAILS_FILE)
endif

ifdef KERNEL_RC_PATCHVER
  KERNEL_RC_DETAILS_FILE=$(INCLUDE_DIR)/kernel-$(KERNEL_RC_PATCHVER)
  ifeq ($(wildcard $(KERNEL_RC_DETAILS_FILE)),)
    $(error Missing rc kernel version/hash file for $(KERNEL_RC_PATCHVER). Please create $(KERNEL_RC_DETAILS_FILE))
  endif

  include $(KERNEL_RC_DETAILS_FILE)
endif


ifdef KERNEL_ALPHA_PATCHVER
  KERNEL_ALPHA_DETAILS_FILE=$(INCLUDE_DIR)/kernel-$(KERNEL_ALPHA_PATCHVER)
  ifeq ($(wildcard $(KERNEL_ALPHA_DETAILS_FILE)),)
    $(error Missing appha kernel version/hash file for $(KERNEL_ALPHA_PATCHVER). Please create $(KERNEL_ALPHA_DETAILS_FILE))
  endif

  include $(KERNEL_ALPHA_DETAILS_FILE)
endif


remove_uri_prefix=$(subst git://,,$(subst http://,,$(subst https://,,$(1))))
sanitize_uri=$(call qstrip,$(subst @,_,$(subst :,_,$(subst .,_,$(subst -,_,$(subst /,_,$(1)))))))

ifneq ($(call qstrip,$(CONFIG_KERNEL_GIT_CLONE_URI)),)
  LINUX_VERSION:=$(call sanitize_uri,$(call remove_uri_prefix,$(CONFIG_KERNEL_GIT_CLONE_URI)))
  ifeq ($(call qstrip,$(CONFIG_KERNEL_GIT_REF)),)
    CONFIG_KERNEL_GIT_REF:=HEAD
  endif
  LINUX_VERSION:=$(LINUX_VERSION)-$(call sanitize_uri,$(CONFIG_KERNEL_GIT_REF))
else
ifdef KERNEL_PATCHVER
  LINUX_VERSION:=$(KERNEL_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_PATCHVER)))
endif
ifdef KERNEL_TESTING_PATCHVER
  LINUX_TESTING_VERSION:=$(KERNEL_TESTING_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_TESTING_PATCHVER)))
endif
ifdef KERNEL_BETA_PATCHVER
  LINUX_BETA_VERSION:=$(KERNEL_BETA_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_BETA_PATCHVER)))
endif
ifdef KERNEL_RC_PATCHVER
  LINUX_RC_VERSION:=$(KERNEL_RC_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_RC_PATCHVER)))
endif
ifdef KERNEL_ALPHA_PATCHVER
  LINUX_ALPHA_VERSION:=$(KERNEL_ALPHA_PATCHVER)$(strip $(LINUX_VERSION-$(KERNEL_ALPHA_PATCHVER)))
endif
endif

split_version=$(subst ., ,$(1))
merge_version=$(subst $(space),.,$(1))
KERNEL_BASE=$(firstword $(subst -, ,$(LINUX_VERSION)))
KERNEL=$(call merge_version,$(wordlist 1,2,$(call split_version,$(KERNEL_BASE))))
KERNEL_PATCHVER ?= $(KERNEL)

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_HASH:=$(LINUX_KERNEL_HASH-$(strip $(LINUX_VERSION)))
LINUX_KERNEL_HASH?=x
