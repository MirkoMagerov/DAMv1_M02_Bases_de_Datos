/* Exercici 1. Escriu un programa PL/SQL que introduirem per teclat dos números. Els dos números han de ser positius, en cas contrari s’ha de mostrar a l’usuari el missatge corresponent. S’ha de realitzar la següent operació amb aquests números: dividir entre ells i sumar-li el segon i mostrar el resultat de l'operació. */
do $$
    declare
        firstNum NUMERIC =: n1;
        secondNum NUMERIC =: n2;
        resultNum NUMERIC;
    begin
        if firstNum <= 0 AND secondNum <= 0 then
            raise notice 'Ninguno de los números son naturales (%, %)',firstNum,secondNum;

        elsif firstNum <= 0 then
            raise notice 'El primer número no es natural (%)',firstNum;

        elsif secondNum <= 0 then
            raise notice 'El segundo número no es natural (%) y tampoco se puede dividir por 0.',secondNum;

        else
            resultNum = (firstNum / secondNum) + secondNum;
            raise notice 'El resultado de la división de los dos números és: %',resultNum;
        end if;
    end;
$$

/* Exercici 2. Escriu el mateix programa PL/SQL de l’exercici 1, però ara també s’ha de controlar que el primer número sigui més gran que el segon. En cas contrari s’ha de mostrar el següent missatge:
‘Error! el primer número ha de ser més gran que el segon’. */
do $$
    declare
        firstNum NUMERIC =: "Primer número";
        secondNum NUMERIC =: "Segundo número";
        resultNum NUMERIC;
    begin
        if firstNum <= 0 AND secondNum <= 0 then
            raise notice 'Ninguno de los números son naturales (%, %)',firstNum,secondNum;

        elsif firstNum <= 0 then
            raise notice 'El primer número no es natural (%)',firstNum;

        elsif secondNum <= 0 then
            raise notice 'El segundo número no es natural (%) y tampoco se puede dividir por 0.',secondNum;

        elsif firstNum < secondNum then
            raise notice 'El primer número no puede ser más pequeño que el segundo (%, %)', firstNum, secondNum;

        else
            resultNum = (firstNum / secondNum) + secondNum;
            raise notice 'El resultado de la división de los dos números és: %',resultNum;
        end if;
    END;
$$

/* Exercici 3. Escriu un programa PL/SQL que demani a l’usuari la seva edat i mostri el missatge
corresponent, si:
a) Entre 0 i 17 mostres 'Ets menor de edat!'
b) Entre 18 i 40 mostres 'Ja ets major de edat!'
d) > 40 mostres 'ja ets força gran'
e) Si és negatiu (<0) mostres 'L ́edat no pot ser negativa'. */
do $$
    declare
        userAge NUMERIC =: age;

    begin
        if (userAge < 0) then
            
        elseif (user > 40) then
            
        end if;
    end;
$$

/* Exercici 4. Escriu un programa PL/SQL que demani quina operació es farà:
opció 1 SUMAR, opció 2 RESTAR, opció 3 MULTIPLICAR, opció 4 DIVIDIR. Després el programa també demana dos números i ha de realitzar la operació escollida amb els dos números introduits per teclat. S’ha de mostrar l’operació escollida, els números introduïts i el resultat. */


/* Exercici 5. Escriu un programa PL/SQL que ens mostri els números entre un rang. El rang mínim és 1 i el màxim se li ha de preguntar a l’usuari i no pot ser menor que 2. Si no és 2 o més gran es mostra un missatge a l'usuari i finalitza el programa.
a. Utilitza l’estructura FOR.
b. Utilitza l’estructura WHILE. */


/* Exercici 6. Escriu un programa PL/SQL que mostri els números entre un rang amb un salt. Tant el rang mínim, com el màxim i el salt se li ha de preguntar a l’usuari. A més, s’ha de tenir en compte que el rang mínim sempre ha de ser més petit que el rang màxim i que el el salt ha de ser més gran que 1. En cas contrari s’ha de mostrar el missatge corresponent i acabar el programa. */