--Nombre de las tablas a las que tengo acceso sin ser dueño
select table_name 
from all_tables
where owner!=user;

--Devolver tipo y longitud del dato de columna de la tabla matricular del usuario docencia
select data_type, data_length 
from all_tab_columns
where owner='DOCENCIA'
and table_name='MATRICULAR'
and column_name='CALIFICACION';

--Clave primaria de Matricular
select column_name
from all_constraints c
join all_cons_columns cc on (c.owner=cc.owner
                             and c.constraint_name=cc.constraint_name)
where c.owner='DOCENCIA'
and c.table_name='MATRICULAR'
and constraint_type='P';

--Obtener nombre clave primaria de departamentos
select constraint_name
from all_constraints
where owner='DOCENCIA'
and table_name='DEPARTAMENTOS'
and constraint_type='P';

select *
from all_constraints
where owner='DOCENCIA'
and table_name='PROFESORES';

--DML3 Eje.23

select distinct alumno 
from matricular m 
join impartir i on m.asignatura=i.asignatura
                   and m.curso = i.curso
                   and m.grupo = i.grupo
where i.profesor not in (select id
                        from profesores 
                        where fecha_nacimiento in(select min(fecha_nacimiento) 
                                                  from profesores));
select * from sol_3_23;

--DML Eje.24
select alumno 
from matricular
group by alumno
having count(distinct asignatura)>2
       and alumno not in(select alumno 
                         from matricular m
                         natural join impartir i 
                         join profesores p on i.profesor=p.id
                         join departamentos d on p.departamento=d.codigo
and d.nombre='Matematica Aplicada');
                         
select * from sol_3_24;

--Para saber si esta bien la solución se hace (A-B) U (B-A) = Conjunto vacio


