CREATE TABLE proveedor(
    código                VARCHAR2(10) NOT NULL,
    nombre_proveedor   VARCHAR2(50) NOT NULL,
    ident__proveedor   NUMBER NOT NULL,
    observaciones         VARCHAR2(100),
    nombre_responsable    VARCHAR2(50) NOT NULL,
    ident__responsable    NUMBER,
    tipo_proveedor     VARCHAR2(50) NOT NULL,
    num__cuenta           NUMBER,
    código1               NUMBER NOT NULL
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( código );

CREATE TABLE casa_populorum (
    código   NUMBER NOT NULL
);

ALTER TABLE casa_populorum ADD CONSTRAINT casa_populorum_pk PRIMARY KEY ( código );

CREATE TABLE contabilidad (
    n_orden_pago           NUMBER NOT NULL,
    fecha                   DATE NOT NULL,
    cod__proveedor       VARCHAR2(10) NOT NULL,
    proveedor            VARCHAR2(50) NOT NULL,
    cod__de_servicio        NUMBER NOT NULL,
    concepto                VARCHAR2(50),
    importe                 NUMBER NOT NULL,
    donante_codigo         NUMBER NOT NULL,
    proveedor_código     VARCHAR2(10) NOT NULL,
    socio_numero_de_socio   NUMBER NOT NULL,
    proyecto_código         NUMBER NOT NULL,
    tipo_centro_código      NUMBER NOT NULL
);

ALTER TABLE contabilidad ADD CONSTRAINT contabilidad_pk PRIMARY KEY ( n_orden_pago );

CREATE TABLE donante(
    codigo                   NUMBER NOT NULL,
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

ALTER TABLE donante ADD CONSTRAINT donante_pk PRIMARY KEY ( codigo);

CREATE TABLE "Beneficiario" (
    "Número/Código"          NUMBER NOT NULL,
    nombre                   VARCHAR2(50) NOT NULL,
    apellidos                VARCHAR2(50) NOT NULL,
    estado                   VARCHAR2(50),
    beca                     NUMBER,
    sexo                     VARCHAR2(6),
    agente                   VARCHAR2(50),
    "Foto_niño/joven"        BLOB NOT NULL,
    fecha_nacimiento         DATE NOT NULL,
    fecha_entrada_acoes      DATE,
    proyecto_donde_actúa     VARCHAR2(50),
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

ALTER TABLE "Beneficiario" ADD CONSTRAINT "Beneficiario_PK" PRIMARY KEY ( "Número/Código" );

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
    teléfono_fijo         NUMBER,
    teléfono_móvil        NUMBER,
    correo_electrónico    VARCHAR2(50) NOT NULL,
    agente                VARCHAR2(50),
    relación              VARCHAR2(50),
    "Certificado_Sí/No"   VARCHAR2(2),
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
    inversión                    NUMBER,
    personal_asociación_código   NUMBER NOT NULL,
    aforo                        NUMBER NOT NULL
);

CREATE UNIQUE INDEX tipo_centro__idx ON
    tipo_centro (
        personal_asociación_código
    ASC );

ALTER TABLE tipo_centro ADD CONSTRAINT tipo_centro_pk PRIMARY KEY ( código );

ALTER TABLE casa_populorum
    ADD CONSTRAINT casa_populorum_proyecto_fk FOREIGN KEY ( código )
        REFERENCES proyecto ( código );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_proveedor_fk FOREIGN KEY ( proveedor_código )
        REFERENCES proveedor ( código );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_donante_fk FOREIGN KEY ( donante_codigo )
        REFERENCES donante ( codigo );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_proyecto_fk FOREIGN KEY ( proyecto_código )
        REFERENCES proyecto ( código );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_socio_fk FOREIGN KEY ( socio_numero_de_socio )
        REFERENCES socio ( numero_de_socio );

ALTER TABLE contabilidad
    ADD CONSTRAINT contabilidad_tipo_centro_fk FOREIGN KEY ( tipo_centro_código )
        REFERENCES tipo_centro ( código );

ALTER TABLE "Beneficiario"
    ADD CONSTRAINT "Beneficiario_Socio_FK" FOREIGN KEY ( socio_numero_de_socio )
        REFERENCES socio ( numero_de_socio );

ALTER TABLE "Beneficiario"
    ADD CONSTRAINT "Beneficiario_Socio_FKv2" FOREIGN KEY ( socio_numero_de_socio1 )
        REFERENCES socio ( numero_de_socio );

ALTER TABLE "Beneficiario"
    ADD CONSTRAINT "Beneficiario_Tipo_centro_FK" FOREIGN KEY ( tipo_centro_código )
        REFERENCES tipo_centro ( código );

ALTER TABLE personal_asociación
    ADD CONSTRAINT per_as_t_centro_fk FOREIGN KEY ( tipo_centro_código )
        REFERENCES tipo_centro ( código );

ALTER TABLE proyecto
    ADD CONSTRAINT proyecto_tipo_centro_fk FOREIGN KEY ( tipo_centro_código )
        REFERENCES tipo_centro ( código );

ALTER TABLE tipo_centro
    ADD CONSTRAINT t_centro_per_as_fk FOREIGN KEY ( personal_asociación_código )
        REFERENCES personal_asociación ( código );