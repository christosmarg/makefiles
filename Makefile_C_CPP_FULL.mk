# See LICENSE file for copyright and license details.
# <++>
.POSIX:

include config.mk

BIN = <++>
DIST = ${BIN}-${VERSION}
MAN1 = ${BIN}.1

SRC_DIR = <++>
OBJ_DIR = <++>
BIN_DIR = <++>

EXT = <++>
SRC = <++>
OBJ = ${SRC:${SRC_DIR}.${EXT}=${OBJ_DIR}.o}

all: options ${BIN}

options:
	@echo ${BIN} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

${BIN}: ${OBJ}
	${MKDIR} ${BIN_DIR}
	${CC} ${LDFLAGS} ${OBJ} -o $@
	${MV} ${BIN} ${BIN_DIR}

.${EXT}.o:
	${MKDIR} ${OBJ_DIR}
	${CC} -c ${CFLAGS} $<

dist: clean
	${MKDIR} ${DIST}
	${CP} -R <++> ${DIST}
	${TAR} ${DIST}.tar ${DIST}
	${GZIP} ${DIST}.tar
	${RM_DIR} ${DIST}

run:
	./${BIN_DIR}/${BIN}

install: all
	${MKDIR} ${DESTDIR}${BIN_DIR} ${DESTDIR}${MAN_DIR}
	${CP} ${BIN_DIR}/${BIN} ${BIN_DIR}
	${CP} ${MAN1} ${DESTDIR}${MAN_DIR}
	sed "s/VERSION/${VERSION}/g" < ${MAN1} > ${DESTDIR}${MAN_DIR}/${MAN1}
	chmod 755 ${DESTDIR}${BIN_DIR}/${BIN}
	chmod 644 ${DESTDIR}${MAN_DIR}/${MAN1}

uninstall:
	${RM} ${DESTDIR}${BIN_DIR}/${BIN}
	${RM} ${DESTDIR}${MAN_DIR}/${MAN1}
	
clean:
	${RM_DIR} ${BIN_DIR} ${OBJ_DIR}
	${RM} ${DIST}.tar.gz

.PHONY: all options clean dist install uninstall run
