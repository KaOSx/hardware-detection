BIN_FILES = ${wildcard bin/*}
HOOKS_FILES = ${wildcard hooks/*}
LIC_FILES = ${wildcard hwdb/lic_*}
ETC_FILES = ${wildcard etc/hwdetect.conf}
MODPROBED_FILES = ${wildcard etc/modprobe.d/*}

SD_OPT ?= opt/live
SD_ETC ?= etc
SD_MODPROBED ?= etc/modprobe.d

SRCS	= $(BIN_FILES) $(HOOKS_FILES) $(LIC_FILES) $(ETC_FILES) $(MODPROBED_FILES)
AUX	= Makefile
FNAME	= hardware-detection-`date +%Y%m%d`


install:
	install -d "${DESTDIR}/${SD_OPT}"{,/bin,/hooks,/hwdb} "${DESTDIR}/${SD_ETC}" "${DESTDIR}/${SD_MODPROBED}"
	install -m755 -t "${DESTDIR}/${SD_OPT}/bin" ${BIN_FILES}
	install -m755 -t "${DESTDIR}/${SD_OPT}/hooks" ${HOOKS_FILES} 
	install -m644 -t "${DESTDIR}/${SD_OPT}/hwdb" ${LIC_FILES} 
	install -m644 -t "${DESTDIR}/${SD_ETC}" ${ETC_FILES}
	install -m644 -t "${DESTDIR}/${SD_MODPROBED}" ${MODPROBED_FILES}

dist:
	-rm -rf $(FNAME)
	mkdir $(FNAME)
	cp -Rl --parents  $(SRCS) $(AUX) $(FNAME)
	tar chzf $(FNAME).tar.gz $(FNAME)
	-rm -rf $(FNAME)
