/* Exercici 1. Realitzar un programa que contingui una funció que dupliqui la quantitat rebuda com a paràmetre. La funció rebrà el nom de FUNC_DUPLICAR_QUANTITAT. S’ha de programar un bloc
principal que demani per teclat la quantitat i que cridi a la funció FUNC_DUPLICAR_QUANTITAT
passant el paràmetre corresponent. */
CREATE OR REPLACE FUNCTION FUNC_DUPLICAR_QUANTITAT(
    number IN numeric
)
    RETURNS numeric
AS
$$
    declare
    duplicate NUMERIC;
    begin
    duplicate = number * 2;
    RETURN duplicate;
    end;
$$ LANGUAGE plpgsql;


do $$
    declare
        number NUMERIC;
    begin
        number = :"Escribe un número para duplicarlo: ";
        raise notice 'El duplicado del número % es: %', number, FUNC_DUPLICAR_QUANTITAT(number);
    end;
$$

/* Exercici 2. Realitzar un programa que contingui una funció que calculi el factorial d’un número que es passa com a paràmetre. La funció rebrà el nom de FUNC_FACTORIAL. S’ha de programar un bloc principal que pregunti a l’usuari pel número a calcular i cridi a la funció FUNC_FACTORIAL, passant el paràmetre corresponent. */
CREATE OR REPLACE FUNCTION FUNC_FACTORIAL(
    number IN numeric)
    RETURNS numeric
AS
$$
    declare
    factorial NUMERIC = 1;
    begin
    while number > 0
    loop
        factorial = factorial * number;
        number = number - 1;
        end loop;
    RETURN factorial;
    end;
$$ LANGUAGE plpgsql;


do $$
    declare
        number NUMERIC;
    begin
        number = :"Escribe un número para duplicarlo: ";
        raise notice 'El factorial del número % es: %', number, FUNC_FACTORIAL(number);
    end;
$$

/* Exercici 3. Realitzar un procediment que s’anomeni PROC_EMP_INFO i que es passi com a paràmetre l’Id d’un empleat i mostri el seu ID, el seu nom, el seu càrrec (job_title) i el seu salari. Has de canviar els nom de les columnes perquè sigui (codi_empleat, nom_empleat, càrrec, salari). Per realitzar aquest exercici has de fer servir una variable de tipus %rowtype. S’ha de programar un bloc principal que pregunti a l’usuari pel ID de l’empleat i cridi al procediment PROC_EMP_INFO, passant el paràmetre corresponent. */


/* Exercici 4. Realitzar un programa que contingui un procediment anomenat PROC_ALTA_JOB que doni d’alta un nou ofici (JOB) a la taula jobs. Totes les dades del nou ofici s’han de passat com com a paràmetre. S’ha de programar un bloc principal que pregunti a l’usuari totes les dades del nou ofici i cridi el procediment PROC_ALTA_JOB. Abans d’inserir s’ha de comprovar que el valor màxim i mínim del salari no sigui negatiu i a més, que el salari mínim sigui més petit que el salari màxim. Mostra els missatges d’error corresponents. */
