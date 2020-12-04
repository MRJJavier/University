--DML3
-- De las sentencias 1 a la 22 dan los resultados pedidos, aunque algunas de ellas pueden darlo en otro orden

--Agrupación1

/*1. Calcular el número de profesores de cada departamento. Muestre el nombre del departamento y el
número de profesores.*/
select d.nombre, count(*) 
from departamentos d
join profesores p on p.departamento = d.codigo
group by d.nombre,d.codigo;



/*2. Calcular el número de créditos asignados a cada departamento. Se consideran los créditos
establecidos para cada asignatura del departamento, no si la imparten o no profesores del mismo, es
decir, sume directamente los créditos de las asignaturas y reúna asignaturas y departamentos
directamente, sin utilizar ninguna otra tabla*/
select d.nombre, count(*), sum(a.creditos) 
from departamentos d
join asignaturas a on a.departamento  = d.codigo
group by d.codigo,d.nombre;




/*3. Calcular el número de alumnos matriculados por curso (cada alumno debe contar una sola vez por
curso aunque esté matriculado de varias asignaturas). Utilice COUNT (DISTINCT ...).*/
select distinct a.curso, count(distinct alumno) "Numero Alumnos" 
from asignaturas a
join matricular m on m.asignatura=a.codigo
join alumnos al on m.alumno = al.dni
group by a.curso
having a.curso is not null;



/*4. Por cada número de despacho, indicar el total de créditos impartidos por profesores ubicados en ellos*/
select distinct p.despacho, sum(carga_creditos) "Total creditos"
from profesores p
join impartir i on p.id=i.profesor
group by p.despacho
having p.despacho is not null;


/*5. Calcular, por cada asignatura, qué porcentaje de sus alumnos son mujeres. Mostrar el código de la
asignatura y el porcentaje.*/
select m.asignatura, sum(decode(a.genero,'FEM',1,0))*100/count(a.dni) "Porcentaje"
from matricular m 
join alumnos a on (m.alumno=a.dni)
group by m.asignatura
order by asignatura;


/*6. Mostrar la población de cada provincia española: nombre de provincia y suma de hombres y mujeres
de todos sus municipios.*/
select p.nombre, sum(m.hombres + m.mujeres) "Suma"
from provincia p
join municipio m on p.codigo=m.cpro
group by p.nombre
order by 1;

--Agrupación2

/*7. Visualizar, por cada departamento, el nombre del profesor más cercano a la jubilación (de mayor
edad).*/
select d.nombre, p.nombre ||' '|| p.apellido1 "Profesor"
from departamentos d
join profesores p on d.codigo=p.departamento
where p.fecha_nacimiento in (select min(p.fecha_nacimiento)
                             from profesores p
                             group by p.departamento);



/*8. Visualizar la asignatura de mayor número de créditos en que se ha matriculado cada alumno.*/
select al.nombre || ' ' || al.apellido1 || ' ' || al.apellido2 "Alumno", a.nombre "Asignatura"
from alumnos al
join matricular m on al.dni = m.alumno
join asignaturas a on a.codigo = m.asignatura
where (al.dni,a.creditos) in (select al.dni, max(a.creditos) 
                     from alumnos al
                     join matricular m on al.dni = m.alumno
                     join asignaturas a on a.codigo = m.asignatura
                     group by al.dni)
group by al.nombre || ' ' || al.apellido1 || ' ' || al.apellido2 , a.nombre
order by al.nombre || ' ' || al.apellido1 || ' ' || al.apellido2 , a.nombre;



/*9. Visualizar el profesor más antiguo de cada departamento.*/
select d.nombre, p.nombre ||' '|| p.apellido1 "Profesor"
from departamentos d
join profesores p on d.codigo=p.departamento
where (p.departamento,p.antiguedad) in (select p.departamento, min(p.antiguedad)
                                        from profesores p
                                        group by p.departamento);

/*10.Visualizar para cada departamento, la asignatura con menos créditos*/
select d.nombre, a.nombre 
from departamentos d
join asignaturas a on d.codigo = a.departamento
where (d.codigo,a.creditos) in (select d.codigo, min(a.creditos)
                                from asignaturas a
                                join departamentos d on d.codigo = a.departamento
                                group by d.codigo);
                     


