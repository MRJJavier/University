--------------------------------------------------------
-- Archivo creado  - martes-noviembre-27-2018  
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CANDIDATO
--------------------------------------------------------
 
  CREATE TABLE "CANDIDATO"
   (    "DNI" VARCHAR2(9 BYTE),
    "NOMBRE" VARCHAR2(50 BYTE),
    "APELLIDOS" VARCHAR2(50 BYTE),
    "ORDENLISTA" NUMBER,
    "PARTIDO" VARCHAR2(50 BYTE),
    "ID" NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Table MITIN
--------------------------------------------------------
 
  CREATE TABLE "MITIN"
   (    "PROVINCIA" VARCHAR2(50 BYTE),
    "CANDIDATO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Table PARTIDO
--------------------------------------------------------
 
  CREATE TABLE "PARTIDO"
   (    "NOMBRE" VARCHAR2(50 BYTE),
    "SIGLAS" VARCHAR2(10 BYTE),
    "ESLOGAN" VARCHAR2(100 BYTE),
    "PRESIDENTE" VARCHAR2(100 BYTE),
    "PROVINCIAS" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Table RESULTADOS2015
--------------------------------------------------------
 
  CREATE TABLE "RESULTADOS2015"
   (    "NUMERO" NUMBER,
    "ID" NUMBER(2,0),
    "PARTIDO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Table VOTANTE
--------------------------------------------------------
 
  CREATE TABLE "VOTANTE"
   (    "DNI" VARCHAR2(9 BYTE),
    "NOMBRE" VARCHAR2(50 BYTE),
    "APELLIDOS" VARCHAR2(50 BYTE),
    "PROVINCIA" VARCHAR2(50 BYTE),
    "REPRESENTANTELEGAL" VARCHAR2(9 BYTE)
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Table VOTANTEPORCORREO
--------------------------------------------------------
 
  CREATE TABLE "VOTANTEPORCORREO"
   (    "NOMBRE" VARCHAR2(50 BYTE),
    "APELLIDOS" VARCHAR2(50 BYTE),
    "PAIS" VARCHAR2(50 BYTE),
    "REGION" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "TS_ALUMNOS" ;
REM INSERTING INTO CANDIDATO
SET DEFINE OFF;
INSERT INTO CANDIDATO (DNI,NOMBRE,APELLIDOS,ORDENLISTA,PARTIDO,ID) VALUES ('11111111A','Alberto Carlos','Huevos','1','Los viejos','1');
INSERT INTO CANDIDATO (DNI,NOMBRE,APELLIDOS,ORDENLISTA,PARTIDO,ID) VALUES ('11111112B','Lola','Mento','2','Los viejos','1');
INSERT INTO CANDIDATO (DNI,NOMBRE,APELLIDOS,ORDENLISTA,PARTIDO,ID) VALUES ('11111113C','Victor','Mento','1','Los viejos','1');
REM INSERTING INTO MITIN
SET DEFINE OFF;
INSERT INTO MITIN (PROVINCIA,CANDIDATO) VALUES ('Jaen','11111113C');
INSERT INTO MITIN (PROVINCIA,CANDIDATO) VALUES ('Malaga','11111111A');
INSERT INTO MITIN (PROVINCIA,CANDIDATO) VALUES ('Sevilla','11111111A');
REM INSERTING INTO PARTIDO
SET DEFINE OFF;
INSERT INTO PARTIDO (NOMBRE,SIGLAS,ESLOGAN,PRESIDENTE,PROVINCIAS) VALUES ('Los viejos','LSS','Tambi��robamos','El simple','Malaga');
INSERT INTO PARTIDO (NOMBRE,SIGLAS,ESLOGAN,PRESIDENTE,PROVINCIAS) VALUES ('Los morados','LM','Robar y arruinar','La de los pelos','Malaga');
INSERT INTO PARTIDO (NOMBRE,SIGLAS,ESLOGAN,PRESIDENTE,PROVINCIAS) VALUES ('Los nuevos','LN','Nos toca robar','Uno Mas','Sevilla');
INSERT INTO PARTIDO (NOMBRE,SIGLAS,ESLOGAN,PRESIDENTE,PROVINCIAS) VALUES ('Los de siempre','LDS','Seguimos robando','La del raton','Sevilla');
REM INSERTING INTO RESULTADOS2015
SET DEFINE OFF;
REM INSERTING INTO VOTANTE
SET DEFINE OFF;
INSERT INTO VOTANTE (DNI,NOMBRE,APELLIDOS,PROVINCIA,REPRESENTANTELEGAL) VALUES ('11111111A','Alberto Carlos','Huevos','Malaga',NULL);
INSERT INTO VOTANTE (DNI,NOMBRE,APELLIDOS,PROVINCIA,REPRESENTANTELEGAL) VALUES ('11111112B','Lola','Mento','Malaga',NULL);
INSERT INTO VOTANTE (DNI,NOMBRE,APELLIDOS,PROVINCIA,REPRESENTANTELEGAL) VALUES ('11111113C','Victor','Mento','Malaga',NULL);
INSERT INTO VOTANTE (DNI,NOMBRE,APELLIDOS,PROVINCIA,REPRESENTANTELEGAL) VALUES ('21111114C','Aitor','Tilla','Sevilla',NULL);
INSERT INTO VOTANTE (DNI,NOMBRE,APELLIDOS,PROVINCIA,REPRESENTANTELEGAL) VALUES ('22111114D','Alba','��guarra','Jaen',NULL);
INSERT INTO VOTANTE (DNI,NOMBRE,APELLIDOS,PROVINCIA,REPRESENTANTELEGAL) VALUES ('22167114F','Armando','Adistancia','Huelva',NULL);
REM INSERTING INTO VOTANTEPORCORREO
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index CANDIDATO_PK
--------------------------------------------------------
 
  CREATE UNIQUE INDEX "CANDIDATO_PK" ON "CANDIDATO" ("DNI")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Index MITIN_PK
--------------------------------------------------------
 
  CREATE UNIQUE INDEX "MITIN_PK" ON "MITIN" ("PROVINCIA", "CANDIDATO")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Index SYS_C00616306
--------------------------------------------------------
 
  CREATE UNIQUE INDEX "SYS_C00616306" ON "PARTIDO" ("NOMBRE")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Index VOTANTE_PK
--------------------------------------------------------
 
  CREATE UNIQUE INDEX "VOTANTE_PK" ON "VOTANTE" ("DNI")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  DDL for Index VOTANTEPORCORREO_PK
--------------------------------------------------------
 
  CREATE UNIQUE INDEX "VOTANTEPORCORREO_PK" ON "VOTANTEPORCORREO" ("NOMBRE", "APELLIDOS")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "TS_ALUMNOS" ;
--------------------------------------------------------
--  Constraints for Table CANDIDATO
--------------------------------------------------------
 
  ALTER TABLE "CANDIDATO" ADD CONSTRAINT "CANDIDATO_PK" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS"  ENABLE;
 
  ALTER TABLE "CANDIDATO" MODIFY ("DNI" NOT NULL ENABLE);
 
  ALTER TABLE "CANDIDATO" MODIFY ("NOMBRE" NOT NULL ENABLE);
 
  ALTER TABLE "CANDIDATO" MODIFY ("APELLIDOS" NOT NULL ENABLE);
 
  ALTER TABLE "CANDIDATO" MODIFY ("PARTIDO" NOT NULL ENABLE);
 
  ALTER TABLE "CANDIDATO" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MITIN
--------------------------------------------------------
 
  ALTER TABLE "MITIN" ADD CONSTRAINT "MITIN_PK" PRIMARY KEY ("PROVINCIA", "CANDIDATO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS"  ENABLE;
 
  ALTER TABLE "MITIN" MODIFY ("PROVINCIA" NOT NULL ENABLE);
 
  ALTER TABLE "MITIN" MODIFY ("CANDIDATO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTIDO
--------------------------------------------------------
 
  ALTER TABLE "PARTIDO" MODIFY ("SIGLAS" NOT NULL ENABLE);
 
  ALTER TABLE "PARTIDO" MODIFY ("PRESIDENTE" NOT NULL ENABLE);
 
  ALTER TABLE "PARTIDO" ADD PRIMARY KEY ("NOMBRE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table RESULTADOS2015
--------------------------------------------------------
 
  ALTER TABLE "RESULTADOS2015" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "RESULTADOS2015" MODIFY ("PARTIDO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table VOTANTE
--------------------------------------------------------
 
  ALTER TABLE "VOTANTE" MODIFY ("DNI" NOT NULL ENABLE);
 
  ALTER TABLE "VOTANTE" MODIFY ("NOMBRE" NOT NULL ENABLE);
 
  ALTER TABLE "VOTANTE" MODIFY ("PROVINCIA" NOT NULL ENABLE);
 
  ALTER TABLE "VOTANTE" ADD CONSTRAINT "VOTANTE_PK" PRIMARY KEY ("DNI")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_ALUMNOS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table VOTANTEPORCORREO
--------------------------------------------------------
 
  ALTER TABLE "VOTANTEPORCORREO" MODIFY ("NOMBRE" NOT NULL ENABLE);
 
  ALTER TABLE "VOTANTEPORCORREO" MODIFY ("PAIS" NOT NULL ENABLE);
 
  ALTER TABLE "VOTANTEPORCORREO" ADD CONSTRAINT "VOTANTEPORCORREO_PK" PRIMARY KEY ("NOMBRE", "APELLIDOS")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOCOMPRESS LOGGING
  TABLESPACE "TS_ALUMNOS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESULTADOS2015
--------------------------------------------------------
 
  ALTER TABLE "RESULTADOS2015" ADD CONSTRAINT "RESULTADOS2015_PARTIDO_FK" FOREIGN KEY ("PARTIDO")
      REFERENCES "PARTIDO" ("NOMBRE") ENABLE;