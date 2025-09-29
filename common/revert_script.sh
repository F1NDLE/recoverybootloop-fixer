#!/sbin/sh

MODULES_DIR="/data/adb/modules"

ui_print() {
    echo "ui_print $1" > /proc/self/fd/$OUTFD
    echo "ui_print" > /proc/self/fd/$OUTFD
}

if [ ! -d "$MODULES_DIR" ]; then
    ui_print "Директория модулей не найдена, что ты удалять собрался?"
    exit 1
fi


LAST_MODULE=$(ls -td $MODULES_DIR/*/ 2>/dev/null | head -n1)

if [ -z "$LAST_MODULE" ]; then
    ui_print "Модули не найдены!"
    exit 1
fi


LAST_MODULE=${LAST_MODULE%/}

ui_print "Найден модуль: $(basename $LAST_MODULE)"
ui_print "удаляю модуль"

# Создаем файл remove
touch "$LAST_MODULE/remove"

if [ -f "$LAST_MODULE/remove" ]; then
    ui_print "Успешно! Модуль был удален!"
else
    ui_print "Удаление не удалось!"
    exit 1
fi
