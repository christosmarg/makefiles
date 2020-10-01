BIN = <++>
MAN1 = ${BIN}.1
PREFIX = /usr/local
MAN_DIR = ${PREFIX}/man/man1
BIN_DIR = ${PREFIX}bin

SRC = ${wildcard *.<++>}
OBJ = ${SRC:%.<++>=%.o}

CC = <++>
CPPFLAGS += -Iinclude -pedantic
CFLAGS += -Wall -std=<++> -O3
LDFLAGS += -Llib
LDLIBS += <++>

CP = cp -f
RM = rm -f
MKDIR = mkdir -p

.PHONY: all clean install uninstall run

all: ${BIN}

${BIN}: ${OBJ}
	${CC} ${LDFLAGS} $^ ${LDLIBS} -o $@

%.o: %.<++>
	${CC} ${CPPFLAGS} ${CFLAGS} -c $< -o $@

run:
	./${BIN}

install: all
	${MKDIR} ${DESTDIR}${BIN_DIR} ${DESTDIR}${MAN_DIR}
	${CP} ${BIN} ${BIN_DIR}
	${CP} ${MAN1} ${DESTDIR}${MAN_DIR}
	chmod 644 ${DESTDIR}${BIN_DIR}/${BIN}
	chmod 644 ${DESTDIR}${MAN_DIR}/${MAN1}

uninstall:
	${RM} ${DESTDIR}${BIN_DIR}/${BIN}
	${RM} ${DESTDIR}${MAN_DIR}/${MAN1}

clean:
	${RM} ${OBJ} ${BIN}
