/*
Para cada profesor (deben aparecer todos) mostrar id de profesor y n�mero de tramos de investigaci�n que tiene. El n�mero de tramos se encuentra en la tabla INVESTIGADORES. En caso de no tener tramos  debe aparecer 0
*/

select p.id, NVL(i.tramos,0) as TRAMOS
from profesores p
left outer join investigadores i on p.id=i.id_profesor;

/*
Parejas de profesores que comparten tel�fono. Si no tienen tel�fono se considera que el tel�fono es el mismo y deben emparejarse tambi�n. De cada profesor solo queremos el Apellido1.  No muestre informaci�n duplicada.
*/

select p1.apellido1 as Apellido1_profesor1, p2.apellido1 as Apellido1_profesor2, p1.telefono 
from profesores p1, profesores p2
where p1.id < p2.id 
and ((p1.telefono = p2.telefono) 
     or (p1.telefono is null 
         and p2.telefono is null));
         
/*

Listar dni y fecha de nacimiento de los tres alumnos de mayor edad que est�n registrados en el sistema y no est�n matriculados en ninguna asignatura. Los alumnos sin fecha de nacimiento no
se tendr�n en cuenta
*/
select dni, fecha_nacimiento as Fecha
from (select al.dni, al.fecha_nacimiento 
      from alumnos al
      where al.dni not in (select dni from matricular m)
      order by fecha_nacimiento)
where rownum <=3;

/*
Nombre completo de los profesores que han impartido la asignatura que m�s alumnos ha tenido matriculados, pero teniendo en cuenta solamente aquellas asignaturas con menos de 25 alumnos matriculados. Si un alumno se ha matriculado varias veces en la asignatura debe contarse s�lo una vez.
*/

select distinct p.nombre || ' ' || p.apellido1 || ' ' || p.apellido2 as Nombre_Completo 
from profesores p
join impartir i on p.id=i.profesor
where i.asignatura in(select asignatura 
                      from( select m.asignatura
                            from matricular m 
                            group by m.asignatura
                            having  (count(distinct alumno) < 25)
                            order by count(distinct alumno) desc)
                      where rownum=1);

/*
Queremos obtener la distribuci�n en g�nero de cada asignatura en cada curso acad�mico (el de la tabla matricular). Obtenga el nombre de la asignatura, el curso acad�mico, el n�mero de alumnos y el n�mero de alumnas matriculados
*/


select a.nombre, m.curso, sum(decode(al.genero,'MASC',1,'FEM',0)) "NumAlumnos", sum(decode(al.genero,'MASC',0,'FEM',1)) "NumAlumnas" 
from matricular m
join alumnos al on al.dni=m.alumno
join asignaturas a on m.asignatura=a.codigo
group by a.nombre, m.curso;

/*
Queremos obtener cu�ntos alumnos se matricularon por primera vez (FECHA_PRIM_MATRICULA) en cada uno de los meses del a�o, pero solo de aquellos meses en los que haya m�s alumnos que la media
*/

select to_char(al.fecha_prim_matricula,'month') as NombreMes , count(to_char(al.fecha_prim_matricula)) as NumAlumnos from alumnos al
group by to_char(al.fecha_prim_matricula,'month')
having count(al.fecha_prim_matricula) > (select count(al.fecha_prim_matricula)/12 from alumnos al);

select to_char(FECHA_PRIM_MATRICULA,'MONTH'), count(*) from alumnos
group by to_char(FECHA_PRIM_MATRICULA,'MONTH')
having count (*) > (select avg(count(*)) from alumnos
group by to_char(FECHA_PRIM_MATRICULA,'MONTH'));

