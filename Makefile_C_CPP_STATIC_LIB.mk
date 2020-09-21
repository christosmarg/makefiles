LIB = <++>
MAN3 = ${LIB}.3
PREFIX = /usr/local
MAN_DIR = ${PREFIX}/man/man3
HDR_DIR = ${PREFIX}/include
LIB_DIR = ${PREFIX}/lib

SRC = ${wildcard *.<++>}
OBJ = ${SRC:%.<++>=%.o}

AR = ar
ARFLAGS = rs
CC = <++>
CPPFLAGS += -Iinclude -pedantic
CFLAGS += -Wall -std=<++> -O3
LDFLAGS += -Llib
LDLIBS += <++>

CP = cp -f
RM = rm -f
MKDIR = mkdir -p

.PHONY: all clean install uninstall

all: ${LIB}

${LIB}: ${OBJ}
	${AR} ${ARFLAGS} lib${LIB}.a ${OBJ}

%.o: %.c
	${CC} ${CPPFLAGS} ${CFLAGS} -c $< -o $@

install: all
	${MKDIR} ${DESTDIR}${LIB_DIR} ${DESTDIR}${HDR_DIR} ${DESTDIR}${MAN_DIR}
	${CP} ${LIB}.h ${DESTDIR}${HDR_DIR}
	${CP} lib${LIB}.a ${DESTDIR}${LIB_DIR}
	${CP} ${MAN3} ${DESTDIR}${MAN_DIR}
	chmod 644 ${DESTDIR}${HDR_DIR}/${LIB}.h
	chmod 644 ${DESTDIR}${LIB_DIR}/lib${LIB}.a
	chmod 644 ${DESTDIR}${MAN_DIR}/${MAN3}

uninstall: all
	${RM} ${DESTDIR}${HDR_DIR}/${LIB}.h
	${RM} ${DESTDIR}${LIB_DIR}/lib${LIB}.a
	${RM} ${DESTDIR}${MAN_DIR}/${MAN3}

clean:
	${RM} ${OBJ} ${LIB} lib${LIB}.a
