CREATE TABLE beneficiario (
    código                VARCHAR2(10) PRIMARY KEY,
    nombre_beneficiario   VARCHAR2(50) NOT NULL,
    ident__beneficiario   NUMBER NOT NULL,
    observaciones         VARCHAR2(100),
    nombre_responsable    VARCHAR2(50) NOT NULL,
    ident__responsable    NUMBER,
    tipo_beneficiario     VARCHAR2(50) NOT NULL,
    num__cuenta           NUMBER,
    código1               NUMBER NOT NULL
);



CREATE TABLE casa_populorum (
    código   NUMBER NOT NULL
);

ALTER TABLE casa_populorum ADD CONSTRAINT casa_populorum_pk PRIMARY KEY ( código );

CREATE TABLE contabilidad (
    nº_orden_pago           NUMBER NOT NULL,
    fecha                   DATE NOT NULL,
    cod__beneficiario       VARCHAR2(10) NOT NULL,
    beneficiario            VARCHAR2(50) NOT NULL,
    cod__de_servicio        NUMBER NOT NULL,
    concepto                VARCHAR2(50),
    importe                 NUMBER NOT NULL,
    donación_nombre         DATE NOT NULL,
    beneficiario_código     VARCHAR2(10) NOT NULL,
    socio_numero_de_socio   NUMBER NOT NULL,
    proyecto_código         NUMBER NOT NULL,
    tipo_centro_código      NUMBER NOT NULL
);

ALTER TABLE contabilidad ADD CONSTRAINT contabilidad_pk PRIMARY KEY ( nº_orden_pago );

CREATE TABLE donación (
    nombre              DATE NOT NULL,
    descripción         VARCHAR2(50) NOT NULL,
    procedencia         VARCHAR2(50) NOT NULL,
    ingreso_euros       NUMBER,
    egreso_euros        NUMBER,
    ingreso_lempiras    NUMBER,
    egreso_lempiras     NUMBER,
    ingreso_dolares     NUMBER,
    egreso_dolares      NUMBER,
    total_lempiras      NUMBER,
    ingreso_material    VARCHAR2(50),
    cantidad_material   NUMBER
);

ALTER TABLE donación ADD CONSTRAINT donación_pk PRIMARY KEY ( nombre );

CREATE TABLE "Niño/Joven" (
    "Número/código"          NUMBER NOT NULL,
    nombre                   VARCHAR2(50) NOT NULL,
    apellidos                VARCHAR2(50) NOT NULL,
    estado                   VARCHAR2(50),
    beca                     NUMBER,
    sexo                     VARCHAR2(6),
    agente                   VARCHAR2(50),
    "Foto_Niño/Joven"        BLOB NOT NULL,
    fecha_nacimiento         DATE NOT NULL,
    fecha_entrada_acoes      DATE,
    proyecto_donde_actua     VARCHAR2(50),
    fecha_alta_proyecto      DATE,
    fecha_salida_proyecto    DATE,
    fecha_alta               DATE,
    fecha_salida_acoes       DATE,
    grado_curso              NUMBER,
    colonia_procedencia      VARCHAR2(50),
    colonia_en_la_que_vive   VARCHAR2(50),
    observaciones            VARCHAR2(100),
    socio_numero_de_socio    NUMBER NOT NULL,
    socio_numero_de_socio1   NUMBER NOT NULL,
    tipo_centro_código       NUMBER NOT NULL
);

ALTER TABLE "Niño/Joven" ADD CONSTRAINT "Niño/Joven_PK" PRIMARY KEY ( "Número/código" );

CREATE TABLE personal_asociación (
    código                NUMBER NOT NULL,
    nombre                VARCHAR2(50) NOT NULL,
    apellidos             CHAR(50),
    fecha_nacimiento      NUMBER,
    cargo                 VARCHAR2(50) NOT NULL,
    descripción           VARCHAR2(100),
    años_en_el_proyecto   NUMBER,
    tipo_centro_código    NUMBER NOT NULL
);

ALTER TABLE personal_asociación ADD CONSTRAINT personal_asociación_pk PRIMARY KEY ( código );

CREATE TABLE proyecto (
    código                      NUMBER NOT NULL,
    nombre_de_la_cuenta         VARCHAR2(50) NOT NULL,
    "%_Reparto_Combustible"     NUMBER,
    "%_Reparto_Mantenimiento"   NUMBER,
    "%_Reparto_Contenedor"      NUMBER,
    descripción                 VARCHAR2(100),
    tipo_centro_código          NUMBER NOT NULL
);

ALTER TABLE proyecto ADD CONSTRAINT proyecto_pk PRIMARY KEY ( código );

CREATE TABLE socio (
    numero_de_socio       NUMBER NOT NULL,
    nombre                VARCHAR2(50) NOT NULL,
    apellidos             VARCHAR2(50) NOT NULL,
    estado                VARCHAR2(50),
    nif                   NUMBER NOT NULL,
    dirección             VARCHAR2(50) NOT NULL,
    población             VARCHAR2(50),
    "C.P_"                NUMBER,
    provincia             VARCHAR2(50),
    telefono_fijo         NUMBER,
    telefono_móvil        NUMBER,
    correo_electrónico    VARCHAR2(50) NOT NULL,
    agente                VARCHAR2(50),
    relación              VARCHAR2(50),
    "Certificado_Sí­/No"   VARCHAR2(2),
    sector                VARCHAR2(50),
    fecha_alta            DATE,
    fecha_baja            DATE,
    observaciones         VARCHAR2(100)
);

ALTER TABLE socio ADD CONSTRAINT socio_pk PRIMARY KEY ( numero_de_socio );

CREATE TABLE tipo_centro (
    código                       NUMBER NOT NULL,
    nombre                       VARCHAR2(50) NOT NULL,
    dirección                    VARCHAR2(50) NOT NULL,
    "C.P_"                       NUMBER NOT NULL,
    fecha_inicio                 DATE NOT NULL,
    inversión                   NUMBER
--  ERROR: Datatype UNKNOWN is not allowed 
    ,
    personal_asociación_código   NUMBER NOT NULL,
    aforo                        NUMBER NOT NULL
);

CREATE UNIQUE INDEX tipo_centro__idx ON
    tipo_centro (
        personal_asociación_código
    ASC );

ALTER TABLE tipo_centro ADD CONSTRAINT tipo_centro_pk PRIMARY KEY ( código );




-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             1
-- ALTER TABLE                             33
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   5
-- WARNINGS                                 0

