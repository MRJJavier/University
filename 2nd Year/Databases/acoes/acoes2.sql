CREATE TABLE proveedor(
    c�digo                VARCHAR2(10) NOT NULL,
    nombre_proveedor   VARCHAR2(50) NOT NULL,
    ident__proveedor   NUMBER NOT NULL,
    observaciones         VARCHAR2(100),
    nombre_responsable    VARCHAR2(50) NOT NULL,
    ident__responsable    NUMBER,
    tipo_proveedor     VARCHAR2(50) NOT NULL,
    num__cuenta           NUMBER,
    c�digo1               NUMBER NOT NULL
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( c�digo );

CREATE TABLE casa_populorum (
    c�digo   NUMBER NOT NULL
);

ALTER TABLE casa_populorum ADD CONSTRAINT casa_populorum_pk PRIMARY KEY ( c�digo );

CREATE TABLE contabilidad (
    n_orden_pago           NUMBER NOT NULL,
    fecha                   DATE NOT NULL,
    cod__proveedor       VARCHAR2(10) NOT NULL,
    proveedor            VARCHAR2(50) NOT NULL,
    cod__de_servicio        NUMBER NOT NULL,
    concepto                VARCHAR2(50),
    importe                 NUMBER NOT NULL,
    donante_codigo         NUMBER NOT NULL,
    proveedor_c�digo     VARCHAR2(10) NOT NULL,
    socio_numero_de_socio   NUMBER NOT NULL,
    proyecto_c�digo         NUMBER NOT NULL,
    tipo_centro_c�digo      NUMBER NOT NULL
);

ALTER TABLE contabilidad ADD CONSTRAINT contabilidad_pk PRIMARY KEY ( n_orden_pago );

CREATE TABLE donante(
    codigo                   NUMBER NOT NULL,
    nombre              DATE NOT NULL,
    descripci�n         VARCHAR2(50) NOT NULL,
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

ALTER TABLE donante ADD CONSTRAINT donante_pk PRIMARY KEY ( codigo);

CREATE TABLE "Beneficiario" (
    "N�mero/C�digo"          NUMBER NOT NULL,
    nombre                   VARCHAR2(50) NOT NULL,
    apellidos                VARCHAR2(50) NOT NULL,
    estado                   VARCHAR2(50),
    beca                     NUMBER,
    sexo                     VARCHAR2(6),
    agente                   VARCHAR2(50),
    "Foto_ni�o/joven"        BLOB NOT NULL,
    fecha_nacimiento         DATE NOT NULL,
    fecha_entrada_acoes      DATE,
    proyecto_donde_act�a     VARCHAR2(50),
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
    tipo_centro_c�digo       NUMBER NOT NULL
);

ALTER TABLE "Beneficiario" ADD CONSTRAINT "Beneficiario_PK" PRIMARY KEY ( "N�mero/C�digo" );

CREATE TABLE personal_asociaci�n (
    c�digo                NUMBER NOT NULL,
    nombre                VARCHAR2(50) NOT NULL,
    apellidos             CHAR(50),
    fecha_nacimiento      NUMBER,
    cargo                 VARCHAR2(50) NOT NULL,
    descripci�n           VARCHAR2(100),
    a�os_en_el_proyecto   NUMBER,
    tipo_centro_c�digo    NUMBER NOT NULL
);

ALTER TABLE personal_asociaci�n ADD CONSTRAINT personal_asociaci�n_pk PRIMARY KEY ( c�digo );

CREATE TABLE proyecto (
    c�digo                      NUMBER NOT NULL,
    nombre_de_la_cuenta         VARCHAR2(50) NOT NULL,
    "%_Reparto_Combustible"     NUMBER,
    "%_Reparto_Mantenimiento"   NUMBER,
    "%_Reparto_Contenedor"      NUMBER,
    descripci�n                 VARCHAR2(100),
    tipo_centro_c�digo          NUMBER NOT NULL
);

ALTER TABLE proyecto ADD CONSTRAINT proyecto_pk PRIMARY KEY ( c�digo );

CREATE TABLE socio (
    numero_de_socio       NUMBER NOT NULL,
    nombre                VARCHAR2(50) NOT NULL,
    apellidos             VARCHAR2(50) NOT NULL,
    estado                VARCHAR2(50),
    nif                   NUMBER NOT NULL,
    direcci�n             VARCHAR2(50) NOT NULL,
    poblaci�n             VARCHAR2(50),
    "C.P_"                NUMBER,
    provincia             VARCHAR2(50),
    tel�fono_fijo         NUMBER,
    tel�fono_m�vil        NUMBER,
    correo_electr�nico    VARCHAR2(50) NOT NULL,
    agente                VARCHAR2(50),
    relaci�n              VARCHAR2(50),
    "Certificado_S�/No"   VARCHAR2(2),
    sector                VARCHAR2(50),
    fecha_alta            DATE,
    fecha_baja            DATE,
    observaciones         VARCHAR2(100)
);

ALTER TABLE socio ADD CONSTRAINT socio_pk PRIMARY KEY ( numero_de_socio );

CREATE TABLE tipo_centro (
    c�digo                       NUMBER NOT NULL,
    nombre                       VARCHAR2(50) NOT NULL,
    direcci�n                    VARCHAR2(50) NOT NULL,
    "C.P_"                       NUMBER NOT NULL,
    fecha_inicio                 DATE NOT NULL,
    inversi�n                    NUMBER,
    personal_asociaci�n_c�digo   NUMBER NOT NULL,
    aforo                        NUMBER NOT NULL
);

CREATE UNIQUE INDEX tipo_centro__idx ON
    tipo_centro (
        personal_asociaci�n_c�digo
    ASC );

ALTER TABLE tipo_centro ADD CONSTRAINT tipo_centro_pk PRIMARY KEY ( c�digo );

ALTER TABLE casa_populorum
    ADD CONSTRAINT casa_populorum_proyecto_fk FOREIGN KEY ( c�digo )
        REFERENCES proyecto ( c�digo );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_proveedor_fk FOREIGN KEY ( proveedor_c�digo )
        REFERENCES proveedor ( c�digo );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_donante_fk FOREIGN KEY ( donante_codigo )
        REFERENCES donante ( codigo );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_proyecto_fk FOREIGN KEY ( proyecto_c�digo )
        REFERENCES proyecto ( c�digo );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_socio_fk FOREIGN KEY ( socio_numero_de_socio )
        REFERENCES socio ( numero_de_socio );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_tipo_centro_fk FOREIGN KEY ( tipo_centro_c�digo )
        REFERENCES tipo_centro ( c�digo );

ALTER TABLE "Beneficiario"
    ADD CONSTRAINT "Beneficiario_Socio_FK" FOREIGN KEY ( socio_numero_de_socio )
        REFERENCES socio ( numero_de_socio );

ALTER TABLE "Beneficiario"
    ADD CONSTRAINT "Beneficiario_Socio_FKv2" FOREIGN KEY ( socio_numero_de_socio1 )
        REFERENCES socio ( numero_de_socio );

ALTER TABLE "Beneficiario"
    ADD CONSTRAINT "Beneficiario_Tipo_centro_FK" FOREIGN KEY ( tipo_centro_c�digo )
        REFERENCES tipo_centro ( c�digo );

ALTER TABLE personal_asociaci�n
    ADD CONSTRAINT per_as_t_centro_fk FOREIGN KEY ( tipo_centro_c�digo )
        REFERENCES tipo_centro ( c�digo );

ALTER TABLE proyecto
    ADD CONSTRAINT proyecto_tipo_centro_fk FOREIGN KEY ( tipo_centro_c�digo )
        REFERENCES tipo_centro ( c�digo );

ALTER TABLE tipo_centro
    ADD CONSTRAINT t_centro_per_as_fk FOREIGN KEY ( personal_asociaci�n_c�digo )
        REFERENCES personal_asociaci�n ( c�digo );