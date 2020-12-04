/*Mostrar nombre, primer apellido y nombre de municipio de aquellos alumnos que viven en las provincias de badajoz o cordoba.*/
select a.nombre, a.apellido1, m.nombre
from alumnos a join provincia p on(a.cpro = p.codigo)
join municipio m on(a.cmun = m.cmun and m.cpro = p.codigo)
where p.nombre = 'Badajoz' or p.nombre = 'Córdoba';

/*Para cada profesor (deben aparecer todos) mostrar id de profesor y numero de tramos de investigacion que tiene. En caso de no tener tramos debe aparecer 0.*/
select p.id, nvl(i.tramos,0)
from profesores p
left outer join investigadores i on p.id=i.id_profesor;

/*Parejasd de profesores qie comparten telefono. Si no tienen telefono se considera que el telefono es el mismo y deben emparejarse tambien. De cada profesor solo queremos el Apellido1. No muestre informacion duplicada.*/
select p1.Apellido1, p2.Apellido2, p1.telefono
from profesores p1, profesores p2
where p1.id < p2.id  and  (p1.telefono = p2.telefono or (p1.telefono is null and p2.telefono is null));

/*Listar dni y fecha de nacimiento de los tres alumnos de mayor edad que estan registrados en el sistema y no estan matriculados en ninguna asignatura. Los alumnos sin fecha de nacimiento no se tendran en cuenta.*/
select dni, fecha_nacimiento
from (select al.dni, al.fecha_nacimiento from alumnos al
where al.dni not in (select m.alumno from matricular m)
and al.fecha_nacimiento is not null
order by al.fecha_nacimiento)
where rownum < 4;

/*Nombre completo de los profesores que han impartido la asignatura que mas alumnos ha tenido matriculados, pero teniendo en cuenta solamente aquellas asignaturas con menos de 25 alumnos matriculados. Si un alumno se ha matriculado varias veces en la asignatura debe contarse solo una vez.*/

select p.nombre || ' ' || p.apellido1 || ' ' || p.apellido2 as Nombre_Completo
from profesores p
join impartir i on p.id=i.profesor
where i.asignatura in (select asignatura from(
                        select m.asignatura 
                        from matricular m
                        group by m.asignatura
                        having count(distinct m.alumno) < 25
                        order by count(distinct m.alumno) desc)
                        where rownum=1);

/*Queremos obtener la distribucion en genero de cada asignatura en cada curso academico (el de la tabla matricular). Obtenga el nombre de la asignatura, el curso academico, el numero de alumnos y alumnas matriculados.*/
select a.nombre, m.curso, sum(decode(al.genero,'MASC',1,'FEM',0)) as NumAlunmos,sum(decode(al.genero,'MASC',0,'FEM',1)) as NumAlunmas 
from matricular m
join alumnos al on m.alumno=al.dni
join asignaturas a on a.codigo=m.asignatura
group by a.nombre,m.curso;

/*Queremos obtener cuantos alumnos se matricularon por primera vez (fecha_prim_matricula) en cada uno de los meses del año, pero solo de aquellos meses en los que haya mas alumnos que la media.*/


select upper(to_char(al.fecha_prim_matricula,'month')) as NombreMes, count(to_char(al.fecha_prim_matricula,'month')) as NumAlum
from alumnos al
group by upper(to_char(al.fecha_prim_matricula,'month'))
having  count(to_char(al.fecha_prim_matricula,'month')) > (select count(a.fecha_prim_matricula)/12 from alumnos a);
