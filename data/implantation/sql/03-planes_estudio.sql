INSERT `plan_estudio`(`departamento`,`carrera`,`name`,`code`)
VALUES
( 2,  1, 'Licenciatura en Biología', '399501'),
( 3,  2, 'Ingeniería Civil', '329201'),
( 3,  2, 'Ingeniería Civil (nuevo)', '329202'),
( 4,  3, 'Ingeniería Eléctrica', '299701'),
( 4,  4, 'Ingeniería Electrónica', '429701'),
( 5,  5, 'Licenciatura en Didáctica de la Física', '760101'),
( 5,  6, 'Licenciatura en Física', '359201'),
( 6,  7, 'Ingeniería Industrial', '309801'),
( 7,  8, 'Ingeniería en Informática', '134111'),
( 7,  8, 'Licenciatura en Informática', '378501'),
( 7,  9, 'Ingeniería de Sistemas', '419701'),
( 8, 10, 'Licenciatura en Didáctica de la Matemática', '114071'),
( 8, 11, 'Licenciatura en Matemáticas', '349701'),
( 8, 12, 'Ingeniería Matemática', '439801'),
( 9, 13, 'Ingeniería Electromecánica', '650001'),
( 9, 14, 'Ingeniería Mecánica', '319801'),
(10, 15, 'Licenciatura en Química', '389701'),
(10, 16, 'Ingeniería Química', '339701'),
(10, 17, 'Ingeniería de Alimentos', '409701');

UPDATE `plan_estudio` SET `status` = 'disabled' WHERE `ident` = 10;
