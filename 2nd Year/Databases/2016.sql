/*Mueste el nombre y apellidos de los alumnos que sí tienen correo electrónico y tienen menos de 27 años. El 
nombre y apellidos muéstrelos poniendo la primera letra de cada palabra en mayúsculas. Utilice para ello 
INITCAP. Mueste también la edad sin decimales */

select initcap(al.nombre), initcap(al.apellido1), initcap(al.apellido2), trunc(months_between(sysdate,al.fecha_nacimiento)/12) as Edad
from alumnos al
where al.email is not null and trunc(months_between(sysdate,al.fecha_nacimiento)/12) < 27;

/*Se ha decidido realizar un homenaje a los profesores que llevan más de 20 años trabajando. Para ello 
necesitamos saber el nombre y apellidos además del primer viernes que haya después del aniversario de su 
entrada. Use la función NEXT_DAY. Por ejemplo, si un profesor entró el 24/01/62 deberá aparecer la fecha 
29/01/16*/

select p.nombre, p.apellido1, p.apellido2, 
next_day(to_date(to_char(p.antiguedad,'dd/mm/')||to_char(sysdate,'yy')),'Viernes')  from profesores p
where trunc(months_between(sysdate,p.antiguedad)/12) > 20;

/*Queremos obtener los 3 alumnos con mejor nota media, pero solo de aquellos alumnos que tengan más de
una asignatura aprobada. Para calcular la nota media use DECODE y considere AP=1, NT=2, SB=3 y MH=4. No
sume los suspensos ni los no presentados. Redondee la nota a 2 decimales.*/
select nombre,apellido1,apellido2, nota
from(
select al.nombre, al.apellido1, al.apellido2, round(sum(decode(m.calificacion,'AP',1,'NT',2,'SB',3,'MH',4,null))/count(m.alumno),2) as Nota from matricular m
join alumnos al on m.alumno=al.dni
where m.calificacion in ('AP','NT','SB','MH')
group by al.nombre, al.apellido1, al.apellido2
having  count(*)>1
order by round(sum(decode(m.calificacion,'AP',1,'NT',2,'SB',3,'MH',4,null))/count(m.alumno),2) desc
)
where rownum <= 3;

/* Muestre parejas de profesor y alumno al que le de clase, cuyo nombre y primer apellido comiencen con la
misma letra. Es decir, el nombre del profesor y el del alumno comienzan con la misma letra y lo mismo
ocurre con su apellido. Tenga en cuenta asignatura y turno */

select p.nombre, p.apellido1, a.nombre, a.apellido1 
from profesores p
join impartir i on i.profesor=p.id,
alumnos a join matricular m on m.alumno=a.dni
where m.asignatura=i.asignatura and m.grupo=i.grupo 
and substr(p.nombre,1,1)=substr(a.nombre,1,1)
and substr(p.apellido1,1,1)=substr(a.apellido1,1,1);

/*
Muestre el código y el nombre de parejas de asignaturas donde haya matriculados el mismo número de
alumnos distintos. No muestre información duplicada y excluya aquellas asignaturas donde no se ha
matriculado ningún alumno
*/
select a1.codigo,a1.nombre,a2.codigo,a2.nombre
from asignaturas a1, asignaturas a2
where a1.codigo < a2.codigo and
(select count(distinct m1.alumno) from matricular m1 where m1.asignatura=a1.codigo)=
(select count(distinct m2.alumno) from matricular m2 where m2.asignatura=a2.codigo) and
(select count(distinct m1.alumno) from matricular m1 where m1.asignatura=a1.codigo) !=0;

/*Mostrar por cada departamento el profesor de más edad, pero solo teniendo en cuenta a aquellos que no
imparten clase a ningún alumno nacido en los 90*/

select d.nombre, p.nombre,p.apellido1,p.apellido2 from profesores p
join departamentos d on d.codigo=p.departamento
where (p.departamento,p.fecha_nacimiento) in(select p.departamento,min(p.fecha_nacimiento)
                                            from profesores p
                                            where p.id not in (select i.profesor from impartir i
                                                                natural join matricular m
                                                                join alumnos al on m.alumno=al.dni
                                                                where al.fecha_nacimiento between '01/01/1990' and '31/12/1999')
                                            group by p.departamento);