/*11.Visualizar para cada asignatura, el alumno de menor edad matriculado en el curso 2014-2015.*/
select  a.nombre "Asignatura", al.nombre || ' ' || al.apellido1 || ' ' || al.apellido2 "Alumno", al.fecha_nacimiento
from alumnos al
join matricular m on al.dni = m.alumno
join asignaturas a on a.codigo = m.asignatura
where (a.codigo,al.fecha_nacimiento) in (select a.codigo, max(al.fecha_nacimiento)
                                         from alumnos al
                                         join matricular m on al.dni = m.alumno
                                         join asignaturas a on a.codigo = m.asignatura
                                         where m.curso='14/15'
                                         group by a.codigo)
group by a.nombre, al.nombre || ' ' || al.apellido1 || ' ' || al.apellido2, al.fecha_nacimiento
order by a.nombre, al.nombre || ' ' || al.apellido1 || ' ' || al.apellido2, al.fecha_nacimiento;

--Agrupación3

/*12.Visualizar el profesor con mayor carga de créditos. Considere la carga de créditos como la suma de
los créditos de las asignaturas que imparte dicho profesor. Nota: Tenga en cuenta que un profesor
puede impartir sólo una parte de una asignatura, por lo que se debe utilizar los créditos de la tabla
impartir*/
select "Profesor", "Creditos" 
from(select p.nombre ||' '|| p.apellido1 "Profesor", sum(i.carga_creditos) "Creditos"
     from profesores p
     join impartir i on i.profesor = p.id
     where i.carga_creditos is not null
     group by p.nombre ||' '|| p.apellido1
     order by sum(i.carga_creditos) desc)
where rownum = 1;




/*13.Visualizar el departamento con mayor número de asignaturas a su cargo.*/
select "Departamento"
from (select d.nombre "Departamento", count(a.codigo)
      from departamentos d
      join asignaturas a on a.departamento=d.codigo
      group by d.nombre
      order by count(a.codigo) desc)
where rownum = 1;



/*14.Muestre el listado de los profesores que imparten menos de 10 créditos en total. Indique el código del
profesor y el número de créditos que imparte.*/
select i.profesor, sum(i.carga_creditos)"CREDITOS"
from impartir i
group by i.profesor
having sum(i.carga_creditos)<10;



/*15.Listar los profesores que tienen una carga de créditos superior a la media. Use clausula HAVING y
anide funciones de agrupación.*/
select p.nombre,p.apellido1,p.apellido2
from impartir i
join profesores p on p.id = i.profesor
group by p.nombre,p.apellido1,p.apellido2
having sum(i.carga_creditos) > (select avg(sum(i.carga_creditos))
                                from impartir i
                                group by i.profesor);


/*16.Visualizar aquellos profesores que imparten 2 o más asignaturas en el curso 15/16 con una carga de
créditos inferior a 6.5 en cada una de ellas.*/
select p.id
from profesores p 
join impartir i on p.id=i.profesor
where i.curso='15/16'
      and i.carga_creditos<6.5
group by p.id
having count(i.profesor)>=2;

--Negativas1


/*17. Dar el nombre de las asignaturas hueso. Una asignatura se dice hueso si ningún alumno la ha
superado.*/
select a.nombre
from asignaturas a
where a.codigo not in(select m.asignatura
                      from matricular m
                      where m.calificacion is not null
                            and m.calificacion!='SP'
                            and m.calificacion!='NP');

/*18.Listar el nombre de los departamentos que no tienen ninguna asignatura con más de 6 créditos.*/
select d.nombre
from departamentos d
where d.codigo not in (select a.departamento
                       from asignaturas a
                       where a.creditos>6);
                       


/*19.Listar alfabéticamente los profesores que están en la lista negra de los alumnos. Si un profesor está en
la lista negra de los alumnos, da clase en alguna asignatura optativa y en ella los alumnos no se
matriculan para evitarlo. Tenga en cuenta que si hay dos turnos de la optativa, los alumnos tienden a
evitar al profesor de ese turno, pero no a los de los otros grupos.*/
select p.nombre, p.apellido1, p.apellido2
from profesores p
join impartir i on i.profesor = p.id
join asignaturas a on i.asignatura = a.codigo
where a.caracter='OP' 
      and (i.asignatura,i.grupo) not in (select m.asignatura, m.grupo
                                         from matricular m);
                                

/*20.Mostrar las parejas de profesores que no tienen ningún alumno en común*/
select p1.nombre ||' '|| p1.apellido1 ||' '|| p1.apellido2 "Profesor1",
       p2.nombre ||' '|| p2.apellido1 ||' '|| p2.apellido2 "Profesor2"
