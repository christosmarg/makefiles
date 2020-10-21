# See LICENSE file for copyright and license details.
# <++>
.POSIX:

BIN = <++>
VERSION = <++>
DIST = ${BIN}-${VERSION}
MAN1 = ${BIN}.1
PREFIX = /usr/local
MAN_DIR = ${PREFIX}/man/man1
BIN_DIR = ${PREFIX}/bin

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

#EXT = <++>
#SRC = ${wildcard ${SRC_DIR}/*.${EXT}}
#OBJ = ${SRC:${SRC_DIR}/%.${EXT}=${OBJ_DIR}/%.o}
SRC = <++>
OBJ = <++>

CP = cp -f
RM = rm -f
RM_DIR = rm -rf
MV = mv
MKDIR = mkdir -p
RM_DIR = rm -rf
TAR = tar -cf
GZIP = gzip

CC = <++>
INCS = -Iinclude 
CPPFLAGS = -DVERSION=\"${VERSION}\"
CFLAGS = -Wall -std=<++> -pedantic -O3 ${INCS} ${CPPFLAGS}
LDFLAGS = -Llib <++>

all: options ${BIN}

options:
	@echo ${BIN} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

${BIN}: ${OBJ}
	${MKDIR} ${BIN_DIR}
	${CC} ${LDFLAGS} ${OBJ} ${LDLIBS} -o $@
	${MV} ${BIN} ${BIN_DIR}

${OBJ}: ${SRC}
	${MKDIR} ${OBJ_DIR}
	${CC} ${CFLAGS} -c ${SRC} -o $@

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
