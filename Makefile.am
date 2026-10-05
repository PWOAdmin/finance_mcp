bin_PROGRAMS = financemcp
financemcp_SOURCES=src/finance_mcp.adb

EXTRA_DIST = finance_mcp.gpr src/*
CLEANFILES = $(obj_DIRS)/* lib/* *.o *.ali *.so configure~ financemcp
DISTCLEANFILES = -rf autom4te.cache

obj_DIRS=obj
CC=
COMPILE=gprbuild -P finance_mcp.gpr \
	  -XLIBRARY_TYPE=relocatable \
	  -XAWS_BUILD=relocatable \
	  -XHARDWARE_PLATFORM=x86_64 \
	  -gnatX

format:
	find . -type f -name '*.ad*'  -print0 |xargs -0 gnatpp --max-line-length=120 --split-line-before-op -l2

all-local:
	$(COMPILE)
clean-local:
	rm -rf ${obj_DIRS}/*
	rm -rf lib/*
	rm -rf tests/obj/*
	rm -rf *.o
	rm -rf *.ali
	rm -rf *.so
	rm -rf configure~
	rm -rf autom4te.cache/*
	rm -rf autom4te.cache
	rm -rf ./financemcp
	rm -rf obj/*
