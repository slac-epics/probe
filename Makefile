#*************************************************************************
# Copyright (c) 2002 The University of Chicago, as Operator of Argonne
# National Laboratory.
# Copyright (c) 2002 The Regents of the University of California, as
# Operator of Los Alamos National Laboratory.
# This file is distributed subject to a Software License Agreement found
# in the file LICENSE that is included with this distribution. 
#*************************************************************************
#
# $Id$
#
# Makefile for Probe
TOP=.
include $(TOP)/configure/CONFIG

# Optimization
ifdef WIN32
#HOST_OPT = YES
else
#HOST_OPT = NO
endif

CMPLR = STRICT
#STATIC_BUILD = YES 

# Source browser options
ifeq ($(HOST_OPT),NO)
  ifeq ($(ANSI),ACC)
    ifeq ($(OS_CLASS),solaris)
      USR_CFLAGS += -xsb
    endif
  endif
endif

ifeq ($(OS_CLASS),solaris)
#DEBUGCMD = purify -first-only -chain-length=26 $(PURIFY_FLAGS)
#DEBUGCMD = purify -first-only -chain-length=26 -max_threads=256 $(PURIFY_FLAGS)
#DEBUGCMD = purify -first-only -chain-length=26 -always-use-cache-dir -cache-dir=/tmp/purifycache $(PURIFY_FLAGS)
#DEBUGCMD = purify -first-only -chain-length=26 -enable-new-cache-scheme $(PURIFY_FLAGS)
#DEBUGCMD = purify -first-only -chain-length=26 -enable-new-cache-scheme -always-use-cache-dir -cache-dir=/tmp/purifycache $(PURIFY_FLAGS)

# Put the cache files in the appropriate bin directory
PURIFY_FLAGS += -always-use-cache-dir -cache-dir=$(shell $(PERL) $(TOP)/config/fullPathName.pl .)
endif

PROD_HOST = probe

USR_INCLUDES = -I$(MOTIF_INC) -I$(X11_INC)

PROD_LIBS = ca Com
USR_LIBS_DEFAULT = Xm Xt X11

USR_LIBS_Linux = Xm Xt Xp Xmu X11
USR_LIBS_cygwin32 = Xm Xt X11 SM ICE

ifeq ($(T_A),windows-x64)
WIN32_RUNTIME=MD
USR_CFLAGS_WIN32 += /DWIN32 /D_WINDOWS
USR_LDFLAGS_WIN32 += /SUBSYSTEM:WINDOWS
USR_LIBS_WIN32 += $(EXCEED_XLIBS)
USR_CFLAGS_WIN32 += $(EXCEED_CFLAGS)
RCS_WIN32 += probe.rc
USR_CFLAGS_WIN32 += /DEXCEED
endif

ifeq ($(T_A),win32-x86)
WIN32_RUNTIME=MD
USR_CFLAGS_WIN32 += /DWIN32 /D_WINDOWS
USR_LDFLAGS_WIN32 += /SUBSYSTEM:WINDOWS
USR_LIBS_WIN32 += $(EXCEED_XLIBS)
USR_CFLAGS_WIN32 += $(EXCEED_CFLAGS)
RCS_WIN32 += probe.rc
USR_CFLAGS_WIN32 += /DEXCEED
endif

ifeq ($(T_A),win32-x86-mingw)
ifdef EXCEED
USR_CFLAGS_WIN32 += -DEXCEED
USR_LIBS_WIN32 = $(EXCEED_XLIBS)
USR_LDFLAGS_WIN32 = -L$(X11_LIB) -rpath,$(X11_LIB)
endif
endif

ca_DIR = $(EPICS_BASE_LIB)
Com_DIR = $(EPICS_BASE_LIB)
Xm_DIR = $(MOTIF_LIB)
Xt_DIR = $(X11_LIB)
Xp_DIR = $(X11_LIB)
Xmu_DIR = $(X11_LIB)
X11_DIR = $(X11_LIB)

SRCS +=	probeAdjust.c
SRCS +=	probeButtons.c
SRCS +=	probeCa.c
SRCS +=	probeFormat.c
SRCS +=	probeHistory.c
SRCS +=	probeInfo.c
SRCS +=	probeInit.c
SRCS +=	probeSlider.c
SRCS +=	probeUpdate.c
SRCS +=	probe_main.c
SRCS +=	productDescriptionShell.c

include $(TOP)/configure/RULES
include $(TOP)/configure/RULES_TOP

probe.res:../probe.ico

xxxx:
	@echo VISC_EPICS_DLL_NO:  $(VISC_EPICS_DLL_NO)
	@echo VISC_EPICS_DLL_YES:  $(VISC_EPICS_DLL_YES)
	@echo VISC_EPICS_DLL: $(VISC_EPICS_DLL)
	@echo ca_DIR = $(EPICS_BASE_LIB)
	@echo Xm_DIR = $(MOTIF_LIB)
	@echo Xt_DIR = $(X11_LIB)
	@echo EPICS_HOST_ARCH = $(EPICS_HOST_ARCH)
	@echo HOST_ARCH = $(HOST_ARCH)
	@echo T_A = $(T_A)

# **************************** Emacs Editing Sequences *****************
# Local Variables:
# mode: makefile
# End:
