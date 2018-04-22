/*==============================================================*/
/* DBMS name:      Sybase AS Anywhere 9                         */
/* Created on:     4/10/2006 3:00:29 PM                         */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_METRICAS_RELATIONS_PRODUCTO') then
    alter table METRICAS_PRODUCTO
       delete foreign key FK_METRICAS_RELATIONS_PRODUCTO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_METRICAS_RELATIONS_MATERIA_') then
    alter table METRICAS_PRODUCTO
       delete foreign key FK_METRICAS_RELATIONS_MATERIA_
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PERSONA_RELATIONS_TIPO_PER') then
    alter table PERSONA
       delete foreign key FK_PERSONA_RELATIONS_TIPO_PER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUCTO_RELATIONS_TIPO_PRO') then
    alter table PRODUCTOS
       delete foreign key FK_PRODUCTO_RELATIONS_TIPO_PRO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUCTO_RELATIONS_MARCAS') then
    alter table PRODUCTOS
       delete foreign key FK_PRODUCTO_RELATIONS_MARCAS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PRODUCTO_RELATIONS_BODEGA') then
    alter table PRODUCTOS
       delete foreign key FK_PRODUCTO_RELATIONS_BODEGA
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RELATIONSHIP_4_FK'
     and t.table_name='METRICAS_PRODUCTO'
) then
   drop index METRICAS_PRODUCTO.RELATIONSHIP_4_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RELATIONSHIP_7_FK'
     and t.table_name='METRICAS_PRODUCTO'
) then
   drop index METRICAS_PRODUCTO.RELATIONSHIP_7_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RELATIONSHIP_1_FK'
     and t.table_name='PERSONA'
) then
   drop index PERSONA.RELATIONSHIP_1_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='RELATIONSHIP_5_FK'
     and t.table_name='PRODUCTOS'
) then
   drop index PRODUCTOS.RELATIONSHIP_5_FK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='BODEGA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table BODEGA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='MARCAS'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table MARCAS
end if;

