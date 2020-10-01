BIN = <++>
MAN1 = ${BIN}.1
PREFIX = /usr/local
MAN_DIR = ${PREFIX}/man/man1
BIN_DIR = ${PREFIX}/bin

CP = cp -f
RM = rm -f
MKDIR = mkdir -p

.PHONY: all install uninstall

all: ${BIN}

install: all
	${MKDIR} ${DESTDIR}${BIN_DIR} ${DESTDIR}${MAN_DIR}
	${CP} ${BIN} ${DESTDIR}${BIN_DIR}
	${CP} ${MAN1} ${DESTDIR}${MAN_DIR}
	chmod 644 ${DESTDIR}${BIN_DIR}/${BIN}
	chmod 644 ${DESTDIR}${MAN_DIR}/${MAN1}

uninstall:
	${RM} ${DESTDIR}${BIN_DIR}/${BIN}
	${RM} ${DESTDIR}${MAN_DIR}/${MAN1}
