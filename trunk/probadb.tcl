#
# Таким макаром нужно вставить весь файл подготовленный для базы данных
#CREATE TABLE proba (
#    "FILE" text,
#    "SITE NAME" text,
#    "ALT" text,
#    "NORTH" text,
#    "EAST" text,
#    "START" integer,
#    "END" integer,
#    "SPECIES" text
#);
# INSERT INTO proba VALUES ('Russ001.rwl', 'Polar-Urals', '-999', '66.00', '65.00', 1541, 1968, 'LASI');
# INSERT INTO proba VALUES ('BOL.rwl', NULL, '450', '66.30', '165.40', 1407, 1991, 'LADA');
# Имя файла явдяется ключевым и повторятся не должно
Proba_AddRecord 1 Russ011.rwl Polar-Urals -999 66.00 65.00  1541 1968 LASI
Proba_AddRecord 2 B1L.rwl     NULL         450 66.30 165.40 1407 1991 LADA
Proba_AddRecord 3 Russ001.rwl Polar-Urals -999 66.00 65.00  1541 1968 LASI
Proba_AddRecord 4 BOL.rwl     NULL         450 66.30 165.40 1407 1991 LADA