if exists(
   select 1 from sys.systable 
   where table_name='MATERIA_PRIMA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table MATERIA_PRIMA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='METRICAS_PRODUCTO'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table METRICAS_PRODUCTO
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PERSONA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PERSONA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='PRODUCTOS'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table PRODUCTOS
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TIPO_PERSONA'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TIPO_PERSONA
end if;

if exists(
   select 1 from sys.systable 
   where table_name='TIPO_PRODUCTO'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table TIPO_PRODUCTO
end if;

/*==============================================================*/
/* Table: BODEGA                                                */
/*==============================================================*/
create table BODEGA 
(
    CODIGO_BODEGA        varchar(10)                    not null,
    DESCRIPCION_BODEGA   long varchar,
    USUARIO_CARGO        varchar(50),
    FECHA_CREACION       date,
    ESTADO_BODEGA        integer,
    constraint PK_BODEGA primary key (CODIGO_BODEGA)
);

/*==============================================================*/
/* Table: MARCAS                                                */
/*==============================================================*/
create table MARCAS 
(
    CODIGO_MARCAS        varchar(20)                    not null,
    DESCRIPCION_MARCA    long varchar,
    CASA_FABRICANTE      long varchar,
    constraint PK_MARCAS primary key (CODIGO_MARCAS)
);

/*==============================================================*/
/* Table: MATERIA_PRIMA                                         */
/*==============================================================*/
create table MATERIA_PRIMA 
(
    CODIGO_MATERIA_PRIMA varchar(10)                    not null,
    DETALLE_MATERIA_PRIMA long varchar,
    TIPO_MATERIA         varchar(50),
    ESTADO_MATERIA       integer,
    VALOR_COMPRA_MATERIA decimal(5,2),
    VALOR_VENTA_MATERIA  decimal(5,2),
    CANTIDAD_MATERIA     integer,
    constraint PK_MATERIA_PRIMA primary key (CODIGO_MATERIA_PRIMA)
);

/*==============================================================*/
/* Table: METRICAS_PRODUCTO                                     */
/*==============================================================*/
create table METRICAS_PRODUCTO 
(
    CODIGO_METRICAS      integer                        not null,
    CODIGO_PRODUCTO      varchar(20),
    CODIGO_MATERIA_PRIMA varchar(10),
    DESCRIPCION_METRICA  varchar(50),
    UNIDAD_MEDIDA        varchar(20),
    COLOR                varchar(50),
    VALOR_UNIDAD         decimal(4,2),
    PESO_EXACTO          decimal(5,2),
    CANTIDAD_METRICA     integer,
    constraint PK_METRICAS_PRODUCTO primary key (CODIGO_METRICAS)
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_4_FK on METRICAS_PRODUCTO (
CODIGO_PRODUCTO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_7_FK on METRICAS_PRODUCTO (
CODIGO_MATERIA_PRIMA ASC
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA 
(
    CEDULA               varchar(20)                    not null,
    CODIGO_TIPO_PERSONA  integer,
    RUC_PERSONA          varchar(20),
    NOMBRE               varchar(50),
    APELLIDO_PATERNO     varchar(50),
    APELLIDO_MATERNO     varchar(50),
    DIRECCION_VIVIENDA   long varchar,
    DIRECCION_TRABAJO    long varchar,
    CIUDAD_ESTABLECIMIENTO varchar(50),
    RAZON_SOCIAL         varchar(100),
    TELEFONO_CASA        varchar(10),
    TELEFONO_EMPRESA     varchar(10),
    FAX_EMPRESA          varchar(10),
    IMAGEN_PERSONA       long binary,
    EMAIL                varchar(50),
    SITIO_WEB            varchar(50),
    REFERENCIA_1         varchar(80),
    REFERENCIA_2         char(80),
    REFERENCIA_3         varchar(80),
    TELEFONOR_1          varchar(10),
    TELEFONOR_2          varchar(10),
    TELEFONOR_3          varchar(10),
    ESTADO_PERSONA       integer,
    constraint PK_PERSONA primary key (CEDULA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on PERSONA (
CODIGO_TIPO_PERSONA ASC
);

/*==============================================================*/
/* Table: PRODUCTOS                                             */
/*==============================================================*/
create table PRODUCTOS 
(
    CODIGO_PRODUCTO      varchar(20)                    not null,
    CODIGO_MARCAS        varchar(20),
    CODIGO_BODEGA        varchar(10),
    CODIGO_TIPO_PRODUCTO varchar(20),
    DETALLE_PRODUCTO     long varchar,
    OBSERVACION_PRODUCTO long varchar,
    ESTADO_PRODUCTO      integer,
    ESTADO2_PRODUCTO     integer,
    VALOR_COMPRA         decimal(5,2),
    VALOR_VENTA          decimal(5,2),
    CANTIDAD             integer,
    SERIAL_PRODUCTO      varchar(50),
    CODIGO_PARTE         varchar(50),
    TIEMPO_VIDA_UTIL     integer,
    IMAGEN_PRODUCTO      long binary,
    FECHA_COMPRA         date,
    FECHA_VENTA          date,
    CODIGO_ALTERNO       varchar(20),
    constraint PK_PRODUCTOS primary key (CODIGO_PRODUCTO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on PRODUCTOS (
CODIGO_MARCAS ASC
);

/*==============================================================*/
/* Table: TIPO_PERSONA                                          */
/*==============================================================*/
create table TIPO_PERSONA 
(
    CODIGO_TIPO_PERSONA  integer                        not null,
    DESCRIPCION_TIPO_PERSONA varchar(50),
    constraint PK_TIPO_PERSONA primary key (CODIGO_TIPO_PERSONA)
);

/*==============================================================*/
/* Table: TIPO_PRODUCTO                                         */
/*==============================================================*/
create table TIPO_PRODUCTO 
(
    CODIGO_TIPO_PRODUCTO varchar(20)                    not null,
    DESCRIPCION_TIPO_PRODUCTO long varchar,
    ESTADO_TIPO_PRODUCTO integer,
    constraint PK_TIPO_PRODUCTO primary key (CODIGO_TIPO_PRODUCTO)
);

alter table METRICAS_PRODUCTO
   add constraint FK_METRICAS_RELATIONS_PRODUCTO foreign key (CODIGO_PRODUCTO)
      references PRODUCTOS (CODIGO_PRODUCTO)
      on update restrict
      on delete restrict;

alter table METRICAS_PRODUCTO
   add constraint FK_METRICAS_RELATIONS_MATERIA_ foreign key (CODIGO_MATERIA_PRIMA)
      references MATERIA_PRIMA (CODIGO_MATERIA_PRIMA)
      on update restrict
      on delete restrict;

alter table PERSONA
   add constraint FK_PERSONA_RELATIONS_TIPO_PER foreign key (CODIGO_TIPO_PERSONA)
      references TIPO_PERSONA (CODIGO_TIPO_PERSONA)
      on update restrict
      on delete restrict;

alter table PRODUCTOS
   add constraint FK_PRODUCTO_RELATIONS_TIPO_PRO foreign key (CODIGO_PRODUCTO)
      references TIPO_PRODUCTO (CODIGO_TIPO_PRODUCTO)
      on update restrict
      on delete restrict;

alter table PRODUCTOS
   add constraint FK_PRODUCTO_RELATIONS_MARCAS foreign key (CODIGO_MARCAS)
      references MARCAS (CODIGO_MARCAS)
      on update restrict
      on delete restrict;

alter table PRODUCTOS
   add constraint FK_PRODUCTO_RELATIONS_BODEGA foreign key (CODIGO_PRODUCTO)
      references BODEGA (CODIGO_BODEGA)
      on update restrict
      on delete restrict;

