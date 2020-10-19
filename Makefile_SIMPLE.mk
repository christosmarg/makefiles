# See LICENSE file for copyright and license details.

BIN = <++>
VERSION = <++>
DIST = ${BIN}-${VERSION}
MAN1 = ${BIN}.1
PREFIX = /usr/local
MAN_DIR = ${PREFIX}/man/man1
BIN_DIR = ${PREFIX}/bin

CP = cp -f
RM = rm -f
RM_DIR = rm -rf
MKDIR = mkdir -p
TAR = tar -cf
GZIP = gzip

all: ${BIN}

dist:
		${MKDIR} ${DIST}
		${CP} -R <++> ${DIST}
		${TAR} ${DIST}.tar ${DIST}
		${GZIP} ${DIST}.tar
		${RM_DIR} ${DIST}

install: all
		${MKDIR} ${DESTDIR}${BIN_DIR} ${DESTDIR}${MAN_DIR}
		${CP} ${BIN} ${DESTDIR}${BIN_DIR}
		${CP} ${MAN1} ${DESTDIR}${MAN_DIR}
		sed "s/VERSION/${VERSION}/g" < ${MAN1} > ${DESTDIR}${MAN_DIR}/${MAN1}
		chmod 755 ${DESTDIR}${BIN_DIR}/${BIN}
		chmod 644 ${DESTDIR}${MAN_DIR}/${MAN1}

uninstall:
		${RM} ${DESTDIR}${BIN_DIR}/${BIN}
		${RM} ${DESTDIR}${MAN_DIR}/${MAN1}

clean:
		${RM} ${DIST}.tar.gz

.PHONY: all clean dist install uninstall
