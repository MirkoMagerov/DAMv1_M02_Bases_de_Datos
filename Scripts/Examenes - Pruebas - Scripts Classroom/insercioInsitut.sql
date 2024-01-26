INSERT INTO persona (dni, nom, primer_cognom, segon_cognom, adreça, telefon)
VALUES
    ('11111111A', 'Alberto', 'Fernandez', 'Rodriguez', 'Aiguablava 121 08033', 632323232),
    ('22222222A', 'Alberto', 'Fernandez', 'Rodriguez', 'Aiguablava 121 08033', 222222222),
    ('33333333A', 'Joel', 'Olivera', 'Rodriguez', 'Aiguablava 121 08033', 333333333),
    ('44444444A', 'Maria', 'Alejandra', 'Perera', 'Aiguablava 121 08033', 444444444),
    ('55555555A', 'Meritxell', 'Reig', 'Rodriguez', 'Aiguablava 121 08033', 555555555),
    ('66666666B', 'Mireia', 'Davila', 'Rodriguez', 'Aiguablava 121 08033', 666666666),
    ('77777777B', 'Marco', 'Segura', 'Rodriguez', 'Aiguablava 121 08033', 777777777),
    ('88888888B', 'Aicha', 'Aranda', 'Rodriguez', 'Aiguablava 121 08033', 888888888),
    ('99999999B', 'Maria', 'Lourdes', 'Mosquera', 'Aiguablava 121 08033', 999999999),
    ('10101010B', 'Maria', 'Luz', 'Benitez', 'Aiguablava 121 08033', 000000000);

INSERT INTO professor (dni, especialitat)
VALUES
    ('11111111A', 'Ingles'),
    ('22222222A', 'Mates'),
    ('33333333A', 'BBDD'),
    ('44444444A', 'Programacion'),
    ('55555555A', 'Game Design');

INSERT INTO alumne (dni, data_naixement, dni_delegat)
VALUES 
    ('66666666B', '2023-06-14', '66666666B'),
    ('77777777B', '1998-11-30', '66666666B'),
    ('88888888B', '2015-03-22', '66666666B'),
    ('99999999B', '2005-09-17', '66666666B'),
    ('10101010B', '2020-07-09', '66666666B');

INSERT INTO aula (numero_aula, m2)
VALUES
    (01, 20),
    (02, 25),
    (03, 15),
    (04, 28.32),
    (05, 19.1);

INSERT INTO assignatura (codi_assignatura, nom)
VALUES
    (01, 'UF1-Prog'),
    (02, 'UF2-GameDes'),
    (03, 'UF3-BBDD'),
    (04, 'UF4-Ing'),
    (05, 'UF5-MAt');

INSERT INTO modul (codi_modul, nom, numero_aula)
VALUES
    (1, 'Programacio', 02),
    (2, 'Game Design', 01),
    (3, 'BBDD', 04),
    (4, 'Ingles', 05),
    (5, 'Mates', 03);

INSERT INTO pertany (codi_modul, codi_assignatura)
VALUES
    (1, 01),
    (2, 02),
    (3, 03),
    (4, 04),
    (5, 05);

INSERT INTO ensenya (dni_professor, codi_assignatura)
VALUES
    ('11111111A', 04),
    ('22222222A', 05),
    ('33333333A', 03),
    ('44444444A', 01),
    ('55555555A', 02);

INSERT INTO matricula (dni_alumne, codi_assignatura)
VALUES
    ('66666666B', 04),
    ('77777777B', 05),
    ('88888888B', 03),
    ('99999999B', 01),
    ('10101010B', 02);