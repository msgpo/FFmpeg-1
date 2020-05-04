LOCAL_PATH := $(call my-dir)
LIBRETRO_EMBED_FFMPEG=1
BAKE_IN_FFMPEG=1
LIBS:=
GLFLAGS:=

include $(CLEAR_VARS)

LOCAL_MODULE := retro

ROOT_DIR := ..
LIBRETRO_DIR = ../libretro
CORE_DIR := $(ROOT_DIR)

ifeq ($(TARGET_ARCH),arm)
LOCAL_ARM_MODE := arm
LOCAL_CFLAGS := -marm

COMMON_FLAGS := -DANDROID_ARM

ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
LOCAL_ARM_NEON := true
HAVE_NEON := 0
endif

endif

ifeq ($(TARGET_ARCH),x86)
COMMON_FLAGS := -DANDROID_X86 -D__SSE2__ -D__SSE__ -D__SOFTFP__
ARCH_X86 := 1
endif

ifeq ($(TARGET_ARCH),x86_64)
ARCH_X86_64 := 1
endif

ifeq ($(TARGET_ARCH),mips)
COMMON_FLAGS := -DANDROID_MIPS
endif

ifeq ($(NDK_TOOLCHAIN_VERSION), 4.6)
COMMON_FLAGS += -DANDROID_OLD_GCC
endif

SOUECES_C   :=
SOURCES_CXX :=
SOURCES_ASM :=
INCFLAGS    :=

HAVE_LIBTWOLAME := 0
HAVE_LIBWEBP := 0
HAVE_LIBX265 := 0
HAVE_LIBSPEEX := 0
HAVE_LIBOPUS := 0
HAVE_LIBX264 := 0
HAVE_LIBTHEORA := 0
HAVE_POLL_H := 1
HAVE_THREADS := 1
HAVE_PTHREADS := 1
INTERNAL_LIBOPUS := 1

include $(ROOT_DIR)/Makefile.common

LOCAL_SRC_FILES := $(SOURCES_CXX) $(SOURCES_C) $(SOURCES_ASM)

# Video Plugins

COMMON_FLAGS += -D__LIBRETRO__ -DINLINE="inline" -DANDROID -DHAVE_STRUCT_SOCKADDR_STORAGE -DHAVE_STRUCT_SOCKADDR_SA_LEN -DHAVE_STRUCT_SOCKADDR_IN6 -DHAVE_STRUCT_ADDRINFO -DHAVE_POLL_H -DHAVE_ARPA_INET_H -DHAVE_UNISTD_H -DHAVE_GETADDRINFO=1 $(DEFINES) -DHAVE_CLOSESOCKET=0 -DCONFIG_NETWORK=1 -DHAVE_SOCKLEN_T=1 -DHAVE_PTHREADS=1
COMMON_OPTFLAGS = -O2

LOCAL_CFLAGS += $(COMMON_OPTFLAGS) $(COMMON_FLAGS) -std=gnu99 $(INCFLAGS) $(GLFLAGS)
LOCAL_CXXFLAGS += $(COMMON_OPTFLAGS) $(COMMON_FLAGS) $(INCFLAGS) $(GLFLAGS)
#LOCAL_LDLIBS += -lGLESv3
LOCAL_C_INCLUDES = $(INCFLAGS)

include $(BUILD_SHARED_LIBRARY)
