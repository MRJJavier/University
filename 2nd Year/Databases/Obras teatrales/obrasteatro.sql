
-- NO LEA ESTE ESQUEMA.
-- COPIE TODO Y LANCELO A SU ESQUEMA ORACLE


/***********************
*                      *
*        FASE 2        *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *

*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *

*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
*                      *
************************/




CREATE TABLE FUNDACION (
NOMBRE_COMPANIA VARCHAR2 (12) not null,
PAIS_COMPANIA  VARCHAR2 (12) not null,
CIUDAD_COMPANIA VARCHAR2 (12) not null,
MULTINACIONAL NUMBER(5) not null,
NOMBRE_FUNDACION VARCHAR2 (20) not null,
CIUDAD_FUNDACION VARCHAR2(12) NOT NULL,
PAIS_FUNDACION VARCHAR2 (12)  not null,
NACIMIENTO NUMBER(4) not null );




INSERT INTO FUNDACION VALUES ('Vivendi','Francia','Paris',1,'Teatro Vivendi', 'MADRID','ESPA„A', 1994);
INSERT INTO FUNDACION VALUES ('Coca Cola','EEUU','Atlanta',1,'Festo Cola', 'VERONA','ITALIA', 1990);
INSERT INTO FUNDACION VALUES ('O et C','Francia','Nantes',0,'Teatro Residual', 'ROMA','ITALIA', 1999);
INSERT INTO FUNDACION VALUES ('Nestle','Suiza','Berna',1, 'Choco Teatro','MADRID','ESPA„A',2000);




CREATE TABLE FUNDACION_GRUPO(
FUNDACION VARCHAR2 (20) ,
GRUPO VARCHAR2 (12) ,
primary key (FUNDACION,GRUPO));

INSERT INTO FUNDACION_GRUPO VALUES ('Teatro Vivendi','VERONESES');
INSERT INTO FUNDACION_GRUPO VALUES ('Teatro Vivendi','PHOGO');
INSERT INTO FUNDACION_GRUPO VALUES ('Teatro Residual','ELS LLOGLARS');
INSERT INTO FUNDACION_GRUPO VALUES ('Festo Cola','ROTACIONES');



CREATE TABLE PATROCINIO (
NOMBRE_FUNDACION VARCHAR2(20),
NOMBRE_GRUPO VARCHAR2(12) ,
TIPO_RELACION VARCHAR2(1),
INICIO NUMBER(4),
FINAL  NUMBER(4) ,
foreign key(NOMBRE_FUNDACION,NOMBRE_GRUPO) references FUNDACION_GRUPO);




INSERT INTO PATROCINIO VALUES ('Teatro Vivendi','VERONESES','C',1995,1996);
INSERT INTO PATROCINIO VALUES ('Teatro Vivendi','PHOGO','C',1996,1998);
INSERT INTO PATROCINIO VALUES ('Teatro Residual','ELS LLOGLARS','B',2000,null);
INSERT INTO PATROCINIO VALUES ('Festo Cola','ROTACIONES','X',1991,1998);
INSERT INTO PATROCINIO VALUES ('Festo Cola','ROTACIONES','X',2000,null);





Commit;