BIN = <++>
MAN1 = ${BIN}.1
PREFIX = /usr/local
MAN_DIR = ${PREFIX}/man/man1
INSTALL_PATH = ${PREFIX}bin

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

SRC = ${wildcard ${SRC_DIR}/*.<++>}
OBJ = ${SRC:${SRC_DIR}/%.<++>=${OBJ_DIR}/%.o}

CP = cp -f
RM = rm -f
MV = mv
MKDIR = mkdir -p
RM_DIR = rm -rf

CC = <++>
CPPFLAGS += -Iinclude -pedantic
CFLAGS += -Wall -std=<++> -O3
LDFLAGS += -Llib
LDLIBS += <++>

.PHONY: all clean install uninstall run

all: ${BIN}

${BIN}: ${OBJ}
	${MKDIR} ${BIN_DIR}
	${CC} ${LDFLAGS} $^ ${LDLIBS} -o $@
	${MV} ${BIN} ${BIN_DIR}

${OBJ_DIR}/%.o: ${SRC_DIR}/%.<++>
	${MKDIR} ${OBJ_DIR}
	${CC} ${CPPFLAGS} ${CFLAGS} -c $< -o $@

run:
	./${BIN_DIR}/${BIN}

install: all
	${MKDIR} ${DESTDIR}${BIN_DIR} ${DESTDIR}${MAN_DIR}
	${CP} ${BIN_DIR}/${BIN} ${INSTALL_PATH}
	${CP} ${MAN1} ${DESTDIR}${MAN_DIR}
	chmod 644 ${DESTDIR}${BIN_DIR}/${BIN}
	chmod 644 ${DESTDIR}${MAN_DIR}/${MAN1}

uninstall:
	${RM} ${DESTDIR}${BIN_DIR}/${BIN}
	${RM} ${DESTDIR}${MAN_DIR}/${MAN1}
	
clean:
	${RM_DIR} ${OBJ_DIR} ${BIN_DIR}