from profesores p1,profesores p2
where p1.id<p2.id
      and (p1.id,p2.id) not in(select i1.profesor,i2.profesor
                                from impartir i1
                                join matricular m1 on m1.asignatura = i1.asignatura,
                                impartir i2
                                join matricular m2 on m2.asignatura = i2.asignatura
                                where i1.curso=m1.curso 
                                      and i2.curso=m2.curso 
                                      and i1.grupo=m1.grupo 
                                      and i2.grupo=m2.grupo
                                      and m1.alumno=m2.alumno);


/*21.Mostrar el listado de profesores que no comparten ninguna de sus asignaturas (dos profesores
comparten asignatura si imparten la misma asignatura independientemente del turno).*/
select p1.nombre ||' '|| p1.apellido1 ||' '|| p1.apellido2 "Profesor1",
       p2.nombre ||' '|| p2.apellido1 ||' '|| p2.apellido2 "Profesor2"
from profesores p1,profesores p2
where p1.id<p2.id
      and (p1.id,p2.id) not in(select i1.profesor,i2.profesor
                                from impartir i1
                                join impartir i2 on i1.asignatura=i2.asignatura);


/*22.Mostrar los nombres de asignaturas que no tienen dos alumnos matriculados del mismo municipio.*/
select a.nombre
from asignaturas a
where a.codigo not in (select m1.asignatura
                        from matricular m1
                        join matricular m2 on m1.asignatura=m2.asignatura
                        join alumnos al1 on al1.dni=m1.alumno
                        join alumnos al2 on al2.dni=m2.alumno
                        where al1.dni < al2.dni 
                              and al1.cmun=al2.cmun);
                        

/* La 23 y 24 no dan el resultado pedido */


/*23. Listar los alumnos matriculados en alguna asignatura que no esté impartida por el profesor de mayor
edad. No sacar duplicados.*/
select distinct m.alumno 
from matricular m 
natural join impartir i
where i.profesor not in (select id 
                         from profesores 
                         where fecha_nacimiento in (select min(fecha_nacimiento) 
                                                    from profesores));
                                                                             



/*24. Visualizar aquellos alumnos matriculados en más de dos asignaturas a los que no les dé clase ningún
profesor del departamento de 'Matematica Aplicada'.*/
select m.alumno 
from matricular m 
where m.alumno not in(select m.alumno 
                     from matricular m
                     natural join impartir i
                     join profesores p on i.profesor=p.id
                     join departamentos d on p.departamento=d.codigo
                     where d.nombre='Matematica Aplicada')
group by m.alumno
having count(m.alumno) > 2;

select * from sol_3_24;

--Para quien quiera los enunciados de la 25 a la 30.

/*25. Visualizar la asignatura de más créditos de cada departamento entre aquellas no impartidas por un
profesor nacido antes de 1970.


select codigo, departamento
from asignaturas
where (creditos, departamento) IN
                                (select max(creditos), departamento
                                from asignaturas 
                                where codigo not in 
                                                    (select asignatura 
                                                    from impartir i join profesores p on(i.profesor = p.id)
                                                    where p.fecha_nacimiento < '01/01/1970')
                               group by departamento)
and  codigo not in 
                    (select asignatura 
                     from impartir i join profesores p on(i.profesor = p.id)
                     where p.fecha_nacimiento < '01/01/1970');



26. Listar por orden de carga de créditos aquellos departamentos que tengan matriculados más de diez
alumnos (en cualquiera de sus asignaturas).

select DEPARTAMENTO, SUM(CREDITOS) from(

select a.departamento,a.creditos
from asignaturas a
join matricular m on a.codigo=m.asignatura
group by a.codigo,a.departamento,a.creditos
having count(m.alumno) > 10)
group by DEPARTAMENTO ;

27. Visualizar el número total de alumnos que posee cada profesor (si un alumno está matriculado en
varias asignaturas de un profesor, contará varias veces), pero sólo de aquellos profesores que
impartan alguna asignatura en la que el número de créditos prácticos es superior al de teóricos.
28. De las asignaturas con más de 3 alumnos en el curso 15/16, visualizar el nombre del alumno más
veterano (con la fecha de la primera matrícula más antigua).
29. De cada asignatura con menos de 16 alumnos matriculados en el curso 15/16 e impartida por el
departamento más antiguo (con la menor fecha de creación), visualizar el nombre de la asignatura y
el número de profesores que la imparte en el curso 15/16.
30. Visualizar por cada profesor que imparte al menos 2 asignaturas, a aquéllos que tienen a algún
alumno nacido antes del año 1995.*/





