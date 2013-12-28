--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.7
-- Dumped by pg_dump version 9.3.0
-- Started on 2013-12-13 08:44:40 BOT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 29835)
-- Name: apoyo; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA apoyo;


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA apoyo; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA apoyo IS 'Este esquema lo creo rogerex el 5 de julio del 2011 con motivos de mejoramiento del sistema de apoyo administrativo. ';


--
-- TOC entry 897 (class 2612 OID 29838)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- TOC entry 263 (class 1255 OID 29839)
-- Name: nueva_actividad(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nueva_actividad() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 actividad%TYPE;
mi_tabla2 proyecto%TYPE;
mi_tabla3 persona%TYPE

BEGIN

-- Comprueba que se proporcionan el codido de la actividad, codigo del proyecto, el codigo de la persona 

NEW.cod_actividad := upper(NEW.cod_actividad);
NEW.cod_proyecto := upper(NEW.cod_proyecto);
NEW.cod_persona := upper(NEW.cod_persona);

SELECT INTO mi_tabla2 * FROM proyecto WHERE cod_proyecto= NEW.cod_proyecto;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de proyecto no es valido por que no existe  ';
END IF;

SELECT INTO mi_tabla3 * FROM persona WHERE cod_persona= NEW.cod_persona;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de persona no es valido por que no existe  ';
END IF;

IF NEW.cod_actividad !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Actividad no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_proyecto !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo del proyecto no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_persona !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de la persona no esta en el rango A-Z/0-9';
END IF;

IF NEW.nombre_actividad ISNULL OR NEW.nombre_actividad !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La actividad debe tener un nombre';
END IF;

IF NEW.descripcion_actividad ISNULL OR NEW.descripcion_actividad !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La actividad debe tener una descripcion';
END IF;

IF NEW.estado_actividad ISNULL THEN
RAISE EXCEPTION 'La estado no debe ser nulo actividad debe contener si/no';
END IF;

END;
$_$;


--
-- TOC entry 264 (class 1255 OID 29840)
-- Name: nueva_persona(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nueva_persona() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 persona%TYPE;
mi_tabla2 rol%TYPE;

BEGIN

NEW.cod_persona := upper(NEW.cod_persona);
NEW.cod_rol := upper(NEW.cod_rol);

SELECT INTO mi_tabla2 * FROM rol WHERE cod_rol= NEW.cod_rol;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de rol no es valido por que no existe  ';
END IF;

IF NEW.cod_persona !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Persona no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_rol !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de rol no esta en el rango A-Z/0-9';
END IF;

IF NEW.nombre_persona ISNULL OR NEW.nombre_persona !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La persona debe tener un nombre';
END IF;

IF NEW.apellido_pat_persona ISNULL OR NEW.apellido_pat_persona !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La persona debe tener un apellido';
END IF;

IF NEW.apellido_mat_persona ISNULL OR NEW.apellido_mat_persona !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La persona debe tener un apellido';
END IF;

IF NEW.sexo_persona ISNULL OR NEW.sexo_persona !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La persona debe tener un sexo';
END IF;

IF NEW.direccion_persona ISNULL OR NEW.direccion_persona !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La persona debe tener un domicilio';
END IF;

END;
$_$;


--
-- TOC entry 265 (class 1255 OID 29841)
-- Name: nueva_tarea(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nueva_tarea() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 tarea%TYPE;
mi_tabla2 actividad%TYPE;
mi_tabla3 persona%TYPE;

BEGIN

NEW.cod_actividad := upper(NEW.cod_actividad);
NEW.cod_tarea := upper(NEW.cod_tarea);
NEW.cod_persona := upper(NEW.cod_persona);

SELECT INTO mi_tabla2 * FROM actividad WHERE cod_actividad= NEW.cod_actividad;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de proyecto no es valido por que no existe  ';
END IF;

SELECT INTO mi_tabla3 * FROM persona WHERE cod_persona= NEW.cod_persona;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de persona no es valido por que no existe  ';
END IF;

IF NEW.cod_tarea !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de tarea no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_actividad !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de actividad no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_persona !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de la persona no esta en el rango A-Z/0-9';
END IF;

IF NEW.nombre_tarea ISNULL OR NEW.nombre_tarea !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La tarea debe tener un nombre';
END IF;

IF NEW.descripcion_tarea ISNULL OR NEW.descripcion_tarea !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La tarea debe tener una descripcion';
END IF;

IF NEW.estado_tarea ISNULL THEN
RAISE EXCEPTION 'La tarea no debe ser nulo actividad debe contener si/no';
END IF;

END;
$_$;


--
-- TOC entry 266 (class 1255 OID 29842)
-- Name: nuevo_contrato(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_contrato() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 contrato%TYPE;
mi_tabla2 persona%TYPE

BEGIN

-- Comprueba que se proporcionan el codido de la persona

NEW.cod_contrato := upper(NEW.cod_actividad);
NEW.cod_persona := upper(NEW.cod_persona);

SELECT INTO mi_tabla2 * FROM persona WHERE cod_persona= NEW.cod_persona;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de persona no es valido por que no existe  ';
END IF;

IF NEW.cod_contrato !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Contraato no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_persona !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de persona no esta en el rango A-Z/0-9';
END IF;

IF NEW.jornal_hora ISNULL OR NEW.jornal_hora !~ '^[0-9]*$' OR NEW.jornal_hora>0 THEN
RAISE EXCEPTION 'Debe tener un monto a pagar pr hora';
END IF;

END;
$_$;


--
-- TOC entry 267 (class 1255 OID 29843)
-- Name: nuevo_crono_ejec(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_crono_ejec() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 cronograma_ejecutado%TYPE;
mi_tabla2 actividad%TYPE;

BEGIN

NEW.cod_crono_ejecutado := upper(NEW.cod_actividad);
NEW.cod_actividad := upper(NEW.cod_actividad);

SELECT INTO mi_tabla2 * FROM actividad WHERE cod_actividad= NEW.cod_actividad;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de la actividad no es valido por que no existe  ';
END IF;

IF NEW.cod_crono_ejecutado !~ '^[z-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Cronograma no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_ctividad !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Actividad no esta en el rango A-Z/0-9';
END IF;

IF NEW.nombre_crono_ejecutado ISNULL OR NEW.nombre_crono_ejecutado !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'El cronograma debe tener un nombre';
END IF;

END;
$_$;


--
-- TOC entry 268 (class 1255 OID 29844)
-- Name: nuevo_crono_planif(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_crono_planif() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 cronograma_planificado%TYPE;
mi_tabla2 actividad%TYPE;

BEGIN

NEW.cod_crono_planificado := upper(NEW.cod_actividad);
NEW.cod_actividad := upper(NEW.cod_actividad);

SELECT INTO mi_tabla2 * FROM actividad WHERE cod_actividad= NEW.cod_actividad;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de la actividad no es valido por que no existe  ';
END IF;

IF NEW.cod_crono_planificado !~ '^[z-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Cronograma no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_actividad !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Actividad no esta en el rango A-Z/0-9';
END IF;

IF NEW.nombre_crono_planificado ISNULL OR NEW.nombre_crono_planificado !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'El cronograma debe tener un nombre';
END IF;

IF NEW.duracion_crono_planificado ISNULL OR NEW.duracion_crono_planificado !~ '^[0-9]*$' OR NEW.duracion_crono_planificado>0 THEN
RAISE EXCEPTION 'El cronograma debe tener un nombre';
END IF;

END;
$_$;


--
-- TOC entry 269 (class 1255 OID 29845)
-- Name: nuevo_estado_finan(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_estado_finan() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 estado_finan%TYPE;
mi_tabla2 tarea%TYPE;

BEGIN

NEW.cod_estado_finan := upper(NEW.cod_estado_finan);
NEW.cod_tarea := upper(NEW.cod_tarea);

SELECT INTO mi_tabla2 * FROM tarea WHERE cod_tarea= NEW.cod_tarea;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de Tarea no es valido por que no existe  ';
END IF;

IF NEW.cod_estado_finan !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Estado Financiero no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_tarea !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo del Tarea no esta en el rango A-Z/0-9';
END IF;

IF NEW.descripcion_estado_finan ISNULL OR NEW.descripcion_estado_finan !~ '^[A-Za-z]*$' THEN 
RAISE EXCEPTION 'La descripcion debe contener un texto explicatorio';
END IF;

IF NEW.observaciones_estado_finan ISNULL OR NEW.observaciones_estado_finan !~ '^[A-Za-z]*$' THEN 
RAISE EXCEPTION 'Debe tener una observacion';
END IF;

IF NEW.monto_observado ISNULL OR NEW.monto_observado !~ '^[0-9]*$' OR NEW.monto_observado>0 THEN
RAISE EXCEPTION 'Debe existir un monto observado mayor a cero';
END IF;


END;
$_$;


--
-- TOC entry 270 (class 1255 OID 29846)
-- Name: nuevo_estado_tec(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_estado_tec() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 estado_tecnico%TYPE;
mi_tabla2 tarea%TYPE;

BEGIN

NEW.cod_estado_tec := upper(NEW.cod_estado_tec);
NEW.cod_tarea := upper(NEW.cod_tarea);

SELECT INTO mi_tabla2 * FROM tarea WHERE cod_tarea= NEW.cod_tarea;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de Tarea no es valido por que no existe  ';
END IF;

IF NEW.cod_estado_tec !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Estado Tecnico no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_tarea !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo del Tarea no esta en el rango A-Z/0-9';
END IF;

IF NEW.descripcion_estado_tec ISNULL OR NEW.descripcion_estado_tec !~ '^[A-Za-z]*$' THEN 
RAISE EXCEPTION 'La descripcion debe contener un texto explicatorio';
END IF;

IF NEW.observaciones_estado_tec ISNULL OR NEW.observaciones_estado_tec !~ '^[A-Za-z]*$' THEN 
RAISE EXCEPTION 'Debe tener una observacion';
END IF;

END;
$_$;


--
-- TOC entry 271 (class 1255 OID 29847)
-- Name: nuevo_proyecto(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_proyecto() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$


BEGIN

IF NEW.cod_proyecto !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de el Proyecto  no esta en el rango A-Z/0-9';
END IF;

IF NEW.nombre_proyecto ISNULL OR NEW.nombre_proyecto !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'El proyecto  debe tener un nombre';
END IF;

IF NEW.objetivo_proyecto ISNULL OR NEW.objetivo_proyecto !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'El proyecto debe tener un objetivo';
END IF;

IF NEW.presupuesto_proyecto ISNULL OR NEW.presupuesto_proyecto !~ '^[0-9]*$' NEW.presupuesto_proyecto>0 THEN
RAISE EXCEPTION 'El proyecto debe tener un presupuesto,el monto del presupesto debe contener un numero mayor a cero';
END IF;


END;
$_$;


--
-- TOC entry 272 (class 1255 OID 29848)
-- Name: nuevo_recurso_mat_asig(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_recurso_mat_asig() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 recurso_eco_mat_asig%TYPE;
mi_tabla2 finan_material%TYPE;
mi_tabla3 atividad%TYPE;

BEGIN

NEW.cod_rec_mat_asig := upper(NEW.cod_rec_mat_asig);
NEW.cod_finan_material := upper(NEW.cod_finan_material);
NEW.cod_actividad := upper(NEW.cod_actividad);

SELECT INTO mi_tabla2 * FROM finan_material WHERE cod_finan_material= NEW.cod_finan_material;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de la financiamiento material no es valido por que no existe  ';
END IF;

SELECT INTO mi_tabla3 * FROM actividad WHERE cod_actividad= NEW.cod_actividad;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de actividad no es valido por que no existe  ';
END IF;

IF NEW.cod_rec_mat_asig !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Recuro material asignado no esta en el rango A-Z/0-9';
END IF;

IF NEW.descripcion_rec_mat_asig !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'La descripcion del recurso material asignado no esta en el rango A-Z/0-9';
END IF;

IF NEW.cantidad_estimada_rec_mat_asig ISNULL OR NEW.cantidad_estimada_rec_mat_asig !~ '^[0-9]*$' NEW.cantidad_estimada_rec_mat_asig>0 THEN
RAISE EXCEPTION 'El monto del recurso material estimado  no debe ser nulo, debe contener un numero mayor a cero';
END IF;

IF NEW.cantidad_utilizada_rec_mat_asig ISNULL OR NEW.cantidad_utilizada_rec_mat_asig !~ '^[0-9]*$' NEW.cantidad_utilizada_rec_mat_asig>0 THEN
RAISE EXCEPTION 'El monto del recurso material utilizado  no debe ser nulo, debe contener un numero mayor a cero';
END IF;


END;
$_$;


--
-- TOC entry 273 (class 1255 OID 29849)
-- Name: nuevo_rol(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_rol() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

BEGIN

IF NEW.cod_rol !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Rol no esta en el rango A-Z/0-9';
END IF;

IF NEW.cargo ISNULL OR NEW.cargo !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La persona debe tener un cargo';
END IF;

END;
$_$;


--
-- TOC entry 274 (class 1255 OID 29850)
-- Name: nuevo_salario(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_salario() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 salario%TYPE;
mi_tabla2 contrato%TYPE;

BEGIN

NEW.cod_salario := upper(NEW.cod_salario);
NEW.cod_contrato := upper(NEW.cod_contrato);

SELECT INTO mi_tabla2 * FROM contrato WHERE cod_contrato= NEW.cod_contrato;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo del contrato no es valido por que no existe  ';
END IF;

IF NEW.cod_salario !~ '^[z-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de salario no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_contrato !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de Contrato no esta en el rango A-Z/0-9';
END IF;

IF NEW.horas_trab_salario ISNULL OR NEW.NEW.horas_trab_salario !~ '^[0-9]*$' NEW.horas_trab_salario>0 THEN
RAISE EXCEPTION 'Las horas deben ser mayores a cero';
END IF;

IF NEW.sueldo total_salario ISNULL OR NEW.NEW.sueldo_total_salaio !~ '^[0-9]*$' NEW.sueldo_total_salario_trab_salario>0 THEN
RAISE EXCEPTION 'Las horas deben ser mayores a cero';
END IF;

IF NEW.total_descuentos_salario ISNULL OR NEW.total_descuentos_salario !~ '^[0-9]*$' OR NEW.total_descuentos_salario>0 THEN
RAISE EXCEPTION 'El descuento debe tener un monto';
END IF;

IF NEW.liquido_pagable_salario ISNULL OR NEW.liquido_pagable_salario !~ '^[0-9]*$' OR NEW.liquido_pagable_salario>0 THEN
RAISE EXCEPTION 'El descuento debe tener un numero';
END IF;

END;
$_$;


--
-- TOC entry 275 (class 1255 OID 29851)
-- Name: nuevo_usuario(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION nuevo_usuario() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$

DECLARE

mi_tabla1 usuario%TYPE;
mi_tabla2 persona%TYPE;

BEGIN

NEW.cod_usuario := upper(NEW.cod_actividad);
NEW.cod_persona := upper(NEW.cod_persona);

SELECT INTO mi_tabla2 * FROM persona WHERE cod_persona= NEW.cod_persona;
IF NOT FOUND THEN
RAISE EXCEPTION 'El codigo de persona no es valido por que no existe  ';
END IF;

IF NEW.cod_usuario !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de usuario no esta en el rango A-Z/0-9';
END IF;

IF NEW.cod_persona !~ '^[a-z0-9]*$' THEN
RAISE EXCEPTION 'El codigo de la persona no esta en el rango A-Z/0-9';
END IF;

IF NEW.usuario ISNULL OR NEW.usuario !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'el usuario debe tener un nombre';
END IF;

IF NEW.contrasena ISNULL OR NEW.NEW.contrasena !~ '^[A-Za-z]*$' THEN
RAISE EXCEPTION 'La contrasena no debe ser nulo';
END IF;

END;
$_$;


SET search_path = apoyo, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 141 (class 1259 OID 29852)
-- Name: variable; Type: TABLE; Schema: apoyo; Owner: -; Tablespace: 
--

CREATE TABLE variable (
    id_variable integer NOT NULL,
    nombre_variable character varying(64) NOT NULL,
    valor_variable character varying(64) NOT NULL
);


SET search_path = public, pg_catalog;

--
-- TOC entry 142 (class 1259 OID 29855)
-- Name: actividad; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE actividad (
    codigo character varying(15) NOT NULL,
    nombre character varying(200),
    estado character varying(15),
    fk_cargo character varying(15)
);


--
-- TOC entry 143 (class 1259 OID 29858)
-- Name: adhonorem; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adhonorem (
    codigo character varying(15) NOT NULL,
    ci character varying(15) NOT NULL,
    cod_sis character varying(15),
    nombre character varying(50) NOT NULL,
    ape_paterno character varying(40) NOT NULL,
    ape_materno character varying(40),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 144 (class 1259 OID 29862)
-- Name: adhonorem_ext; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adhonorem_ext (
    fk_adhonorem character varying(15) NOT NULL,
    email character varying(150),
    telefono character varying(35)
);


--
-- TOC entry 145 (class 1259 OID 29865)
-- Name: autoridad; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE autoridad (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(100) NOT NULL,
    ape_materno character varying(100),
    sexo character varying(5),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    ini_gestion date DEFAULT ('now'::text)::date,
    fin_gestion date,
    fk_cargo character varying(15),
    titulo character varying(20),
    grado_firma character varying(20)
);


--
-- TOC entry 146 (class 1259 OID 29870)
-- Name: aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aux (
    codigo character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    ape_pat character varying(40) NOT NULL,
    ape_mat character varying(40),
    ci character varying(20),
    gestion1 character varying(8),
    gestion2 character varying(8),
    tipo integer DEFAULT 0,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    fecha_estado date DEFAULT ('now'::text)::date
);


--
-- TOC entry 147 (class 1259 OID 29876)
-- Name: auxiliar; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auxiliar (
    codigo character varying(15) NOT NULL,
    ci character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    ape_paterno character varying(40) NOT NULL,
    ape_materno character varying(40),
    tipo character varying(25) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 148 (class 1259 OID 29879)
-- Name: auxiliar_ext; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auxiliar_ext (
    fk_auxiliar character varying(15) NOT NULL,
    email character varying(150),
    telefono character varying(35)
);


--
-- TOC entry 149 (class 1259 OID 29882)
-- Name: auxiliatura; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auxiliatura (
    codigo character varying(15) NOT NULL,
    docencia character varying(10),
    investigacion character varying(10),
    laboratorio character varying(10),
    interaccion character varying(10),
    servicios character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 150 (class 1259 OID 29885)
-- Name: bibliografia; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bibliografia (
    codigo character varying(15) NOT NULL,
    nombre_autor character varying(150) NOT NULL,
    titulo character varying(150) NOT NULL,
    editorial character varying(100),
    detalles character varying(180),
    fk_programa character varying(15)
);


--
-- TOC entry 151 (class 1259 OID 29888)
-- Name: car_adh; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE car_adh (
    codigo character varying(15) NOT NULL,
    gestion character varying(10) NOT NULL,
    fk_adhonorem character varying(15) NOT NULL,
    fk_cargo character varying(15) NOT NULL,
    fecha_mod date DEFAULT ('now'::text)::date,
    estado character varying(15)
);


--
-- TOC entry 152 (class 1259 OID 29892)
-- Name: car_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE car_aux (
    codigo character varying(15) NOT NULL,
    gestion character varying(10) NOT NULL,
    fk_auxiliar character varying(15) NOT NULL,
    fk_cargo character varying(15) NOT NULL,
    estado character varying(10),
    fecha_mod date DEFAULT ('now'::text)::date,
    carga_horaria character varying(20)
);


--
-- TOC entry 153 (class 1259 OID 29896)
-- Name: cargo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cargo (
    codigo character varying(15) NOT NULL,
    nombre character varying(150) NOT NULL,
    tipo character varying(15),
    carga_horaria character varying(15) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    fk_laboratorio character varying(15)
);


--
-- TOC entry 154 (class 1259 OID 29900)
-- Name: carrera; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE carrera (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    sigla character varying(20) NOT NULL,
    facultad character varying(150),
    depto character varying(100)
);


--
-- TOC entry 155 (class 1259 OID 29903)
-- Name: carta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE carta (
    codigo character varying(15) NOT NULL,
    cod_archivo character varying(15),
    fecha date DEFAULT ('now'::text)::date,
    fk_estandarc character varying(15)
);


--
-- TOC entry 156 (class 1259 OID 29907)
-- Name: carta_dest; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE carta_dest (
    fk_docente character varying(15),
    fk_destinatario character varying(15),
    fk_carta character varying(15)
);


--
-- TOC entry 157 (class 1259 OID 29910)
-- Name: catalogo_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE catalogo_curso (
    codigo character varying(6) NOT NULL,
    curso character varying(100) NOT NULL,
    fk_categoria_curso character varying(6) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 158 (class 1259 OID 29914)
-- Name: categoria_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categoria_aux (
    codigo character varying(15) NOT NULL,
    interno character varying(10),
    titular character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 159 (class 1259 OID 29917)
-- Name: categoria_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categoria_curso (
    codigo character varying(6) NOT NULL,
    nombre character varying(100) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 160 (class 1259 OID 29921)
-- Name: categoria_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categoria_doc (
    codigo character varying(15) NOT NULL,
    interno character varying(10),
    invitado character varying(10),
    asistentea character varying(10),
    adjuntob character varying(10),
    catedraticoc character varying(10),
    fk_nombra_doc character varying(15)
);


--
-- TOC entry 161 (class 1259 OID 29924)
-- Name: certificado; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE certificado (
    codigo character varying(15) NOT NULL,
    fecha_emis date DEFAULT ('now'::text)::date,
    fk_aux character varying(15),
    fk_autoridad character varying(15)
);


--
-- TOC entry 162 (class 1259 OID 29928)
-- Name: combo_box; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE combo_box (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character varying(10)
);


--
-- TOC entry 163 (class 1259 OID 29931)
-- Name: cprol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cprol (
    codigo character varying(9) NOT NULL,
    nombre character varying(35) NOT NULL,
    descripcion character varying(60),
    estado character varying(10) NOT NULL
);


--
-- TOC entry 164 (class 1259 OID 29934)
-- Name: cproles_usuario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cproles_usuario (
    fk_codigo_usr character varying(10) NOT NULL,
    fk_codigo_rol character varying(9) NOT NULL
);


--
-- TOC entry 165 (class 1259 OID 29937)
-- Name: cptarea; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cptarea (
    codigo character varying(9) NOT NULL,
    nombre character varying(35) NOT NULL,
    descripcion character varying(60),
    estado character varying(10) NOT NULL
);


--
-- TOC entry 166 (class 1259 OID 29940)
-- Name: cptareas_rol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cptareas_rol (
    fk_codigo_rol character varying(9) NOT NULL,
    fk_codigo_tarea character varying(9) NOT NULL
);


--
-- TOC entry 167 (class 1259 OID 29943)
-- Name: curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE curso (
    codigo character varying(15) NOT NULL,
    nombre character varying(100),
    hora_ini time without time zone,
    hora_fin time without time zone,
    fecha_ini date,
    total_horas character varying(10),
    grupo character varying(10),
    costo character varying(10),
    moneda character varying(10),
    periodo character varying(50),
    nota_aprob character varying(3),
    estado character varying(10),
    obs character varying(100),
    fk_profesor character varying(10),
    fecha_fin date,
    nivel_curso character varying(50),
    certificado character varying(3),
    fk_catalogo_curso character varying(6) NOT NULL
);


--
-- TOC entry 168 (class 1259 OID 29946)
-- Name: destinatario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE destinatario (
    codigo character varying(15) NOT NULL,
    titulo character varying(50),
    nombre character varying(150),
    cargo character varying(100),
    facultad character varying(100),
    ciudad character varying(100)
);


--
-- TOC entry 169 (class 1259 OID 29949)
-- Name: detalle_reserva; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE detalle_reserva (
    codigo character varying(50) NOT NULL,
    fecha date NOT NULL,
    fk_dia_res character varying(6) NOT NULL,
    fk_rango_res character varying(6) NOT NULL,
    fk_semana_res character varying(6) NOT NULL,
    fk_reserva character varying(50) NOT NULL,
    grupo_rango character varying(50) NOT NULL
);


--
-- TOC entry 170 (class 1259 OID 29952)
-- Name: dia_res; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dia_res (
    codigo character varying(6) NOT NULL,
    nombre character(10) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 171 (class 1259 OID 29955)
-- Name: docente; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE docente (
    codigo character varying(15) NOT NULL,
    ci character varying(15),
    nombre character varying(50) NOT NULL,
    ape_paterno character varying(40) NOT NULL,
    ape_materno character varying(40),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL,
    diploma character varying(50),
    titulo character varying(100),
    tiempo character varying(50)
);


--
-- TOC entry 172 (class 1259 OID 29959)
-- Name: empresa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE empresa (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying
);


--
-- TOC entry 173 (class 1259 OID 29963)
-- Name: estandarc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE estandarc (
    codigo character varying(15) NOT NULL,
    ref character varying(150) NOT NULL,
    dirigido character varying(100) NOT NULL,
    cuerpo character varying(1000) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying
);


--
-- TOC entry 174 (class 1259 OID 29967)
-- Name: gestion; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE gestion (
    codigo character varying(15) NOT NULL,
    gestion character varying(10),
    fecha_ini date,
    fecha_fin date,
    estado character varying(15)
);


--
-- TOC entry 175 (class 1259 OID 29970)
-- Name: hist_auxiliatura; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_auxiliatura (
    codigo character varying(15) NOT NULL,
    docencia character varying(10),
    investigacion character varying(10),
    laboratorio character varying(10),
    interaccion character varying(10),
    servicios character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 176 (class 1259 OID 29973)
-- Name: hist_categoria_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_categoria_doc (
    codigo character varying(15) NOT NULL,
    interno character varying(10),
    invitado character varying(10),
    asistentea character varying(10),
    adjuntob character varying(10),
    catedraticoc character varying(10),
    fk_nombra_doc character varying(15)
);


--
-- TOC entry 177 (class 1259 OID 29976)
-- Name: hist_horario_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_horario_aux (
    codigo character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    rango_ini character varying(10),
    rango_fin character varying(10),
    sigla_lab character varying(10),
    fk_materia_labo character varying(15),
    fk_materia_dicta character varying(15),
    fk_materia_labo1 character varying(15)
);


--
-- TOC entry 178 (class 1259 OID 29979)
-- Name: hist_horario_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_horario_doc (
    codigo character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    rango_ini character varying(10),
    rango_fin character varying(10),
    fk_materia_dicta character varying(15),
    fk_materia_dicta1 character varying(15)
);


--
-- TOC entry 179 (class 1259 OID 29982)
-- Name: hist_materia_dicta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_materia_dicta (
    codigo character varying(15) NOT NULL,
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    tipo character varying(100),
    gestion character varying(10),
    exclu integer,
    hor_auto integer,
    fk_segui_doc character varying(15),
    fk_nombra_doc character varying(15),
    fk_materia character varying(25)
);


--
-- TOC entry 180 (class 1259 OID 29985)
-- Name: hist_materia_labo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_materia_labo (
    codigo character varying(15) NOT NULL,
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    gestion character varying(10),
    sigla_lab character varying(10),
    tipo character varying(10),
    fk_segui_aux character varying(15),
    fk_nombra_aux character varying(15),
    fk_materia character varying(15),
    fk_laboratorio character varying(15)
);


--
-- TOC entry 181 (class 1259 OID 29988)
-- Name: hist_nombra_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_nombra_aux (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20),
    gestion character varying(10),
    hrs_sem integer,
    fk_auxiliar character varying(15)
);


--
-- TOC entry 182 (class 1259 OID 29991)
-- Name: hist_nombra_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_nombra_doc (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    diploma character varying(50) NOT NULL,
    titulo character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20) NOT NULL,
    gestion character varying(10),
    hrs_sem integer,
    fk_docente character varying(15)
);


--
-- TOC entry 183 (class 1259 OID 29994)
-- Name: hist_segui_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_segui_aux (
    codigo character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(200),
    fk_auxiliar character varying(15)
);


--
-- TOC entry 184 (class 1259 OID 29997)
-- Name: hist_segui_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hist_segui_doc (
    codigo character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(15),
    fk_docente character varying(15)
);


--
-- TOC entry 185 (class 1259 OID 30000)
-- Name: historico; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE historico (
    fecha date,
    gestion character varying(10),
    ges_creacion character varying(10)
);


--
-- TOC entry 186 (class 1259 OID 30003)
-- Name: horario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario (
    referencia character varying(10),
    dia character varying(10),
    hra_ini time without time zone,
    hra_fin time without time zone
);


--
-- TOC entry 187 (class 1259 OID 30006)
-- Name: horario_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario_aux (
    codigo character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    estado character varying(15),
    sigla_lab character varying(10),
    fk_materia_labo character varying(15),
    fk_materia_dicta character varying(15),
    fk_materia_labo1 character varying(15)
);


--
-- TOC entry 188 (class 1259 OID 30009)
-- Name: horario_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario_doc (
    codigo character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    gestion character varying(10),
    estado character varying(15),
    fk_materia_dicta character varying(15),
    fk_materia_dicta1 character varying(15)
);


--
-- TOC entry 189 (class 1259 OID 30012)
-- Name: horario_rangos_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario_rangos_aux (
    hor_ini time without time zone NOT NULL,
    hor_fin time without time zone NOT NULL,
    rango_ini character varying(10),
    rango_fin character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    gestion character varying(10),
    fk_horario_aux character varying(15)
);


--
-- TOC entry 190 (class 1259 OID 30016)
-- Name: horario_rangos_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario_rangos_doc (
    hor_ini time without time zone NOT NULL,
    hor_fin time without time zone NOT NULL,
    rango_ini character varying(10),
    rango_fin character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    gestion character varying(10),
    fk_horario_doc character varying(15)
);


--
-- TOC entry 191 (class 1259 OID 30020)
-- Name: horas_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horas_aux (
    codigo character varying(15) NOT NULL,
    rango_ini time without time zone NOT NULL,
    rango_fin time without time zone NOT NULL,
    tipo character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 192 (class 1259 OID 30024)
-- Name: horas_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horas_doc (
    codigo character varying(15) NOT NULL,
    rango_ini time without time zone NOT NULL,
    rango_fin time without time zone NOT NULL,
    tipo character varying(10),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 30028)
-- Name: inscritos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inscritos (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(50) NOT NULL,
    ape_materno character varying(50),
    ci character varying(15)
);


--
-- TOC entry 194 (class 1259 OID 30031)
-- Name: institucion; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE institucion (
    codigo character varying(10) NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion character varying(50),
    telefono character varying(20),
    estado character varying(10)
);


--
-- TOC entry 195 (class 1259 OID 30034)
-- Name: laboratorio; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE laboratorio (
    codigo character varying(15) NOT NULL,
    descrip character varying(100) NOT NULL,
    sigla character varying(10) NOT NULL,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    fecha_estado date DEFAULT ('now'::text)::date
);


--
-- TOC entry 196 (class 1259 OID 30039)
-- Name: materia; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE materia (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    sigla character varying(30) NOT NULL,
    tipo character varying(30) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL,
    seg_nom character varying(10) NOT NULL,
    nivel character varying(3),
    acronimo character varying(15)
);


--
-- TOC entry 197 (class 1259 OID 30043)
-- Name: materia_dicta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE materia_dicta (
    codigo character varying(15) NOT NULL,
    cod_nom character varying(10),
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    tipo character varying(100),
    estado character varying(15),
    gestion character varying(10),
    exclu integer,
    hor_auto integer,
    fk_segui_doc character varying(15),
    fk_nombra_doc character varying(15),
    fk_materia character varying(15),
    grupo character varying(2)
);


--
-- TOC entry 198 (class 1259 OID 30046)
-- Name: materia_labo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE materia_labo (
    codigo character varying(15) NOT NULL,
    cod_nom character varying(10),
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    estado character varying(15),
    gestion character varying(10),
    sigla_lab character varying(10),
    tipo character varying(10),
    fk_segui_aux character varying(15),
    fk_nombra_aux character varying(15),
    fk_materia character varying(15),
    fk_laboratorio character varying(15),
    grupo character varying(2)
);


--
-- TOC entry 199 (class 1259 OID 30049)
-- Name: mes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mes (
    num character varying(20),
    nombre character varying(10)
);


--
-- TOC entry 200 (class 1259 OID 30052)
-- Name: nombra_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE nombra_aux (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20),
    gestion character varying(10),
    hrs_sem integer,
    estado character varying(15),
    fk_auxiliar character varying(15)
);


--
-- TOC entry 201 (class 1259 OID 30055)
-- Name: nombra_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE nombra_doc (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    carrera character varying(100) NOT NULL,
    departamento character varying(50) NOT NULL,
    facultad character varying(50) NOT NULL,
    diploma character varying(50) NOT NULL,
    titulo character varying(50) NOT NULL,
    tiempo character varying(20) NOT NULL,
    fecha_nom date NOT NULL,
    fecha_sol date,
    duracion character varying(20) NOT NULL,
    gestion character varying(10),
    hrs_sem integer,
    estado character varying(15),
    fk_docente character varying(15)
);


--
-- TOC entry 202 (class 1259 OID 30058)
-- Name: nota; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE nota (
    calif character varying(3),
    fk_curso character varying(15),
    fk_inscritos character varying(15),
    nro_faltas character varying(10),
    descuento_n character varying(30),
    concepto_desc_n character varying(150),
    cancelado_n character varying(10),
    est_cuenta_n character varying(20),
    obs_n character varying(100)
);


--
-- TOC entry 203 (class 1259 OID 30061)
-- Name: pga_diagrams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_diagrams (
    diagramname character varying(64) NOT NULL,
    diagramtables text,
    diagramlinks text
);


--
-- TOC entry 204 (class 1259 OID 30067)
-- Name: pga_forms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_forms (
    formname character varying(64) NOT NULL,
    formsource text
);


--
-- TOC entry 205 (class 1259 OID 30073)
-- Name: pga_graphs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_graphs (
    graphname character varying(64) NOT NULL,
    graphsource text,
    graphcode text
);


--
-- TOC entry 206 (class 1259 OID 30079)
-- Name: pga_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_images (
    imagename character varying(64) NOT NULL,
    imagesource text
);


--
-- TOC entry 207 (class 1259 OID 30085)
-- Name: pga_layout; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_layout (
    tablename character varying(64) NOT NULL,
    nrcols smallint,
    colnames text,
    colwidth text
);


--
-- TOC entry 208 (class 1259 OID 30091)
-- Name: pga_queries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_queries (
    queryname character varying(64) NOT NULL,
    querytype character(1),
    querycommand text,
    querytables text,
    querylinks text,
    queryresults text,
    querycomments text
);


--
-- TOC entry 209 (class 1259 OID 30097)
-- Name: pga_reports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_reports (
    reportname character varying(64) NOT NULL,
    reportsource text,
    reportbody text,
    reportprocs text,
    reportoptions text
);


--
-- TOC entry 210 (class 1259 OID 30103)
-- Name: pga_scripts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_scripts (
    scriptname character varying(64) NOT NULL,
    scriptsource text
);


--
-- TOC entry 211 (class 1259 OID 30109)
-- Name: plan; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plan (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo_sis character varying(25),
    fecha_ini date,
    fecha_fin date,
    estado character varying(15) NOT NULL,
    fk_carrera character varying(15)
);


--
-- TOC entry 212 (class 1259 OID 30112)
-- Name: plan_mat; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plan_mat (
    codigo character varying(15) NOT NULL,
    fk_plan character varying(15),
    fk_materia character varying(15)
);


--
-- TOC entry 213 (class 1259 OID 30115)
-- Name: prerequisito; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prerequisito (
    fk_materia character varying(15),
    fk_pre_materia character varying(15)
);


--
-- TOC entry 214 (class 1259 OID 30118)
-- Name: prestamo_tesis; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prestamo_tesis (
    codigo character varying(15) NOT NULL,
    nombre_estudiante character varying(100) NOT NULL,
    ci character varying(10) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    tipo_carnet character varying(50) NOT NULL,
    fecha_prestamo date DEFAULT ('now'::text)::date,
    fecha_devolucion date DEFAULT ('now'::text)::date,
    encargado_prestamo character varying(100) NOT NULL,
    telefono character varying(8),
    direccion character varying(100) NOT NULL,
    fk_tesis character varying(15)
);


--
-- TOC entry 215 (class 1259 OID 30124)
-- Name: profesor; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profesor (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(50) NOT NULL,
    ape_materno character varying(50),
    estado character varying(10),
    obs character varying(100),
    cargo character varying(50),
    sexo character varying(2),
    telefono character varying(15),
    direccion character varying(50)
);


--
-- TOC entry 216 (class 1259 OID 30127)
-- Name: programa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE programa (
    codigo character varying(15) NOT NULL,
    facultad character varying(50) NOT NULL,
    periodo character varying(20) NOT NULL,
    carga_horaria character varying(20) NOT NULL,
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    fk_materia character varying(15)
);


--
-- TOC entry 217 (class 1259 OID 30131)
-- Name: rango_res; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rango_res (
    codigo character varying(6) NOT NULL,
    hora_ini character varying(50) NOT NULL,
    hora_fin character varying(50) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 30134)
-- Name: remitente; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE remitente (
    fk_cargo character varying(15),
    fk_estandar character varying(15)
);


--
-- TOC entry 219 (class 1259 OID 30137)
-- Name: reserva; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reserva (
    codigo character varying(50) NOT NULL,
    asunto character varying(50) NOT NULL,
    fecha_ini date NOT NULL,
    fecha_fin date NOT NULL,
    cant_equi character varying(50) NOT NULL,
    responsable character varying(50),
    observaciones character varying(150) NOT NULL,
    estado character varying(15) NOT NULL,
    pasa_sabados character varying(10) NOT NULL,
    costo_reserva character varying(50) NOT NULL,
    moneda character varying(10) NOT NULL,
    horario_fijo character varying(10) NOT NULL,
    fk_sala character varying(6) NOT NULL,
    fk_curso character varying(50) NOT NULL,
    fk_materia character varying(50),
    fk_institucion character varying(10),
    concepto character varying(255) NOT NULL,
    telefono_resp character varying(20),
    dir_resp character varying(50)
);


--
-- TOC entry 220 (class 1259 OID 30140)
-- Name: sala; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sala (
    codigo character varying(6) NOT NULL,
    nombre character varying(50) NOT NULL,
    cant_equi character varying(50) NOT NULL,
    descrip character varying(50) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 30144)
-- Name: segui_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE segui_aux (
    codigo character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(200),
    fk_auxiliar character varying(15),
    estado character varying(15)
);


--
-- TOC entry 222 (class 1259 OID 30147)
-- Name: segui_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE segui_doc (
    codigo character varying(15) NOT NULL,
    ape_esposo character varying(50),
    asist character varying(10),
    adj character varying(10),
    cat character varying(10),
    aux_doc character varying(10),
    otro_cargo character varying(100),
    hrs_teor character varying(5),
    hrs_inves character varying(5),
    hrs_ext character varying(5),
    hrs_ser character varying(5),
    hrs_prac character varying(5),
    rcfn1 character varying(5),
    rcfn2 character varying(5),
    rcfn3 character varying(5),
    hrs_prod character varying(5),
    hrs_serv character varying(5),
    hrs_prod_acad character varying(5),
    hrs_adm_acad character varying(5),
    rcfn4 character varying(5),
    rcfn5 character varying(5),
    rcfn6 character varying(5),
    rcfn7 character varying(5),
    hrs_trab_sem character varying(5),
    hrs_trab_mes character varying(5),
    hrs_auto character varying(5),
    tiempo_par character varying(5),
    dedi_exclu character varying(5),
    gestion character varying(10),
    obs character varying(15),
    fk_docente character varying(15),
    estado character varying(15)
);


--
-- TOC entry 223 (class 1259 OID 30150)
-- Name: segui_exclu_auto; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE segui_exclu_auto (
    codigo character varying(15),
    caso character varying(15),
    tipo character varying(15),
    nombre character varying(26),
    hora_ini time without time zone NOT NULL,
    rango_ini character varying(15),
    hora_fin time without time zone NOT NULL,
    rango_fin character varying(15),
    estado character varying(15),
    fk_segui_doc character varying(15)
);


--
-- TOC entry 224 (class 1259 OID 30153)
-- Name: sesion; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sesion (
    codigo character varying(15) NOT NULL,
    fk_usuario character varying(15) NOT NULL,
    fecha timestamp without time zone DEFAULT ('now'::text)::timestamp(6) with time zone
);


--
-- TOC entry 225 (class 1259 OID 30157)
-- Name: tabla_horario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tabla_horario (
    rango character varying(50) NOT NULL,
    grupo character varying(50) NOT NULL,
    lunes character varying(50),
    martes character varying(50),
    miercoles character varying(50),
    jueves character varying(50),
    viernes character varying(50),
    sabado character varying(50),
    estado character varying(15) NOT NULL,
    fk_materia_dicta character varying(20) NOT NULL,
    fk_sesion character varying(15)
);


--
-- TOC entry 226 (class 1259 OID 30160)
-- Name: tabla_horario_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tabla_horario_aux (
    rango character varying(50) NOT NULL,
    grupo character varying(50) NOT NULL,
    lunes character varying(50),
    martes character varying(50),
    miercoles character varying(50),
    jueves character varying(50),
    viernes character varying(50),
    sabado character varying(50),
    estado character varying(15) NOT NULL,
    sigla_lab character varying(10),
    fk_laboratorio character varying(15),
    fk_materia_dicta character varying(15),
    fk_sesion character varying(15)
);


--
-- TOC entry 227 (class 1259 OID 30163)
-- Name: tema; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tema (
    codigo character varying(15) NOT NULL,
    nombre character varying(150) NOT NULL,
    nivel character varying(2) NOT NULL,
    padre character varying(5) NOT NULL,
    fk_programa character varying(15)
);


--
-- TOC entry 228 (class 1259 OID 30166)
-- Name: temp_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_aux (
    codigo character varying(15) NOT NULL,
    cod_adh character varying(15),
    nombres character varying(200),
    cargo character varying(150),
    horas character varying(15),
    ci character varying(20),
    gestion1 character varying(10),
    gestion2 character varying(10),
    fecha character varying(100),
    fk_sesion character varying(15),
    tipo character varying(2),
    condicion character varying(20)
);


--
-- TOC entry 229 (class 1259 OID 30169)
-- Name: temp_bibliografia; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_bibliografia (
    codigo character varying(15) NOT NULL,
    nombre_autor character varying(150) NOT NULL,
    titulo character varying(150) NOT NULL,
    editorial character varying(100),
    detalles character varying(180),
    fk_sesion character varying(50),
    fk_programa character varying(15)
);


--
-- TOC entry 230 (class 1259 OID 30172)
-- Name: temp_cert_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_cert_curso (
    codigo character varying(15) NOT NULL,
    nombres character varying(200),
    obs character varying(50),
    fk_curso character varying(15),
    fk_sesion character varying(15)
);


--
-- TOC entry 231 (class 1259 OID 30175)
-- Name: temp_control_segui; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_control_segui (
    fk_sesion character varying(15),
    cod_doc_aux character varying(15)
);


--
-- TOC entry 232 (class 1259 OID 30178)
-- Name: temp_destinatario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_destinatario (
    codigo character varying(15) NOT NULL,
    titulo character varying(50),
    nombre character varying(150),
    cargo character varying(100),
    facultad character varying(100),
    ciudad character varying(100),
    fk_docente character varying(100)
);


--
-- TOC entry 233 (class 1259 OID 30181)
-- Name: temp_detalle_reserva; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_detalle_reserva (
    codigo character varying(50) NOT NULL,
    codigo_dt character varying(50) NOT NULL,
    fecha date NOT NULL,
    fk_dia_res character varying(6) NOT NULL,
    fk_rango_res character varying(6) NOT NULL,
    fk_semana_res character varying(6) NOT NULL,
    fk_reserva character varying(50) NOT NULL,
    grupo_rango character varying(50) NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 30184)
-- Name: temp_horario_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_horario_aux (
    codigo character varying(15),
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    estado character varying(15) NOT NULL,
    sigla_lab character varying(10),
    fk_laboratorio character varying(15),
    fk_materia_labo character varying(15) NOT NULL,
    fk_sesion character varying(15)
);


--
-- TOC entry 235 (class 1259 OID 30187)
-- Name: temp_horario_doc; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_horario_doc (
    codigo character varying(15),
    dia character varying(20) NOT NULL,
    grupo character varying(2) NOT NULL,
    aula character varying(5) NOT NULL,
    num_alum integer,
    hora_ini time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    estado character varying(15) NOT NULL,
    fk_materia_dicta character varying(15) NOT NULL,
    fk_sesion character varying(15)
);


--
-- TOC entry 236 (class 1259 OID 30190)
-- Name: temp_impresion; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_impresion (
    fecha character varying(50),
    titulo character varying(50),
    nombre character varying(150),
    cargo character varying(100),
    ciudad character varying(100),
    fk_estandarc character varying(15)
);


--
-- TOC entry 237 (class 1259 OID 30193)
-- Name: temp_materia_dicta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_materia_dicta (
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    tipo character varying(100),
    estado character varying(15),
    gestion character varying(10),
    exclu integer,
    hor_auto integer,
    fk_segui_doc character varying(15),
    fk_nombra_doc character varying(15),
    fk_materia character varying(15),
    grupo character varying(2),
    fk_sesion character varying(15)
);


--
-- TOC entry 238 (class 1259 OID 30196)
-- Name: temp_materia_labo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_materia_labo (
    nombre_mat character varying(100),
    sigla character varying(30),
    facultad character varying(50) NOT NULL,
    departamento character varying(50) NOT NULL,
    carrera character varying(100) NOT NULL,
    hor_sem integer,
    hor_teo integer,
    hor_pra integer,
    estado character varying(15),
    gestion character varying(10),
    sigla_lab character varying(10),
    tipo character varying(10),
    fk_segui_aux character varying(15),
    fk_nombra_aux character varying(15),
    fk_materia character varying(15),
    fk_laboratorio character varying(15),
    grupo character varying(2),
    fk_sesion character varying(15)
);


--
-- TOC entry 239 (class 1259 OID 30199)
-- Name: temp_materias; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_materias (
    codigo character varying(15),
    nombre character varying(150),
    sigla character varying(30),
    tipo character varying(30)
);


--
-- TOC entry 240 (class 1259 OID 30202)
-- Name: temp_nota; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_nota (
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(50) NOT NULL,
    ape_materno character varying(50),
    est_cuenta character varying(20),
    calif character varying(3),
    obs character varying(50),
    fk_inscritos character varying(15),
    nro_faltas character varying(10)
);


--
-- TOC entry 241 (class 1259 OID 30205)
-- Name: temp_rango; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_rango (
    hora time without time zone NOT NULL,
    rango character varying(10),
    fk_sesion character varying(15)
);


--
-- TOC entry 242 (class 1259 OID 30208)
-- Name: temp_rep_tesis_defen; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_rep_tesis_defen (
    cod_tes integer,
    nombre_univ character varying(302),
    tit_tesis character varying(250),
    modalidad character varying(50),
    gestion character varying(10)
);


--
-- TOC entry 243 (class 1259 OID 30211)
-- Name: temp_tesismos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_tesismos (
    cod_tes integer,
    nombres character varying(250) NOT NULL,
    titulo character varying(250) NOT NULL,
    modalidad character varying(50),
    carrera character varying(50) NOT NULL,
    gestion character varying(10)
);


--
-- TOC entry 244 (class 1259 OID 30214)
-- Name: temp_tesista; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_tesista (
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(100) NOT NULL,
    ape_materno character varying(100),
    carrera character varying(50) NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 30217)
-- Name: temp_validar_hor; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_validar_hor (
    codigo character varying(6) NOT NULL,
    cant_equi character varying(50) NOT NULL,
    asunto character varying(50) NOT NULL,
    fecha character varying(50) NOT NULL,
    hora_ini character varying(50) NOT NULL,
    hora_fin character varying(50) NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 30220)
-- Name: tesis; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tesis (
    codigo character varying(15) NOT NULL,
    titulo character varying(250) NOT NULL,
    modalidad character varying(50),
    gestion character varying(10),
    cod_tes integer,
    tomos integer
);


--
-- TOC entry 247 (class 1259 OID 30223)
-- Name: tesista; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tesista (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(100) NOT NULL,
    ape_materno character varying(100),
    carrera character varying(50) NOT NULL,
    ci character varying(10),
    fk_tesis character varying(15)
);


--
-- TOC entry 248 (class 1259 OID 30226)
-- Name: titulo_adic; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE titulo_adic (
    codigo character varying(10) NOT NULL,
    titulo character varying(100) NOT NULL,
    estado character varying(10) NOT NULL,
    fecha_ins date NOT NULL,
    num_cursos character varying(5)
);


--
-- TOC entry 249 (class 1259 OID 30229)
-- Name: titulo_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE titulo_curso (
    fk_titulo character varying(10) NOT NULL,
    fk_curso character varying(15) NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 30232)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuario (
    codigo character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    ape_paterno character varying(40) NOT NULL,
    ape_materno character varying(40),
    estado character varying(15) DEFAULT 'ACTIVO'::character varying,
    sexo character varying(5),
    cuenta character varying(50) NOT NULL,
    clave character varying(50),
    fk_autoridad character varying(15),
    fk_carrera character varying(20)
);


SET search_path = apoyo, pg_catalog;

--
-- TOC entry 2474 (class 0 OID 29852)
-- Dependencies: 141
-- Data for Name: variable; Type: TABLE DATA; Schema: apoyo; Owner: -
--

INSERT INTO variable (id_variable, nombre_variable, valor_variable) VALUES (1, 'version', '1.2.r5');
INSERT INTO variable (id_variable, nombre_variable, valor_variable) VALUES (2, 'serial', '102005');


SET search_path = public, pg_catalog;

--
-- TOC entry 2475 (class 0 OID 29855)
-- Dependencies: 142
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2476 (class 0 OID 29858)
-- Dependencies: 143
-- Data for Name: adhonorem; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2477 (class 0 OID 29862)
-- Dependencies: 144
-- Data for Name: adhonorem_ext; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2478 (class 0 OID 29865)
-- Dependencies: 145
-- Data for Name: autoridad; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO autoridad (codigo, nombre, ape_paterno, ape_materno, sexo, estado, ini_gestion, fin_gestion, fk_cargo, titulo, grado_firma) VALUES ('AUT2006_0002', 'JORGE MARTIN', 'DUCHEN', 'AYALA', 'M', 'ACTIVO', '2010-04-12', '2012-03-11', 'CAR0008', 'MSC. ING.', '0');
INSERT INTO autoridad (codigo, nombre, ape_paterno, ape_materno, sexo, estado, ini_gestion, fin_gestion, fk_cargo, titulo, grado_firma) VALUES ('AUT2006_0001', 'ARMANDO', 'ESCALERA', 'VASQUEZ', 'M', 'INACTIVO', '2006-07-12', '2008-07-11', 'CAR0008', 'MSC.', '0');
INSERT INTO autoridad (codigo, nombre, ape_paterno, ape_materno, sexo, estado, ini_gestion, fin_gestion, fk_cargo, titulo, grado_firma) VALUES ('AUT2011_0002', 'HERNAN', 'FLORES', 'GARCIA', 'M', 'ACTIVO', '2011-12-08', '2013-12-07', 'CAR0010', 'MSC. ING.', '0');
INSERT INTO autoridad (codigo, nombre, ape_paterno, ape_materno, sexo, estado, ini_gestion, fin_gestion, fk_cargo, titulo, grado_firma) VALUES ('AUT2012_0001', 'GUIDO', 'GOMEZ', 'UGARTE', 'M', 'ACTIVO', '2012-12-14', '2014-12-14', 'CAR0011', 'MSC. ING.', '0');
INSERT INTO autoridad (codigo, nombre, ape_paterno, ape_materno, sexo, estado, ini_gestion, fin_gestion, fk_cargo, titulo, grado_firma) VALUES ('AUT2011_0003', 'JULIO', 'GUZMAN', 'GUILLEN', 'M', 'INACTIVO', '2011-12-08', '2013-12-07', 'CAR0011', 'ING.', '0');
INSERT INTO autoridad (codigo, nombre, ape_paterno, ape_materno, sexo, estado, ini_gestion, fin_gestion, fk_cargo, titulo, grado_firma) VALUES ('AUT2011_0001', 'ORLANDO', 'CAMACHO', 'QUIROGA', 'M', 'ACTIVO', '2010-12-15', '2012-12-14', 'CAR0009', 'MSC. ING.', '0');


--
-- TOC entry 2479 (class 0 OID 29870)
-- Dependencies: 146
-- Data for Name: aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2480 (class 0 OID 29876)
-- Dependencies: 147
-- Data for Name: auxiliar; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000012', '4465848-Cbba', 'RONALD', 'BALDELLON', 'ALVAREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2005_000001', '4391591-Cbba', 'MAURICIO', 'BUSTAMANTE', 'PONCE', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000007', '5240590-Cbba', 'MARCO ANTONIO', 'CAMACHO', 'PE?A', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000016', '5153434-Cbba', 'CLAUDIA', 'ESCOBAR', 'SALGUERO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000004', '4415227-Cbba', 'JAVIER', 'FERRUFINO', 'HINOJOSA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000011', '4526340-Cbba', 'ALVARO DE JESUS', 'GONZALEZ', 'SANCHEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000003', '4504447-Cbba', 'JOSE ANTONIO', 'UNZUETA', 'ZEBALLOS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000005', '4535835-Cbba', 'MARIA CLAUDIA', 'TERCEROS', 'GARCIA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000015', '5198940-Cbba', 'JOSE MARIA SALVADOR', 'ROMAY', 'BORTOLINI', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000006', '4527674-Cbba', 'LILIANA ARACELI', 'RODRIGUEZ', 'ALVAREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000009', '5151461-Cbba', 'JOSE FREDDY', 'ROCHA', 'CAYO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000010', '5287906-Cbba', 'ALVARO ALEJANDRO', 'MENESES', 'ESPINOZA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000013', '3728785-Cbba', 'CARLO ANTONIO', 'MENDIZABAL', 'HERBAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000021', '3725027-Cbba', 'JESUS ANTONIO', 'MONTA?O', 'MONTECINOS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000020', '5279378-', 'CHRISTIAM BORIS', 'CAMACHO', 'PE?A', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000018', '4527684-Cbba', 'LILIANA ARACELI', 'RODRIGUEZ', 'ALVAREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000019', '5189438-Cbba', 'VLADIMIR', 'UGARTE', 'ONTIVEROS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000022', '5196327-Cbba', 'JAIME ALFREDO', 'ANAYA', 'DOMINGUEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000023', '5264943-Cbba', 'JUAN', 'RODRIGUEZ', 'MARTINEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000017', '5205912-Cbba', 'LAURIAN', 'FLORES', 'CABEZAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000024', '5281680-Cbba', 'BENITO', 'MAMANI', 'GUZMAN', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000025', '5247241-Cbba', 'ARIEL', 'MARTINEZ', 'ARCE', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000026', '', 'ENRRIQUE', 'ABASTO', 'CRUZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000027', '', 'FABIOLA ESCARLET', 'TORREJON', 'O?O', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000028', '4483649-Cbba', 'MAURICIO GONZALO', 'QUIROGA', 'ROJAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000029', '1890110-Tar', 'FREDDY GUIDO', 'COLLARANI', 'ANAGUA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000030', '5281680-Cbba', 'BENITO', 'MAMANI', 'GUZMAN', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000031', '5281680-Cbba', 'BENITO', 'MAMANI', 'GUZMAN', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000032', '4504447-Cbba', 'JOSE ANTONIO', 'UNZUETA', 'ZEBALLOS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000033', '', 'ARIEL RENE', 'BUSTAMANTE', 'CHAVEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000008', '5205912-Cbba', 'LAURIAN', 'FLORES', 'CABEZAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000034', '5205912-Cbba', 'LAURIAN', 'FLORES', 'CABEZAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000035', '5235683-Cbba', 'HEDBERT', 'RIOJA', 'HERRERA', 'AUXILIAR', 'INACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000036', '4835606-LP', 'ANGELA MARIA', 'BARRIOS', 'COLOMO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000037', '5235683-Cbba', 'HEDBERT', 'RIOJA', 'HERRERA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2006_000038', '4835606-LP', 'ANGELA MARIA', 'BARRIOS', 'COLOMO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000001', '5234431-Cbba', 'KATHYA ARACELY', 'BUSTAMANTE', 'UCHANI', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000003', '8036018-Cbba', 'DANIEL', 'BECERRA', 'VILLANUEVA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000004', '792664-Cbba', 'ARIEL', 'HIDALGO', 'RODRIGUEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000005', '6550870-Cbba', 'RODRIGO GERMAN', 'MOLLO', 'OCAÑA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000006', '6941123-Cbba', 'EDGAR PEDRO', 'ARUQUIPA', 'LARICO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000007', '8018076-Cbba', 'RUBEN', 'BAUTISTA', 'CONDORI', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000002', '6491570-Cbba', 'JORGE LUIS', 'FERREL', 'YAVI', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000008', '5526577-Pt', 'EDWIN WINSOR', 'JARA', 'ARIAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000010', '7906547-Cbba', 'SULMAYRA NATIVIDAD', 'ZARATE', 'GUZMAN', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000012', '5604043-Ben', 'DURVAL', 'PARRAGA', 'MORALES', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000014', '8057698-Cbba', 'KATERIN', 'IRAOLA', 'ZAMBRANA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000015', '', 'ENRRIQUE WALTER', 'ZULETA', 'NOVILLO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000011', '5303475-Cbba', 'JAHEL SARVIA', 'LEDEZMA', 'PÉREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000017', '7962798-Cbba', 'HUGO FRANCO', 'MELEAN', 'MUJICA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000019', '4421097-Cbba', 'JUAN JOSE', 'MIRANDA', 'VARGAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000016', '7962798-Cbba', 'MELEAN', 'MUJICA', 'HUGO FRANCO', 'AUXILIAR', 'INACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000024', '6487461-Cbba', 'NICOLAS', 'ROJAS', 'MERIDA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000025', '', 'MARIA ELENA', 'MENACHO', 'SUNAHUA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2013_000009', '8055169-Cbba', 'ANA ROCIO', 'RODRIGUEZ', 'URIBE', 'AUXILIAR', 'ACTIVO');


--
-- TOC entry 2481 (class 0 OID 29879)
-- Dependencies: 148
-- Data for Name: auxiliar_ext; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2482 (class 0 OID 29882)
-- Dependencies: 149
-- Data for Name: auxiliatura; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00013', 'S', 'S', 'N', 'N', 'N', '00013');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('000007', 'S', 'N', 'N', 'N', 'N', '000007');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00014', 'S', 'N', 'N', 'N', 'N', '00014');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00016', 'N', 'N', 'N', 'N', 'S', '00016');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00015', 'N', 'N', 'S', 'N', 'N', '00015');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00018', 'N', 'N', 'S', 'N', 'N', '00018');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00019', 'N', 'N', 'S', 'N', 'N', '00019');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00020', 'S', 'N', 'N', 'N', 'N', '00020');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00021', 'N', 'N', 'S', 'N', 'N', '00021');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00022', 'N', 'N', 'S', 'N', 'N', '00022');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00023', 'N', 'N', 'S', 'N', 'N', '00023');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00024', 'S', 'N', 'N', 'N', 'N', '00024');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00025', 'N', 'N', 'S', 'N', 'N', '00025');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00026', 'N', 'N', 'S', 'N', 'N', '00026');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00027', 'S', 'N', 'N', 'N', 'N', '00027');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00028', 'N', 'N', 'S', 'N', 'N', '00028');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00017', 'N', 'N', 'S', 'N', 'N', '00017');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00029', 'S', 'N', 'N', 'N', 'N', '00029');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00030', 'S', 'N', 'N', 'N', 'N', '00030');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00031', 'N', 'N', 'N', 'N', 'S', '00031');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00032', 'N', 'N', 'N', 'N', 'S', '00032');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00033', 'N', 'N', 'S', 'N', 'N', '00033');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00034', 'S', 'N', 'N', 'N', 'N', '00034');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00035', 'N', 'N', 'S', 'N', 'N', '00035');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00037', 'N', 'N', 'S', 'N', 'N', '00037');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00038', 'N', 'N', 'N', 'N', 'S', '00038');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00039', 'N', 'N', 'S', 'N', 'N', '00039');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00040', 'N', 'N', 'N', 'N', 'S', '00040');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00041', 'S', 'N', 'N', 'N', 'N', '00041');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00042', 'N', 'N', 'S', 'N', 'N', '00042');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00043', 'S', 'N', 'N', 'N', 'N', '00043');
INSERT INTO auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('00036', 'S', 'S', 'S', 'S', 'S', '00036');


--
-- TOC entry 2483 (class 0 OID 29885)
-- Dependencies: 150
-- Data for Name: bibliografia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2484 (class 0 OID 29888)
-- Dependencies: 151
-- Data for Name: car_adh; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2485 (class 0 OID 29892)
-- Dependencies: 152
-- Data for Name: car_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000013', 'I/2006', 'AUX2006_000012', 'CAR0001', 'ACTIVO', '2006-02-09', '80 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2005_000001', 'II/2005', 'AUX2005_000001', 'CAR0001', 'ACTIVO', '2005-08-19', '80 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000008', 'I/2006', 'AUX2006_000007', 'CAR0004', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000018', 'I/2006', 'AUX2006_000016', 'CAR0003', 'ACTIVO', '2006-02-10', '40 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000019', 'I/2006', 'AUX2006_000016', 'CAR0005', 'ACTIVO', '2006-02-10', '40 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000005', 'I/2006', 'AUX2006_000004', 'CAR0002', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000012', 'I/2006', 'AUX2006_000011', 'CAR0001', 'ACTIVO', '2006-02-09', '80 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000004', 'I/2006', 'AUX2006_000003', 'CAR0004', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000006', 'I/2006', 'AUX2006_000005', 'CAR0005', 'ACTIVO', '2006-02-09', '40 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000017', 'I/2006', 'AUX2006_000015', 'CAR0006', 'ACTIVO', '2006-02-09', '80 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000007', 'I/2006', 'AUX2006_000006', 'CAR0004', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000010', 'I/2006', 'AUX2006_000009', 'CAR0002', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000011', 'I/2006', 'AUX2006_000010', 'CAR0004', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000014', 'I/2006', 'AUX2006_000013', 'CAR0002', 'ACTIVO', '2006-02-09', '8 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000024', 'II/2006', 'AUX2006_000021', 'CAR0001', 'ACTIVO', '2006-08-23', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000023', 'II/2006', 'AUX2006_000020', 'CAR0004', 'ACTIVO', '2006-08-23', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000021', 'II/2006', 'AUX2006_000018', 'CAR0004', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000022', 'II/2006', 'AUX2006_000019', 'CAR0004', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000025', 'II/2006', 'AUX2006_000022', 'CAR0001', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000026', 'II/2006', 'AUX2006_000023', 'CAR0007', 'ACTIVO', '2006-08-23', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000020', 'II/2006', 'AUX2006_000017', 'CAR0002', 'ACTIVO', '2006-08-23', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000027', 'II/2006', 'AUX2006_000024', 'CAR0002', 'ACTIVO', '2006-08-23', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000028', 'II/2006', 'AUX2006_000025', 'CAR0002', 'ACTIVO', '2006-08-23', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000029', 'II/2006', 'AUX2006_000026', 'CAR0006', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000030', 'II/2006', 'AUX2006_000027', 'CAR0006', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000031', 'II/2006', 'AUX2006_000028', 'CAR0005', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000032', 'II/2006', 'AUX2006_000029', 'CAR0006', 'ACTIVO', '2006-08-23', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000033', 'II/2006', 'AUX2006_000030', 'CAR0002', 'ACTIVO', '2006-08-25', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000034', 'II/2006', 'AUX2006_000031', 'CAR0002', 'ACTIVO', '2006-08-25', '10');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000035', 'II/2006', 'AUX2006_000032', 'CAR0002', 'ACTIVO', '2006-08-25', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000036', 'II/2006', 'AUX2006_000033', 'CAR0006', 'ACTIVO', '2006-08-25', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000009', 'I/2006', 'AUX2006_000008', 'CAR0003', 'INACTIVO', '2006-10-13', '40 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000037', 'II/2006', 'AUX2006_000008', 'CAR0003', 'ACTIVO', '2006-10-13', '40 hrs.');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000038', 'II/2006', 'AUX2006_000034', 'CAR0003', 'ACTIVO', '2006-10-16', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000039', 'II/2006', 'AUX2006_000035', 'CAR0005', 'INACTIVO', '2006-10-27', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000040', 'II/2006', 'AUX2006_000036', 'CAR0005', 'ACTIVO', '2006-10-27', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000041', 'II/2006', 'AUX2006_000037', 'CAR0005', 'ACTIVO', '2006-10-27', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2006_000042', 'II/2006', 'AUX2006_000038', 'CAR0005', 'ACTIVO', '2006-10-27', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2007_000001', 'II/2007', 'AUX2007_000001', 'CAR0003', 'ACTIVO', '2007-09-13', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000003', 'I/2013', 'AUX2013_000003', 'CAR0006', 'ACTIVO', '2013-03-04', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000004', 'I/2013', 'AUX2013_000004', 'CAR0006', 'ACTIVO', '2013-03-04', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000005', 'I/2013', 'AUX2013_000005', 'CAR0004', 'ACTIVO', '2013-03-04', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000006', 'I/2013', 'AUX2013_000006', 'CAR0003', 'ACTIVO', '2013-03-04', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000007', 'I/2013', 'AUX2013_000007', 'CAR0006', 'ACTIVO', '2013-03-06', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000002', 'I/2013', 'AUX2013_000002', 'CAR0005', 'ACTIVO', '2013-03-04', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000008', 'I/2013', 'AUX2013_000008', 'CAR0005', 'ACTIVO', '2013-03-06', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000010', 'I/2013', 'AUX2013_000010', 'CAR0001', 'ACTIVO', '2013-03-06', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000011', 'I/2013', 'AUX2013_000011', 'CAR0007', 'ACTIVO', '2013-03-07', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000012', 'I/2013', 'AUX2013_000012', 'CAR0004', 'ACTIVO', '2013-03-07', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000014', 'I/2013', 'AUX2013_000014', 'CAR0007', 'ACTIVO', '2013-03-07', '40');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000015', 'I/2013', 'AUX2013_000015', 'CAR0002', 'ACTIVO', '2013-03-07', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000017', 'I/2013', 'AUX2013_000017', 'CAR0012', 'ACTIVO', '2013-03-07', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000019', 'I/2013', 'AUX2013_000019', 'CAR0002', 'ACTIVO', '2013-03-08', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000016', 'I/2013', 'AUX2013_000016', 'CAR0012', 'INACTIVO', '2013-03-11', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000024', 'I/2013', 'AUX2013_000024', 'CAR0004', 'ACTIVO', '2013-03-21', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000025', 'I/2013', 'AUX2013_000025', 'CAR0012', 'ACTIVO', '2013-03-21', '80');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2013_000009', 'I/2013', 'AUX2013_000009', 'CAR0001', 'INACTIVO', '2013-07-08', '40');


--
-- TOC entry 2486 (class 0 OID 29896)
-- Dependencies: 153
-- Data for Name: cargo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0002', 'AUXILIAR DOCENCIA', 'TITULAR', '8', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0003', 'AUXILIAR CAMPO', 'TITULAR', '40', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0005', 'AUXILIAR SERVICIOS', 'TITULAR', '40', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0004', 'AUXILIAR DE INVESTIGACION', 'TITULAR', '8', 'ACTIVO', 'LAB0002');
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0006', 'AUXILIAR DE INVESTIGACION', 'TITULAR', '80', 'ACTIVO', 'LAB0001');
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0001', 'AUXILIAR DE INVESTIGACION', 'TITULAR', '80', 'ACTIVO', 'LAB0004');
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0007', 'AUXILIAR DE INVESTIGACION', 'TITULAR', '40', 'ACTIVO', 'LAB0003');
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0008', 'DIRECTOR DE CARRERA', 'AUTORIDAD', 'No Definido', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0009', 'JEFE DE DEPARTAMENTO', 'AUTORIDAD', 'No Definido', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0010', 'DECANO', 'AUTORIDAD', 'No Definido', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0011', 'DIRECTOR ACADEMICO', 'AUTORIDAD', 'No Definido', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0012', 'AUXILIAR DE INVESTIGACION', 'TITULAR', '80', 'ACTIVO', 'LAB0008');


--
-- TOC entry 2487 (class 0 OID 29900)
-- Dependencies: 154
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO carrera (codigo, nombre, sigla, facultad, depto) VALUES ('CAR0001', 'ING. CIVIL', 'CIV', 'CIENCIAS Y TECNOLOGIA', 'CIVIL');


--
-- TOC entry 2488 (class 0 OID 29903)
-- Dependencies: 155
-- Data for Name: carta; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2489 (class 0 OID 29907)
-- Dependencies: 156
-- Data for Name: carta_dest; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2490 (class 0 OID 29910)
-- Dependencies: 157
-- Data for Name: catalogo_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2491 (class 0 OID 29914)
-- Dependencies: 158
-- Data for Name: categoria_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2492 (class 0 OID 29917)
-- Dependencies: 159
-- Data for Name: categoria_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2493 (class 0 OID 29921)
-- Dependencies: 160
-- Data for Name: categoria_doc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2494 (class 0 OID 29924)
-- Dependencies: 161
-- Data for Name: certificado; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2495 (class 0 OID 29928)
-- Dependencies: 162
-- Data for Name: combo_box; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC001', 'Ciencias y Tecnolog?a', 'FAC');
INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC002', 'Humanidades', 'FAC');
INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC003', 'Aaquitectura', 'FAC');
INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC004', 'Ecomom?a', 'FAC');
INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC005', 'Derecho', 'FAC');
INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC006', 'Agronom?a', 'FAC');
INSERT INTO combo_box (codigo, nombre, tipo) VALUES ('FAC007', 'Medicina', 'FAC');


--
-- TOC entry 2496 (class 0 OID 29931)
-- Dependencies: 163
-- Data for Name: cprol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000001', 'Administrador laboratorios', 'Encargado de curso, auxiliares de laboratorio y certificados', 'ACTIVO');
INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000002', 'Secretaria', 'Encargada de nombramientos, seguimientos', 'ACTIVO');
INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000003', 'Administrador', 'admin', 'ACTIVO');
INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000004', 'AUXILIAR LABORATORIO HIDRAULICA', '', 'ACTIVO');


--
-- TOC entry 2497 (class 0 OID 29934)
-- Dependencies: 164
-- Data for Name: cproles_usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cproles_usuario (fk_codigo_usr, fk_codigo_rol) VALUES ('2006_0001', 'ROL000003');
INSERT INTO cproles_usuario (fk_codigo_usr, fk_codigo_rol) VALUES ('2006_0002', 'ROL000003');
INSERT INTO cproles_usuario (fk_codigo_usr, fk_codigo_rol) VALUES ('2005_0001', 'ROL000002');
INSERT INTO cproles_usuario (fk_codigo_usr, fk_codigo_rol) VALUES ('2004_0001', 'ROL000003');


--
-- TOC entry 2498 (class 0 OID 29937)
-- Dependencies: 165
-- Data for Name: cptarea; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000001', 'Nombramientos', 'Menu que incluye las opciones de cursos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000002', 'Seguimientos', 'Menu que incluye las opciones de seguimientos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000003', 'Reportes', 'Menu que incluye las opciones de reportes', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000004', 'Historicos', 'Menu que incluye las opciones de historicos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000005', 'Cursos', 'Menu que incluye las opciones de cursos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000006', 'Varios', 'Menu que incluye opciones varias', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000007', 'Tesis', 'Menu que incluye las opciones de tesis', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000008', 'Catalogos', 'Menu que incluye los catalogos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000009', 'AbrirCursos', 'Permite crear un nuevo curso', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000010', 'RegistroDeInscritos', 'Permite el registro de estudiantes a un curso', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000011', 'RegistroDeNotas', 'Permite registrar la nota de los estudiantes', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000012', 'EmisionDeListas', 'Permite imprimir listas de alumnos y de notas', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000013', 'CertificadoEstudiantes', 'Permite imprimir certificados de cursos dictados', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000014', 'CurReportes', 'Muestra reportes generales acerca de los cursos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000015', 'NomDocentes', 'Nombramiento de auxiliares', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000016', 'NomAuxiliares', 'Nombramiento de docentes', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000017', 'SegDocentes', 'Seguimiento de docentes', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000018', 'SegAuxiliares', 'Seguimiento de auxiliares', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000019', 'SegReportes', 'Reportes de seguimientos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000020', 'ListaDocentes', 'Lista de docentes de la carrera', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000021', 'ListaDocentesExcel', 'Lista de docentes en formato excel', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000022', 'ListaAuxiliaresExcel', 'Lista de auxiliares en excel', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000023', 'ListaAdhonorem', 'Lista de auxiliares adhonorem', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000024', 'HisDocentes', 'Historico de docentes', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000025', 'HisAuxiliares', 'Historico de auxiliares', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000026', 'HisAdhonorem', 'Historico de auxiliares adhonorem', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000027', 'ProgramaAnalitico', 'Programa analitico de materias', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000028', 'ReservaLaboratorio', 'Reserva de laboratorio', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000029', 'certificadoAux', 'Certificados para auxiliares', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000030', 'Credenciales', 'Credenciales de laboratorio', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000031', 'Tesis2', 'Operaciones de creacion y modificacion', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000032', 'PrestamoTesis', 'Prestamo de tesis', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000033', 'TesReportes', 'Reportes de tesis', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000034', 'Autoridades', 'Catalogo de autoridades', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000035', 'Carreras', 'Catalogo de carreras', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000036', 'Materias', 'Catalogo de materias', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000037', 'CambioGestion', 'Cambio de gestion', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000038', 'CatDocentes', 'Catalogo de docentes', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000039', 'CatAuxiliares', 'Catalago de auxiliares', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000040', 'CatAdhonorem', 'Catalogo de adhonorem', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000041', 'CatUsuarios', 'Catalogo de usuarios', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000042', 'CatLaboratorios', 'Catalogo de laboratorios', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000043', 'CatSalas', 'Catalogo de salas', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000044', 'CatCargos', 'Catalogo de cargos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000045', 'CatActividades', 'Catalogo de actividades', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000046', 'TitulosAdicionales', 'Titulos adicionales para cursos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000047', 'Instituciones', 'Reserva de laboratorio a instituciones', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000048', 'Categoriascursos', 'Categorias,Catalogo para cursos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000049', 'CorreoElectronico', 'Envio de correos electronicos', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000050', 'roles', 'Administracion de role y tareas', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000054', 'profesor', 'configuracion referentas al profesor de un curso', 'ACTIVO');
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000055', 'Cursos', 'Administracion de cursos', 'ACTIVO');


--
-- TOC entry 2499 (class 0 OID 29940)
-- Dependencies: 166
-- Data for Name: cptareas_rol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000005');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000006');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000008');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000009');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000010');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000011');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000012');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000013');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000014');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000022');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000023');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000025');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000026');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000028');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000029');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000030');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000037');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000039');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000040');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000041');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000042');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000043');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000046');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000047');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000001');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000002');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000003');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000004');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000007');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000008');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000015');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000016');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000017');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000018');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000019');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000020');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000021');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000022');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000024');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000025');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000027');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000031');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000032');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000033');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000034');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000035');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000036');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000038');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000044');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000045');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000001');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000002');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000003');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000004');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000005');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000006');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000007');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000008');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000009');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000010');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000011');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000012');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000013');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000014');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000015');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000016');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000017');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000018');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000019');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000020');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000021');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000022');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000023');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000024');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000025');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000026');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000027');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000028');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000029');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000030');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000031');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000032');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000033');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000034');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000035');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000036');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000037');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000038');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000039');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000040');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000041');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000042');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000043');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000044');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000045');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000046');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000047');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000001', 'TAR000048');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000046');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000047');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000048');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000049');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000050');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000054');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000055');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000039');


--
-- TOC entry 2500 (class 0 OID 29943)
-- Dependencies: 167
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2501 (class 0 OID 29946)
-- Dependencies: 168
-- Data for Name: destinatario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2502 (class 0 OID 29949)
-- Dependencies: 169
-- Data for Name: detalle_reserva; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2503 (class 0 OID 29952)
-- Dependencies: 170
-- Data for Name: dia_res; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2504 (class 0 OID 29955)
-- Dependencies: 171
-- Data for Name: docente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0021', '', 'HERNANDO', 'PALMA ', 'DURAN ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0034', '', 'FRANZ', 'VARGAS ', 'LOAYZA ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0027', '', 'HELMER', 'RODRIGUEZ ', 'SORIANO', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0005', '', 'MARITZA', 'ARNEZ', 'TORRICO', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0017', '', 'IVAN', 'MENDEZ', 'VELASQUEZ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0019', '', 'JOSE', 'MERUVIA', 'MERUVIA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0022', '', 'JUAN FERNANDO', 'PARDO', 'IRIARTE', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0026', '', 'GABRIEL', 'RODRIGUEZ', 'ROCA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0003', '', 'OSVALDO', 'ANTEZANA ', 'MORUNO ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0013', '', 'GASTON', 'JOFFRE  ', 'LARA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0014', '', 'LUIS', 'LAZARTE ', 'VILLARROEL ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0032', '', 'JULIO', 'TORRES ', 'NAVARRO', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0002', '', 'OSCAR A.', 'ANTEZANA', 'MENDOZA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0009', '', 'MARCELO', 'EDUARDO', 'FRANZ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0006', '1250106-CBBA', 'JAIME', 'AYLLON', 'ACOSTA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0001', '2392960-LP', 'MERY', 'ALVARADO', 'RIVAS', 'ACTIVO', 'LICENCIATURA EN ECONOMIA', 'LIC ECONOMIA', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0004', '', 'FRANCISCO', 'ALVAREZ', 'POMMIER', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0012', '1248924-PT', 'OSCAR', 'FLORERO', 'ORTU?O', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0030', '', 'MAURICIO', 'SALINAS', 'PEREIRA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0037', '', 'OSCAR', 'ZABALAGA', 'MONTA?O', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0028', '3621893-CBBA', 'MAURICIO', 'ROMERO', 'MERIDA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0011', '2868347-CBBA', 'MARCO', 'ESCOBAR', 'SELEME', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0018', '972523-CBBA', 'ROBERTO', 'MENDEZ', 'TORRICO', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0020', '2685298-', 'GALO', 'MU?OZ', 'VASQUEZ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0023', '3007760-CBBA', 'MARIO', 'PEREIRA', 'MELGAR', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0024', '815355-CBBA', 'JUAN CARLOS', 'ROCHA', 'CUADROS', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0038', '3768458-CBBA', 'OSCAR', 'SACA', 'VENTURA', 'ACTIVO', 'ING CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0033', '991437-CBBA', 'MARIO FERNANDO', 'UREY', 'CONTRERAS', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0035', '114764-CHQ', 'CARLOS ALBERTO', 'VERA', 'CORTES', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0010', '577016-CBBA', 'ARMANDO', 'ESCALERA', 'VASQUEZ', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0016', '613371-OR', 'GUIDO', 'LEON', 'CLAVIJO', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0007', '', 'GUSTAVO', 'CANO', 'PRADO', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0029', '', 'RAMIRO', 'SAAVEDRA', 'ANTEZANA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0039', '3503422-', 'FERNANDO ARTURO', 'LEDEZMA', 'PERIZZA', 'ACTIVO', 'LIC INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0040', '206875-LP', 'VITO', 'LEDEZMA', 'MIRANDA', 'ACTIVO', 'LECENCIATURA EN ING CIVIL', 'ING CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0008', '974961-CBBA', 'MARTIN', 'DUCHEN', 'AYALA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0041', '3784655-CBBA', 'YAMIR', 'VILLAZON', 'ROCHA', 'ACTIVO', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0042', '3149943-', 'MARKO JORGE', 'ANDRADE', 'UZIEDA', 'ACTIVO', 'M SC', 'ING', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0043', '1394481-PT', 'OMAR', 'ANTEZANA', 'ROMAN', 'ACTIVO', 'MSC', 'ING', 'EXCLUSIVO');


--
-- TOC entry 2505 (class 0 OID 29959)
-- Dependencies: 172
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2506 (class 0 OID 29963)
-- Dependencies: 173
-- Data for Name: estandarc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2507 (class 0 OID 29967)
-- Dependencies: 174
-- Data for Name: gestion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('1', 'II/2005', '2005-03-01', '2005-12-20', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('2', 'I/2006', '2006-02-06', '2006-07-06', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('3', 'II/2006', '2006-06-29', '2006-12-20', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('4', 'I/2007', '2007-03-13', '2007-08-10', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('5', 'II/2007', '2007-08-23', '2008-01-20', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('7', 'I/2012', '2011-12-07', '2012-05-05', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('6', 'II/2011', '2011-08-09', '2011-12-06', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('8', 'I/2013', '2012-12-14', '2013-05-13', 'ACTIVO');


--
-- TOC entry 2508 (class 0 OID 29970)
-- Dependencies: 175
-- Data for Name: hist_auxiliatura; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000004', 'N', 'N', 'S', 'N', 'N', 'I/2006_000004');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000005', 'N', 'S', 'N', 'N', 'N', 'I/2006_000005');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_00012', 'N', 'N', 'S', 'N', 'N', 'I/2006_00012');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_00010', 'N', 'N', 'S', 'N', 'N', 'I/2006_00010');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000006', 'N', 'N', 'S', 'N', 'N', 'I/2006_000006');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000008', 'N', 'N', 'S', 'N', 'N', 'I/2006_000008');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000009', 'N', 'N', 'S', 'N', 'N', 'I/2006_000009');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_00013', 'S', 'S', 'N', 'N', 'N', 'I/2006_00013');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000007', 'S', 'N', 'N', 'N', 'N', 'I/2006_000007');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000003', 'N', 'N', 'S', 'N', 'N', 'I/2006_000003');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_00011', 'S', 'N', 'N', 'N', 'N', 'I/2006_00011');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_00014', 'S', 'N', 'N', 'N', 'N', 'I/2006_00014');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('I/2006_000002', 'N', 'N', 'S', 'S', 'N', 'I/2006_000002');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00013', 'S', 'S', 'N', 'N', 'N', 'II/2006_00013');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_000007', 'S', 'N', 'N', 'N', 'N', 'II/2006_000007');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00014', 'S', 'N', 'N', 'N', 'N', 'II/2006_00014');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00016', 'N', 'N', 'N', 'N', 'S', 'II/2006_00016');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00015', 'N', 'N', 'S', 'N', 'N', 'II/2006_00015');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00018', 'N', 'N', 'S', 'N', 'N', 'II/2006_00018');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00019', 'N', 'N', 'S', 'N', 'N', 'II/2006_00019');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00020', 'S', 'N', 'N', 'N', 'N', 'II/2006_00020');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00021', 'N', 'N', 'S', 'N', 'N', 'II/2006_00021');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00022', 'N', 'N', 'S', 'N', 'N', 'II/2006_00022');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00023', 'N', 'N', 'S', 'N', 'N', 'II/2006_00023');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00024', 'S', 'N', 'N', 'N', 'N', 'II/2006_00024');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00025', 'N', 'N', 'S', 'N', 'N', 'II/2006_00025');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00026', 'N', 'N', 'S', 'N', 'N', 'II/2006_00026');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00027', 'S', 'N', 'N', 'N', 'N', 'II/2006_00027');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00028', 'N', 'N', 'S', 'N', 'N', 'II/2006_00028');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00017', 'N', 'N', 'S', 'N', 'N', 'II/2006_00017');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00029', 'S', 'N', 'N', 'N', 'N', 'II/2006_00029');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00030', 'S', 'N', 'N', 'N', 'N', 'II/2006_00030');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00031', 'N', 'N', 'N', 'N', 'S', 'II/2006_00031');
INSERT INTO hist_auxiliatura (codigo, docencia, investigacion, laboratorio, interaccion, servicios, fk_nombra_aux) VALUES ('II/2006_00032', 'N', 'N', 'N', 'N', 'S', 'II/2006_00032');


--
-- TOC entry 2509 (class 0 OID 29973)
-- Dependencies: 176
-- Data for Name: hist_categoria_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2005_000002', 'N', 'S', 'N', 'N', 'N', 'II/2005_000002');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2005_000003', 'N', 'N', 'N', 'S', 'N', 'II/2005_000003');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000007', 'N', 'N', 'N', 'N', 'S', 'I/2006_000007');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00011', 'N', 'S', 'N', 'N', 'N', 'I/2006_00011');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000002', 'N', 'S', 'N', 'N', 'N', 'I/2006_000002');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000001', 'N', 'S', 'N', 'N', 'N', 'I/2006_000001');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000003', 'N', 'N', 'N', 'S', 'N', 'I/2006_000003');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00024', 'N', 'S', 'N', 'N', 'N', 'I/2006_00024');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000005', 'N', 'N', 'N', 'S', 'N', 'I/2006_000005');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000008', 'N', 'N', 'N', 'S', 'N', 'I/2006_000008');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000009', 'N', 'S', 'N', 'N', 'N', 'I/2006_000009');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00012', 'N', 'N', 'N', 'S', 'N', 'I/2006_00012');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00014', 'N', 'N', 'N', 'N', 'S', 'I/2006_00014');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00015', 'N', 'S', 'N', 'N', 'N', 'I/2006_00015');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00013', 'N', 'N', 'N', 'N', 'S', 'I/2006_00013');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00017', 'N', 'S', 'N', 'N', 'N', 'I/2006_00017');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00019', 'N', 'S', 'N', 'N', 'N', 'I/2006_00019');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00020', 'N', 'S', 'N', 'N', 'N', 'I/2006_00020');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00021', 'N', 'S', 'N', 'N', 'N', 'I/2006_00021');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00022', 'N', 'S', 'N', 'N', 'N', 'I/2006_00022');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00016', 'N', 'N', 'N', 'S', 'N', 'I/2006_00016');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000006', 'N', 'N', 'N', 'N', 'S', 'I/2006_000006');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00018', 'N', 'S', 'N', 'N', 'N', 'I/2006_00018');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00010', 'N', 'N', 'N', 'S', 'N', 'I/2006_00010');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_000004', 'N', 'N', 'N', 'N', 'S', 'I/2006_000004');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2006_00023', 'N', 'S', 'N', 'N', 'N', 'I/2006_00023');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000007', 'N', 'N', 'N', 'N', 'S', 'II/2006_000007');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000001', 'N', 'S', 'N', 'N', 'N', 'II/2006_000001');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000002', 'N', 'S', 'N', 'N', 'N', 'II/2006_000002');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000003', 'N', 'N', 'N', 'S', 'N', 'II/2006_000003');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000008', 'N', 'N', 'N', 'S', 'N', 'II/2006_000008');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000006', 'N', 'N', 'N', 'N', 'S', 'II/2006_000006');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000009', 'N', 'S', 'N', 'N', 'N', 'II/2006_000009');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00010', 'N', 'N', 'N', 'S', 'N', 'II/2006_00010');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00011', 'N', 'S', 'N', 'N', 'N', 'II/2006_00011');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00013', 'N', 'N', 'N', 'N', 'S', 'II/2006_00013');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00014', 'N', 'N', 'N', 'N', 'S', 'II/2006_00014');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00015', 'N', 'S', 'N', 'N', 'N', 'II/2006_00015');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00016', 'N', 'N', 'N', 'S', 'N', 'II/2006_00016');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00012', 'N', 'N', 'N', 'S', 'N', 'II/2006_00012');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00019', 'N', 'S', 'N', 'N', 'N', 'II/2006_00019');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00021', 'N', 'S', 'N', 'N', 'N', 'II/2006_00021');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000004', 'N', 'N', 'N', 'N', 'S', 'II/2006_000004');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00017', 'N', 'S', 'N', 'N', 'N', 'II/2006_00017');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00023', 'N', 'S', 'N', 'N', 'N', 'II/2006_00023');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00022', 'N', 'S', 'N', 'N', 'N', 'II/2006_00022');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00018', 'N', 'S', 'N', 'N', 'N', 'II/2006_00018');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00020', 'N', 'S', 'N', 'N', 'N', 'II/2006_00020');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00025', 'N', 'S', 'N', 'N', 'N', 'II/2006_00025');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00026', 'N', 'S', 'N', 'N', 'N', 'II/2006_00026');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_00024', 'N', 'S', 'N', 'N', 'N', 'II/2006_00024');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('II/2006_000005', 'N', 'N', 'N', 'S', 'N', 'II/2006_000005');


--
-- TOC entry 2510 (class 0 OID 29976)
-- Dependencies: 177
-- Data for Name: hist_horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_232', 'Martes', '', '', 0, '15:00:00', '18:00:00', 'I/2006', '12', '16', 'LAB0003', 'LAB0003', '', 'I/2006_29');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_233', 'Miercoles', '', '', 0, '15:00:00', '18:00:00', 'I/2006', '12', '16', 'LAB0003', 'LAB0003', '', 'I/2006_29');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_234', 'Jueves', '', '', 0, '14:15:00', '18:00:00', 'I/2006', '11', '16', 'LAB0003', 'LAB0003', '', 'I/2006_29');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_238', 'Lunes', '', '', 0, '09:00:00', '12:00:00', 'I/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'I/2006_28');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_239', 'Martes', '', '', 0, '09:00:00', '12:00:00', 'I/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'I/2006_28');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_240', 'Miercoles', '', '', 0, '08:00:00', '12:00:00', 'I/2006', '2', '8', 'LAB0004', 'LAB0004', '', 'I/2006_28');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_129', 'Martes', '', '', 0, '08:00:00', '12:00:00', 'I/2006', '2', '8', 'LAB0004', 'LAB0004', '', 'I/2006_11');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_130', 'Miercoles', '', '', 0, '09:00:00', '12:00:00', 'I/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'I/2006_11');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_131', 'Jueves', '', '', 0, '09:00:00', '12:00:00', 'I/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'I/2006_11');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_132', 'Lunes', '', '', 0, '07:30:00', '15:45:00', 'I/2006', '2', '13', 'LAB0002', 'LAB0002', '', 'I/2006_12');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_133', 'Martes', '', '', 0, '07:30:00', '15:45:00', 'I/2006', '2', '13', 'LAB0002', 'LAB0002', '', 'I/2006_12');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_134', 'Jueves', '', '', 0, '07:30:00', '12:45:00', 'I/2006', '2', '9', 'LAB0002', 'LAB0002', '', 'I/2006_12');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_135', 'Miercoles', '', '', 0, '07:30:00', '15:45:00', 'I/2006', '2', '13', 'LAB0002', 'LAB0002', '', 'I/2006_13');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_136', 'Jueves', '', '', 0, '07:30:00', '15:45:00', 'I/2006', '2', '13', 'LAB0002', 'LAB0002', '', 'I/2006_13');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_137', 'Viernes', '', '', 0, '07:30:00', '12:00:00', 'I/2006', '2', '8', 'LAB0002', 'LAB0002', '', 'I/2006_13');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_141', 'Martes', '', '', 0, '11:15:00', '17:00:00', 'I/2006', '7', '14', 'LAB0005', 'LAB0005', '', 'I/2006_14');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_142', 'Miercoles', '', '', 0, '11:15:00', '17:00:00', 'I/2006', '7', '14', 'LAB0005', 'LAB0005', '', 'I/2006_14');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_235', 'Lunes', '1', '', 0, '14:15:00', '18:00:00', 'I/2006', '11', '16', 'LAB0003', 'LAB0003', '', 'I/2006_15');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_236', 'Martes', '1', '', 0, '14:15:00', '18:00:00', 'I/2006', '11', '16', 'LAB0003', 'LAB0003', '', 'I/2006_15');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('I/2006_237', 'Miercoles', '1', '', 0, '14:15:00', '17:15:00', 'I/2006', '11', '15', 'LAB0003', 'LAB0003', '', 'I/2006_15');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_246', 'Viernes', '', '', 0, '01:30:00', '03:45:00', 'II/2006', '10', '13', 'LAB0001', 'LAB0001', '', 'II/2006_30');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_245', 'Miercoles', '', '', 0, '10:30:00', '03:45:00', 'II/2006', '6', '13', 'LAB0001', 'LAB0001', '', 'II/2006_30');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_244', 'Martes', '', '', 0, '10:30:00', '03:45:00', 'II/2006', '6', '13', 'LAB0001', 'LAB0001', '', 'II/2006_30');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_243', 'Lunes', '', '', 0, '07:30:00', '03:45:00', 'II/2006', '2', '13', 'LAB0001', 'LAB0001', '', 'II/2006_30');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_249', 'Miercoles', '1', 'LAB-H', 0, '08:15:00', '03:45:00', 'II/2006', '3', '13', 'LAB0001', 'LAB0001', '', 'II/2006_31');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_248', 'Martes', '1', 'LAB-H', 0, '08:15:00', '03:45:00', 'II/2006', '3', '13', 'LAB0001', 'LAB0001', '', 'II/2006_31');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_247', 'Lunes', '1', 'LAB-H', 0, '08:15:00', '03:45:00', 'II/2006', '3', '13', 'LAB0001', 'LAB0001', '', 'II/2006_31');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_251', 'Viernes', '', '', 0, '07:30:00', '12:30:00', 'II/2006', '2', '8', 'LAB0001', 'LAB0001', '', 'II/2006_32');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_250', 'Jueves', '', '', 0, '07:30:00', '12:30:00', 'II/2006', '2', '8', 'LAB0001', 'LAB0001', '', 'II/2006_32');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_254', 'Jueves', '1', 'Lab-R', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', 'LAB0003', 'LAB0003', '', 'II/2006_33');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_253', 'Miercoles', '1', 'Lab-R', 0, '08:15:00', '12:00:00', 'II/2006', '3', '8', 'LAB0003', 'LAB0003', '', 'II/2006_33');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_252', 'Lunes', '1', 'Lab-R', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', 'LAB0003', 'LAB0003', '', 'II/2006_33');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_259', 'Viernes', '1', 'Ser-G', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', 'LAB0007', 'LAB0007', '', 'II/2006_34');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_258', 'Jueves', '1', 'Ser-G', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', 'LAB0007', 'LAB0007', '', 'II/2006_34');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_257', 'Miercoles', '1', 'Ser-G', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', 'LAB0007', 'LAB0007', '', 'II/2006_34');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_256', 'Martes', '1', 'Ser-G', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', 'LAB0007', 'LAB0007', '', 'II/2006_34');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_255', 'Lunes', '1', 'Ser-G', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', 'LAB0007', 'LAB0007', '', 'II/2006_34');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_263', 'Viernes', '1', 'L GEO', 0, '07:30:00', '12:30:00', 'II/2006', '2', '8', 'LAB0002', 'LAB0002', '', 'II/2006_36');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_262', 'Lunes', '1', 'L GEO', 0, '07:30:00', '12:30:00', 'II/2006', '2', '8', 'LAB0002', 'LAB0002', '', 'II/2006_36');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_266', 'Viernes', '1', 'L-GEO', 0, '07:30:00', '11:30:00', 'II/2006', '2', '7', 'LAB0002', 'LAB0002', '', 'II/2006_37');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_265', 'Jueves', '1', 'L-GEO', 0, '07:30:00', '03:30:00', 'II/2006', '2', '12', 'LAB0002', 'LAB0002', '', 'II/2006_37');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_264', 'Miercoles', '1', 'L-GEO', 0, '07:30:00', '03:30:00', 'II/2006', '2', '12', 'LAB0002', 'LAB0002', '', 'II/2006_37');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_299', 'Martes', '1', '625-D', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012008', '', '2012008', 'II/2006_38');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_272', 'Miercoles', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'II/2006_39');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_271', 'Martes', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'II/2006_39');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_270', 'Lunes', '1', 'CASA', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0004', 'LAB0004', '', 'II/2006_39');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_275', 'Miercoles', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'II/2006_40');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_274', 'Martes', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', '4', '8', 'LAB0004', 'LAB0004', '', 'II/2006_40');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_273', 'Lunes', '1', 'CASA', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0004', 'LAB0004', '', 'II/2006_40');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_278', 'Jueves', '1', 'L-GEO', 0, '07:30:00', '11:30:00', 'II/2006', '2', '7', 'LAB0002', 'LAB0002', '', 'II/2006_41');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_277', 'Martes', '1', 'L-GEO', 0, '07:30:00', '03:30:00', 'II/2006', '2', '12', 'LAB0002', 'LAB0002', '', 'II/2006_41');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_276', 'Lunes', '1', 'L-GEO', 0, '07:30:00', '03:30:00', 'II/2006', '2', '12', 'LAB0002', 'LAB0002', '', 'II/2006_41');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_279', 'Martes', '', '', 0, '08:15:00', '06:00:00', 'II/2006', '3', '16', 'LAB0005', 'LAB0005', '', 'II/2006_42');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_282', 'Viernes', '1', 'campo', 0, '08:15:00', '12:00:00', 'II/2006', '3', '8', '2012006', '', '2012006', 'II/2006_43');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_283', 'Viernes', '1', 'campo', 0, '02:15:00', '06:00:00', 'II/2006', '11', '16', '2012006', '', '2012006', 'II/2006_43');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_285', 'Viernes', '1', 'hi-II', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012011', '', '2012011', 'II/2006_45');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_288', 'Viernes', '1', 'lab', 0, '07:30:00', '12:00:00', 'II/2006', '2', '8', 'LAB0001', 'LAB0001', '', 'II/2006_46');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_287', 'Jueves', '1', 'lab', 0, '07:30:00', '03:45:00', 'II/2006', '2', '13', 'LAB0001', 'LAB0001', '', 'II/2006_46');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_286', 'Miercoles', '1', 'lab', 0, '07:30:00', '03:45:00', 'II/2006', '2', '13', 'LAB0001', 'LAB0001', '', 'II/2006_46');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_289', 'Martes', '1', 'campo', 0, '08:00:00', '06:00:00', 'II/2006', '2', '16', 'LAB0005', 'LAB0005', '', 'II/2006_47');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_290', 'Martes', '', '', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_48');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_291', 'Miercoles', '', '', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_48');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_292', 'Jueves', '', '', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_48');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_293', 'Martes', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_49');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_294', 'Miercoles', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_49');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_295', 'Jueves', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_49');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_296', 'Lunes', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_50');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_297', 'Jueves', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_50');
INSERT INTO hist_horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('II/2006_298', 'Viernes', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', '2', '8', 'LAB0007', 'LAB0007', '', 'II/2006_50');


--
-- TOC entry 2511 (class 0 OID 29979)
-- Dependencies: 178
-- Data for Name: hist_horario_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_21', 'Sabado', '1', '641', 0, '08:15:00', '10:30:00', 'II/2005', '3', '6', '2012007', 'II/2005_5');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_4', 'Lunes', '1', '661', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012016', 'II/2005_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_5', 'Martes', '1', '642', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012016', 'II/2005_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_6', 'Viernes', '1', '625A', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012016', 'II/2005_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_6', 'Viernes', '1', '625A', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012016', 'II/2005_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_7', 'Martes', '2', '625D', 0, '20:15:00', '21:45:00', 'II/2005', '19', '20', '2012016', 'II/2005_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_8', 'Miercoles', '2', '625D', 0, '11:15:00', '12:45:00', 'II/2005', '7', '9', '2012016', 'II/2005_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_9', 'Sabado', '2', '625D', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012016', 'II/2005_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_9', 'Sabado', '2', '625D', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012016', 'II/2005_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_10', 'Martes', '1', '654', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012029', 'II/2005_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_11', 'Miercoles', '1', '625A', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012029', 'II/2005_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_12', 'Jueves', '1', '625B', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012029', 'II/2005_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_12', 'Jueves', '1', '625B', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012029', 'II/2005_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_13', 'Miercoles', '1', '624A', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012053', 'II/2005_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_14', 'Jueves', '1', '617A', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012053', 'II/2005_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_15', 'Viernes', '1', '617A', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012053', 'II/2005_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_15', 'Viernes', '1', '617A', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012053', 'II/2005_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_16', 'Martes', '2', '661', 0, '14:15:00', '15:45:00', 'II/2005', '11', '13', '2012010', 'II/2005_10');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_17', 'Jueves', '2', '617B', 0, '14:15:00', '15:45:00', 'II/2005', '11', '13', '2012010', 'II/2005_10');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_18', 'Lunes', '1', '642', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012030', 'II/2005_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_19', 'Martes', '1', '645', 0, '09:45:00', '11:15:00', 'II/2005', '5', '7', '2012030', 'II/2005_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_20', 'Miercoles', '1', '642', 0, '14:15:00', '15:45:00', 'II/2005', '11', '13', '2012030', 'II/2005_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_22', 'Lunes', '1', '624', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012004', 'II/2005_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_23', 'Martes', '1', '654', 0, '18:00:00', '20:15:00', 'II/2005', '16', '19', '2012004', 'II/2005_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_24', 'Jueves', '1', '654', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012004', 'II/2005_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_24', 'Jueves', '1', '654', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012004', 'II/2005_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_25', 'Miercoles', '1', '612', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012018', 'II/2005_13');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_26', 'Viernes', '1', '625A', 0, '06:45:00', '09:00:00', 'II/2005', '1', '4', '2012018', 'II/2005_13');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_29', 'Martes', '1', '642', 0, '17:15:00', '18:45:00', 'II/2005', '15', '17', '2012023', 'II/2005_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_30', 'Lunes', '1', '612', 0, '17:15:00', '18:45:00', 'II/2005', '15', '17', '2012023', 'II/2005_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_31', 'Jueves', '1', '661', 0, '15:45:00', '18:00:00', 'II/2005', '13', '16', '2012023', 'II/2005_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_31', 'Jueves', '1', '661', 0, '15:45:00', '18:00:00', 'II/2005', '13', '16', '2012023', 'II/2005_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_27', 'Lunes', '1', '642', 0, '14:15:00', '15:45:00', 'II/2005', '11', '13', '2012019', 'II/2005_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_28', 'Viernes', '1', '642', 0, '14:15:00', '16:30:00', 'II/2005', '11', '14', '2012019', 'II/2005_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_32', 'Martes', '1', '655', 0, '17:15:00', '18:45:00', 'II/2005', '15', '17', '2012061', 'II/2005_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_33', 'Martes', '1', 'Agua', 0, '18:45:00', '20:15:00', 'II/2005', '17', '19', '2012061', 'II/2005_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_34', 'Viernes', '1', '625A', 0, '18:45:00', '20:15:00', 'II/2005', '17', '19', '2012061', 'II/2005_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_35', 'Miercoles', '1', '651', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012005', 'II/2005_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_36', 'Sabado', '1', '642', 0, '11:15:00', '13:30:00', 'II/2005', '7', '10', '2012005', 'II/2005_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_36', 'Sabado', '1', '642', 0, '11:15:00', '13:30:00', 'II/2005', '7', '10', '2012005', 'II/2005_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_37', 'Miercoles', '2', '651', 0, '17:15:00', '18:45:00', 'II/2005', '15', '17', '2012005', 'II/2005_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_38', 'Sabado', '2', '641', 0, '13:30:00', '15:45:00', 'II/2005', '10', '13', '2012005', 'II/2005_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_42', 'Lunes', '1', '661', 0, '18:45:00', '20:15:00', 'II/2005', '17', '19', '2012043', 'II/2005_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_43', 'Martes', '1', '612A', 0, '16:30:00', '18:00:00', 'II/2005', '14', '16', '2012043', 'II/2005_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_44', 'Miercoles', '1', '617C', 0, '17:15:00', '18:45:00', 'II/2005', '15', '17', '2012043', 'II/2005_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_39', 'Lunes', '1', '625A', 0, '17:15:00', '18:45:00', 'II/2005', '15', '17', '2012042', 'II/2005_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_40', 'Martes', '1', '625A', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012042', 'II/2005_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_41', 'Martes', '1', '652', 0, '18:45:00', '20:15:00', 'II/2005', '17', '19', '2012042', 'II/2005_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_45', 'Martes', '1', '642', 0, '08:15:00', '09:45:00', 'II/2005', '3', '5', '2012024', 'II/2005_22');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2005_46', 'Miercoles', '1', '655', 0, '06:45:00', '08:15:00', 'II/2005', '1', '3', '2012024', 'II/2005_22');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_21', 'Sabado', '1', '641', 0, '08:15:00', '10:30:00', 'I/2006', '3', '6', '2012007', 'I/2006_5');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_4', 'Lunes', '2', '661', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012016', 'I/2006_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_5', 'Martes', '2', '642', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012016', 'I/2006_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_60', 'Viernes', '2', '625A', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012016', 'I/2006_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_67', 'Lunes', '1', '660', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012022', 'I/2006_30');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_68', 'Miercoles', '1', '625D', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012022', 'I/2006_30');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_69', 'Viernes', '1', '661', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012022', 'I/2006_30');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_265', 'Miercoles', '1', '622A', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012054', 'I/2006_82');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_266', 'Jueves', '1', '617A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012054', 'I/2006_82');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_267', 'Sabado', '1', '617A', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012054', 'I/2006_82');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_268', 'Lunes', '1', '625A', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012029', 'I/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_269', 'Jueves', '1', '654', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012029', 'I/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_270', 'Viernes', '1', '660', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012029', 'I/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_271', 'Lunes', '1', '625A', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012029', 'I/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_272', 'Jueves', '1', '654', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012029', 'I/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_273', 'Viernes', '1', '660', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012029', 'I/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_64', 'Martes', '2', '661', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012010', 'I/2006_10');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_65', 'Jueves', '2', '625D', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012010', 'I/2006_10');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_18', 'Lunes', '1', '642', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012030', 'I/2006_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_19', 'Martes', '1', '645', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012030', 'I/2006_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_20', 'Miercoles', '1', '642', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012030', 'I/2006_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_22', 'Lunes', '1', '624', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012004', 'I/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_23', 'Martes', '1', '654', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012004', 'I/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_24', 'Jueves', '1', '654', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012004', 'I/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_24', 'Jueves', '1', '654', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012004', 'I/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_25', 'Miercoles', '1', '612', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012018', 'I/2006_13');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_26', 'Viernes', '1', '625A', 0, '06:45:00', '09:00:00', 'I/2006', '1', '4', '2012018', 'I/2006_13');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_27', 'Lunes', '1', '642', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012019', 'I/2006_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_28', 'Viernes', '1', '642', 0, '14:15:00', '16:30:00', 'I/2006', '11', '14', '2012019', 'I/2006_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_28', 'Viernes', '1', '642', 0, '14:15:00', '16:30:00', 'I/2006', '11', '14', '2012019', 'I/2006_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_29', 'Martes', '1', '642', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012023', 'I/2006_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_30', 'Lunes', '1', '612', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012023', 'I/2006_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_31', 'Jueves', '1', '661', 0, '15:45:00', '18:00:00', 'I/2006', '13', '16', '2012023', 'I/2006_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_221', 'Jueves', '1', '625D', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012061', 'I/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_32', 'Martes', '1', '655', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012061', 'I/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_33', 'Martes', '1', 'AGUAS', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012061', 'I/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_222', 'Jueves', '1', '625D', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012061', 'I/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_35', 'Miercoles', '1', '651', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012005', 'I/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_36', 'Sabado', '1', '642', 0, '11:15:00', '13:30:00', 'I/2006', '7', '10', '2012005', 'I/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_36', 'Sabado', '1', '642', 0, '11:15:00', '13:30:00', 'I/2006', '7', '10', '2012005', 'I/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_37', 'Miercoles', '2', '651', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012005', 'I/2006_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_38', 'Sabado', '2', '641', 0, '13:30:00', '15:45:00', 'I/2006', '10', '13', '2012005', 'I/2006_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_39', 'Lunes', '1', '625A', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012042', 'I/2006_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_40', 'Martes', '1', '625A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012042', 'I/2006_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_41', 'Martes', '1', '652', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012042', 'I/2006_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_45', 'Martes', '1', '642', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012024', 'I/2006_22');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_46', 'Miercoles', '1', '655', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012024', 'I/2006_22');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_42', 'Lunes', '1', '661', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012043', 'I/2006_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_43', 'Martes', '1', '612A', 0, '16:30:00', '18:00:00', 'I/2006', '14', '16', '2012043', 'I/2006_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_44', 'Miercoles', '1', '617C', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012043', 'I/2006_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_52', 'Lunes', '1', '641', 0, '06:45:00', '09:00:00', 'I/2006', '1', '4', '2012033', 'I/2006_25');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_53', 'Miercoles', '1', '655', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012033', 'I/2006_25');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_54', 'Martes', '1', '652', 0, '06:45:00', '09:00:00', 'I/2006', '1', '4', '2012039', 'I/2006_26');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_55', 'Viernes', '1', '641', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012039', 'I/2006_26');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_55', 'Viernes', '1', '641', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012039', 'I/2006_26');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_274', 'Lunes', '2', 'MAGNA', 0, '09:45:00', '12:00:00', 'I/2006', '5', '8', '2012019', 'I/2006_83');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_275', 'Jueves', '2', '625 C', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012019', 'I/2006_83');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_49', 'Miercoles', '2', '625D', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012060', 'I/2006_24');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_50', 'Jueves', '2', '625D', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012060', 'I/2006_24');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_51', 'Sabado', '2', '625A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012060', 'I/2006_24');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_58', 'Martes', '1', '617C', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012031', 'I/2006_28');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_59', 'Jueves', '1', '617C', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012031', 'I/2006_28');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_56', 'Lunes', '1', '617B', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012036', 'I/2006_27');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_57', 'Miercoles', '1', '652', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012036', 'I/2006_27');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_262', 'Martes', '2', '623', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012008', 'I/2006_33');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_263', 'Miercoles', '2', '642', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012008', 'I/2006_33');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_264', 'Viernes', '2', '651', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012008', 'I/2006_33');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_258', 'Martes', '1', '642', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012011', 'I/2006_31');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_259', 'Jueves', '1', '642', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012011', 'I/2006_31');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_260', 'Jueves', '1', '642', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012008', 'I/2006_32');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_261', 'Viernes', '1', '642', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012008', 'I/2006_32');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_97', 'Lunes', '1', '622A', 0, '06:45:00', '09:00:00', 'I/2006', '1', '4', '2012038', 'I/2006_35');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_98', 'Martes', '1', '624A', 0, '12:45:00', '15:00:00', 'I/2006', '9', '12', '2012038', 'I/2006_35');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_99', 'Lunes', '2', '625A', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012002', 'I/2006_36');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_100', 'Lunes', '2', '625A', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012002', 'I/2006_36');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_101', 'Martes', '2', '625A', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012002', 'I/2006_36');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_113', 'Martes', '1', '655', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012034', 'I/2006_37');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_114', 'Jueves', '1', '660', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012034', 'I/2006_37');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_115', 'Viernes', '1', '623A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012034', 'I/2006_37');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_116', 'Lunes', '1', '617B', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012044', 'I/2006_38');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_117', 'Martes', '1', '673', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012044', 'I/2006_38');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_119', 'Sabado', '1', '625C', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012044', 'I/2006_38');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_124', 'Martes', '1', '641', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012015', 'I/2006_40');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_125', 'Viernes', '1', '641', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012015', 'I/2006_40');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_123', 'Lunes', '1', '641', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012015', 'I/2006_40');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_120', 'Miercoles', '1', '625A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012045', 'I/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_121', 'Viernes', '1', '652', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012045', 'I/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_122', 'Jueves', '1', '625A', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012045', 'I/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_122', 'Jueves', '1', '625A', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012045', 'I/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_126', 'Lunes', '2', '652', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012026', 'I/2006_85');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_127', 'Martes', '2', '652', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012026', 'I/2006_85');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_128', 'Miercoles', '2', '652', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012026', 'I/2006_85');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_129', 'Lunes', '1', '670', 0, '17:15:00', '20:15:00', 'I/2006', '15', '19', '2012001', 'I/2006_42');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_225', 'Viernes', '1', '617', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012001', 'I/2006_42');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_226', 'Viernes', '1', 'CAE', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012001', 'I/2006_42');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_131', 'Martes', '1', '624A', 0, '18:45:00', '21:00:00', 'I/2006', '17', '20', '2012051', 'I/2006_43');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_132', 'Sabado', '1', '622A', 0, '11:15:00', '13:30:00', 'I/2006', '7', '10', '2012051', 'I/2006_43');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_133', 'Lunes', '1', '617A', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012055', 'I/2006_44');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_134', 'Viernes', '1', '622A', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012055', 'I/2006_44');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_138', 'Lunes', '1', '625B', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012035', 'I/2006_46');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_139', 'Miercoles', '1', '625B', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012035', 'I/2006_46');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_140', 'Jueves', '1', '642', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012035', 'I/2006_46');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_141', 'Lunes', '1', '625B', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012013', 'I/2006_47');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_142', 'Miercoles', '1', '625B', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012013', 'I/2006_47');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_143', 'Jueves', '1', '641', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012013', 'I/2006_47');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_135', 'Lunes', '2', '625a', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012013', 'I/2006_45');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_137', 'Jueves', '2', '642', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012013', 'I/2006_45');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_144', 'Miercoles', '2', '625B', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012013', 'I/2006_45');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_145', 'Lunes', '1', '654', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012028', 'I/2006_48');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_146', 'Jueves', '1', '617C', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012028', 'I/2006_48');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_147', 'Viernes', '1', '617C', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012028', 'I/2006_48');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_148', 'Lunes', '1', '612A', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012050', 'I/2006_49');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_149', 'Jueves', '1', '654', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012050', 'I/2006_49');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_150', 'Viernes', '1', '617C', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012050', 'I/2006_49');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_151', 'Lunes', '1', '654', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012047', 'I/2006_50');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_152', 'Jueves', '1', '625C', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012047', 'I/2006_50');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_153', 'Viernes', '1', '652', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012047', 'I/2006_50');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_154', 'Lunes', '1', '642', 0, '19:30:00', '21:45:00', 'I/2006', '18', '20', '2012032', 'I/2006_51');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_155', 'Sabado', '1', '642', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012032', 'I/2006_51');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_156', 'Martes', '1', '642', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012027', 'I/2006_52');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_157', 'Jueves', '1', '642', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012027', 'I/2006_52');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_158', 'Viernes', '1', '642', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012027', 'I/2006_52');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_159', 'Lunes', '1', '617C', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012006', 'I/2006_53');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_160', 'Sabado', '1', '617C', 0, '15:45:00', '18:45:00', 'I/2006', '13', '17', '2012006', 'I/2006_53');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_161', 'Lunes', '1', '612A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012053', 'I/2006_81');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_162', 'Miercoles', '1', '625A', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012053', 'I/2006_81');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_163', 'Sabado', '1', '612A', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012053', 'I/2006_81');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_164', 'Martes', '1', '651', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012016', 'I/2006_55');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_165', 'Sabado', '1', '625D', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012016', 'I/2006_55');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_166', 'Viernes', '1', '651', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012016', 'I/2006_55');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_170', 'Sabado', '1', '642', 0, '08:15:00', '10:30:00', 'I/2006', '3', '6', '2012025', 'I/2006_58');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_171', 'Sabado', '1', '674', 0, '11:15:00', '13:30:00', 'I/2006', '7', '10', '2012025', 'I/2006_58');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_173', 'Martes', '1', 'civ', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012048', 'I/2006_60');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_174', 'Miercoles', '1', 'civ', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012048', 'I/2006_60');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_175', 'Jueves', '1', 'civ', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012048', 'I/2006_60');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_172', 'Jueves', '2', '625A', 0, '11:15:00', '13:30:00', 'I/2006', '7', '10', '2012007', 'I/2006_59');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_172', 'Jueves', '2', '625A', 0, '11:15:00', '13:30:00', 'I/2006', '7', '10', '2012007', 'I/2006_59');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_277', 'Miercoles', '2', '625A', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012012', 'I/2006_84');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_281', 'Viernes', '2', '656', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012012', 'I/2006_84');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_181', 'Martes', '1', '622A', 0, '10:30:00', '12:00:00', 'I/2006', '6', '8', '2012037', 'I/2006_63');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_182', 'Jueves', '1', '624A', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012037', 'I/2006_63');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_183', 'Viernes', '1', '624A', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012037', 'I/2006_63');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_178', 'Martes', '1', '673', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012020', 'I/2006_62');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_179', 'Jueves', '1', '617B', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012020', 'I/2006_62');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_180', 'Viernes', '1', '625A', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012020', 'I/2006_62');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_180', 'Viernes', '1', '625A', 0, '11:15:00', '12:45:00', 'I/2006', '7', '9', '2012020', 'I/2006_62');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_282', 'Lunes', '2', 'Magna', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012023', 'I/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_283', 'Jueves', '2', '642', 0, '15:00:00', '17:15:00', 'I/2006', '12', '15', '2012023', 'I/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_284', 'Jueves', '2', '642', 0, '15:00:00', '17:15:00', 'I/2006', '12', '15', '2012023', 'I/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_285', 'Jueves', '2', '642', 0, '15:00:00', '17:15:00', 'I/2006', '12', '15', '2012023', 'I/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_286', 'Miercoles', '2', '625c', 0, '12:45:00', '15:00:00', 'I/2006', '9', '12', '2012023', 'I/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_176', 'Miercoles', '1', '644', 0, '10:30:00', '12:00:00', 'I/2006', '6', '8', '2012010', 'I/2006_61');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_177', 'Viernes', '1', '656', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012010', 'I/2006_61');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_184', 'Lunes', '1', '642', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012021', 'I/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_185', 'Lunes', '1', '642', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012021', 'I/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_186', 'Jueves', '1', '641', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012021', 'I/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_186', 'Jueves', '1', '641', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012021', 'I/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_187', 'Lunes', '1', '642', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012014', 'I/2006_65');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_188', 'Jueves', '1', '642', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012014', 'I/2006_65');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_189', 'Viernes', '1', '641', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012014', 'I/2006_65');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_190', 'Martes', '1', '612', 0, '18:45:00', '21:00:00', 'I/2006', '17', '20', '2012003', 'I/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_191', 'Miercoles', '1', '612', 0, '18:45:00', '21:00:00', 'I/2006', '17', '20', '2012003', 'I/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_192', 'Lunes', '2', 'CAE', 0, '14:15:00', '17:15:00', 'I/2006', '11', '15', '2012001', 'I/2006_68');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_193', 'Viernes', '2', '660', 0, '14:15:00', '17:15:00', 'I/2006', '11', '15', '2012001', 'I/2006_68');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_194', 'Lunes', '1', '617B', 0, '12:00:00', '13:30:00', 'I/2006', '8', '10', '2012017', 'I/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_195', 'Martes', '1', '661', 0, '12:00:00', '13:30:00', 'I/2006', '8', '10', '2012017', 'I/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_196', 'Jueves', '1', '651', 0, '18:00:00', '20:15:00', 'I/2006', '16', '19', '2012017', 'I/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_197', 'Martes', '1', '625A', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012006', 'I/2006_70');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_198', 'Viernes', '1', 'CAMPO', 0, '11:15:00', '14:15:00', 'I/2006', '7', '11', '2012006', 'I/2006_70');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_199', 'Lunes', '1', '623', 0, '18:45:00', '21:00:00', 'I/2006', '17', '20', '2012026', 'I/2006_72');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_200', 'Miercoles', '1', '647C', 0, '18:45:00', '21:00:00', 'I/2006', '17', '20', '2012026', 'I/2006_72');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_206', 'Lunes', '1', '622', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012002', 'I/2006_75');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_207', 'Miercoles', '1', '642', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012002', 'I/2006_75');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_208', 'Viernes', '1', '642', 0, '06:45:00', '08:15:00', 'I/2006', '1', '3', '2012002', 'I/2006_75');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_201', 'Lunes', '1', '617B', 0, '14:15:00', '17:15:00', 'I/2006', '11', '15', '2012009', 'I/2006_73');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_240', 'Martes', '1', '642', 0, '20:15:00', '21:45:00', 'I/2006', '19', '20', '2012009', 'I/2006_73');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_203', 'Lunes', '1', '622', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012060', 'I/2006_74');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_205', 'Jueves', '1', '622', 0, '17:15:00', '18:45:00', 'I/2006', '15', '17', '2012060', 'I/2006_74');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_239', 'Viernes', '1', '660', 0, '18:45:00', '20:15:00', 'I/2006', '17', '19', '2012060', 'I/2006_74');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_218', 'Martes', '2', '656', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012020', 'I/2006_78');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_219', 'Miercoles', '2', '656', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012020', 'I/2006_78');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_220', 'Viernes', '2', '656', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012020', 'I/2006_78');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_287', 'Lunes', '2', '607', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_288', 'Miercoles', '2', '656', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_289', 'Jueves', '2', '656', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_290', 'Martes', '2', '671C', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_291', 'Jueves', '2', '625C', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_292', 'Viernes', '2', '655', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_293', 'Lunes', '2', '607', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_294', 'Miercoles', '2', '656', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_295', 'Jueves', '2', '656', 0, '14:15:00', '15:45:00', 'I/2006', '11', '13', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_296', 'Martes', '2', '671C', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_297', 'Jueves', '2', '625C', 0, '09:45:00', '11:15:00', 'I/2006', '5', '7', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_298', 'Viernes', '2', '655', 0, '15:45:00', '17:15:00', 'I/2006', '13', '15', '2012003', 'I/2006_77');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_223', 'Martes', '1', '654', 0, '12:45:00', '14:15:00', 'I/2006', '9', '11', '2012012', 'I/2006_79');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2006_224', 'Sabado', '1', '617B', 0, '08:15:00', '09:45:00', 'I/2006', '3', '5', '2012012', 'I/2006_79');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_21', 'Sabado', '1', '641', 0, '08:15:00', '10:30:00', 'II/2006', '3', '6', '2012007', 'II/2006_5');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_60', 'Viernes', '2', '625A', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012016', 'II/2006_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_5', 'Martes', '2', '642', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012016', 'II/2006_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_4', 'Lunes', '2', '661', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012016', 'II/2006_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_69', 'Viernes', '1', '661', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012022', 'II/2006_30');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_68', 'Miercoles', '1', '625D', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012022', 'II/2006_30');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_67', 'Lunes', '1', '660', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012022', 'II/2006_30');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_267', 'Sabado', '1', '617A', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012054', 'II/2006_82');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_266', 'Jueves', '1', '617A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012054', 'II/2006_82');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_265', 'Miercoles', '1', '622A', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012054', 'II/2006_82');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_307', 'Sabado', '1', '651', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012029', 'II/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_306', 'Miercoles', '1', 'MAG-C', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012029', 'II/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_305', 'Martes', '1', 'MAG-C', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012029', 'II/2006_8');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_20', 'Miercoles', '1', '642', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012030', 'II/2006_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_19', 'Martes', '1', '645', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012030', 'II/2006_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_18', 'Lunes', '1', '642', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012030', 'II/2006_11');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_24', 'Jueves', '1', '654', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012004', 'II/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_23', 'Martes', '1', '654', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012004', 'II/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_22', 'Lunes', '1', '624', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012004', 'II/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_22', 'Lunes', '1', '624', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012004', 'II/2006_12');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_26', 'Viernes', '1', '625A', 0, '06:45:00', '09:00:00', 'II/2006', '1', '4', '2012018', 'II/2006_13');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_25', 'Miercoles', '1', '612', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012018', 'II/2006_13');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_28', 'Viernes', '1', '642', 0, '02:15:00', '04:30:00', 'II/2006', '11', '14', '2012019', 'II/2006_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_27', 'Lunes', '1', '642', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012019', 'II/2006_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_27', 'Lunes', '1', '642', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012019', 'II/2006_14');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_31', 'Jueves', '1', '661', 0, '03:45:00', '06:00:00', 'II/2006', '13', '16', '2012023', 'II/2006_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_30', 'Lunes', '1', '612', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012023', 'II/2006_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_29', 'Martes', '1', '642', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012023', 'II/2006_15');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_304', 'Martes', '1', 'AGUAS', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012061', 'II/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_221', 'Jueves', '1', 'MAG-C', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012061', 'II/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_32', 'Martes', '1', 'MAG-C', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012061', 'II/2006_16');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_300', 'Sabado', '1', '642', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012005', 'II/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_35', 'Miercoles', '1', '651', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012005', 'II/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_299', 'Sabado', '1', '642', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012005', 'II/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_299', 'Sabado', '1', '642', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012005', 'II/2006_18');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_302', 'Sabado', '2', '641', 0, '01:30:00', '03:00:00', 'II/2006', '10', '12', '2012005', 'II/2006_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_37', 'Miercoles', '2', '651', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012005', 'II/2006_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_301', 'Sabado', '2', '641', 0, '01:30:00', '03:00:00', 'II/2006', '10', '12', '2012005', 'II/2006_17');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_41', 'Martes', '1', '652', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012042', 'II/2006_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_40', 'Martes', '1', '625A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012042', 'II/2006_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_39', 'Lunes', '1', '625A', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012042', 'II/2006_20');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_46', 'Miercoles', '1', '655', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012024', 'II/2006_22');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_45', 'Martes', '1', '642', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012024', 'II/2006_22');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_44', 'Miercoles', '1', '617C', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012043', 'II/2006_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_43', 'Martes', '1', '612A', 0, '04:30:00', '06:00:00', 'II/2006', '14', '16', '2012043', 'II/2006_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_42', 'Lunes', '1', '661', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012043', 'II/2006_21');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_53', 'Miercoles', '1', '655', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012033', 'II/2006_25');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_52', 'Lunes', '1', '641', 0, '06:45:00', '09:00:00', 'II/2006', '1', '4', '2012033', 'II/2006_25');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_55', 'Viernes', '1', '641', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012039', 'II/2006_26');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_54', 'Martes', '1', '652', 0, '06:45:00', '09:00:00', 'II/2006', '1', '4', '2012039', 'II/2006_26');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_51', 'Sabado', '2', '625A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012060', 'II/2006_24');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_50', 'Jueves', '2', 'MAG-C', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012060', 'II/2006_24');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_49', 'Miercoles', '2', 'MAG-C', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012060', 'II/2006_24');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_275', 'Jueves', '2', '625 C', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012019', 'II/2006_83');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_274', 'Lunes', '2', 'MAGNA', 0, '09:45:00', '12:00:00', 'II/2006', '5', '8', '2012019', 'II/2006_83');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_57', 'Miercoles', '1', '652', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012036', 'II/2006_27');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_56', 'Lunes', '1', '617B', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012036', 'II/2006_27');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_59', 'Jueves', '1', '617C', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012031', 'II/2006_28');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_58', 'Martes', '1', '617C', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012031', 'II/2006_28');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_264', 'Viernes', '2', '651', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012008', 'II/2006_33');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_263', 'Miercoles', '2', '642', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012008', 'II/2006_33');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_262', 'Martes', '2', '623', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012008', 'II/2006_33');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_259', 'Jueves', '1', '642', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012011', 'II/2006_31');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_258', 'Martes', '1', '642', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012011', 'II/2006_31');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_303', 'Miercoles', '1', 'MAG-C', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012008', 'II/2006_32');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_261', 'Viernes', '1', '642', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012008', 'II/2006_32');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_98', 'Martes', '1', '624A', 0, '12:45:00', '03:00:00', 'II/2006', '9', '12', '2012038', 'II/2006_35');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_97', 'Lunes', '1', '622A', 0, '06:45:00', '09:00:00', 'II/2006', '1', '4', '2012038', 'II/2006_35');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_101', 'Martes', '2', '625A', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012002', 'II/2006_36');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_100', 'Lunes', '2', '625A', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012002', 'II/2006_36');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_99', 'Lunes', '2', '625A', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012002', 'II/2006_36');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_115', 'Viernes', '1', '623A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012034', 'II/2006_37');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_114', 'Jueves', '1', '660', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012034', 'II/2006_37');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_113', 'Martes', '1', '655', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012034', 'II/2006_37');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_119', 'Sabado', '1', '625C', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012044', 'II/2006_38');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_117', 'Martes', '1', '673', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012044', 'II/2006_38');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_116', 'Lunes', '1', '617B', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012044', 'II/2006_38');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_123', 'Lunes', '1', '641', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012015', 'II/2006_40');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_125', 'Viernes', '1', '641', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012015', 'II/2006_40');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_124', 'Martes', '1', '641', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012015', 'II/2006_40');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_122', 'Jueves', '1', '625A', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012045', 'II/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_121', 'Viernes', '1', '652', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012045', 'II/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_120', 'Miercoles', '1', '625A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012045', 'II/2006_39');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_128', 'Miercoles', '2', '652', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012026', 'II/2006_85');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_127', 'Martes', '2', '652', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012026', 'II/2006_85');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_126', 'Lunes', '2', '652', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012026', 'II/2006_85');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_226', 'Viernes', '1', 'CAE', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012001', 'II/2006_42');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_225', 'Viernes', '1', '617', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012001', 'II/2006_42');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_129', 'Lunes', '1', '670', 0, '05:15:00', '08:15:00', 'II/2006', '15', '19', '2012001', 'II/2006_42');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_132', 'Sabado', '1', '622 A', 0, '11:15:00', '01:30:00', 'II/2006', '7', '10', '2012051', 'II/2006_43');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_311', 'Lunes', '1', '637 A', 0, '06:45:00', '09:00:00', 'II/2006', '1', '4', '2012051', 'II/2006_43');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_313', 'Viernes', '1', '617', 0, '06:45:00', '09:00:00', 'II/2006', '17', '20', '2012055', 'II/2006_44');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_312', 'Sabado', '1', '624 A', 0, '06:45:00', '09:00:00', 'II/2006', '1', '4', '2012055', 'II/2006_44');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_308', 'Viernes', '1', '625C', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012035', 'II/2006_46');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_140', 'Jueves', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012035', 'II/2006_46');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_139', 'Miercoles', '1', '625B', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012035', 'II/2006_46');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_309', 'Viernes', '1', 'MAG-C', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012013', 'II/2006_47');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_143', 'Jueves', '1', '641', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012013', 'II/2006_47');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_142', 'Miercoles', '1', '625B', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012013', 'II/2006_47');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_310', 'Viernes', '2', '656', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012013', 'II/2006_45');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_144', 'Miercoles', '2', '625B', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012013', 'II/2006_45');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_137', 'Jueves', '2', '642', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012013', 'II/2006_45');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_147', 'Viernes', '1', '617C', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012028', 'II/2006_48');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_146', 'Jueves', '1', '617C', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012028', 'II/2006_48');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_145', 'Lunes', '1', '654', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012028', 'II/2006_48');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_150', 'Viernes', '1', '617C', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012050', 'II/2006_49');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_149', 'Jueves', '1', '654', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012050', 'II/2006_49');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_148', 'Lunes', '1', '612A', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012050', 'II/2006_49');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_153', 'Viernes', '1', '652', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012047', 'II/2006_50');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_152', 'Jueves', '1', '625C', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012047', 'II/2006_50');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_151', 'Lunes', '1', '654', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012047', 'II/2006_50');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_337', 'Lunes', '1', '642', 0, '06:45:00', '09:00:00', 'II/2006', '17', '20', '2012032', 'II/2006_51');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_155', 'Sabado', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012032', 'II/2006_51');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_158', 'Viernes', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012027', 'II/2006_52');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_157', 'Jueves', '1', '642', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012027', 'II/2006_52');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_156', 'Martes', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012027', 'II/2006_52');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_160', 'Sabado', '1', '617C', 0, '03:45:00', '06:45:00', 'II/2006', '13', '17', '2012006', 'II/2006_53');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_159', 'Lunes', '1', '617C', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012006', 'II/2006_53');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_163', 'Sabado', '1', '612A', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012053', 'II/2006_81');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_162', 'Miercoles', '1', '625A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012053', 'II/2006_81');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_161', 'Lunes', '1', '612A', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012053', 'II/2006_81');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_166', 'Viernes', '1', '651', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012016', 'II/2006_55');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_165', 'Sabado', '1', '625D', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012016', 'II/2006_55');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_164', 'Martes', '1', '651', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012016', 'II/2006_55');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_171', 'Sabado', '1', '674', 0, '11:15:00', '01:30:00', 'II/2006', '7', '10', '2012025', 'II/2006_58');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_170', 'Sabado', '1', '642', 0, '08:15:00', '10:30:00', 'II/2006', '3', '6', '2012025', 'II/2006_58');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_175', 'Jueves', '1', 'civ', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012048', 'II/2006_60');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_174', 'Miercoles', '1', 'civ', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012048', 'II/2006_60');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_173', 'Martes', '1', 'civ', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012048', 'II/2006_60');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_172', 'Jueves', '2', '625A', 0, '11:15:00', '01:30:00', 'II/2006', '7', '10', '2012007', 'II/2006_59');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_317', 'Jueves', '2', 'MAG-C', 0, '03:45:00', '06:00:00', 'II/2006', '13', '16', '2012023', 'II/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_319', 'Miercoles', '2', 'MAG-C', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012023', 'II/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_282', 'Lunes', '2', 'MAG-C', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012023', 'II/2006_86');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_183', 'Viernes', '1', '624 A', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012037', 'II/2006_63');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_182', 'Jueves', '1', '624 A', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012037', 'II/2006_63');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_181', 'Martes', '1', '622 A', 0, '10:30:00', '12:00:00', 'II/2006', '6', '8', '2012037', 'II/2006_63');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_180', 'Viernes', '2', 'MAG-C', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012020', 'II/2006_92');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_179', 'Jueves', '2', 'MAG-C', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012020', 'II/2006_92');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_178', 'Martes', '2', 'MAG-C', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012020', 'II/2006_92');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_177', 'Viernes', '1', 'MAG-C', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012010', 'II/2006_61');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_320', 'Miercoles', '1', 'MAG-C', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012010', 'II/2006_61');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_186', 'Jueves', '1', '641', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012021', 'II/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_185', 'Lunes', '1', '642', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012021', 'II/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_184', 'Lunes', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012021', 'II/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_184', 'Lunes', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012021', 'II/2006_64');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_189', 'Viernes', '1', '641', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012014', 'II/2006_65');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_188', 'Jueves', '1', '642', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012014', 'II/2006_65');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_187', 'Lunes', '1', '642', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012014', 'II/2006_65');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_326', 'Miercoles', '1', '612', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012003', 'II/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_325', 'Martes', '1', '612', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012003', 'II/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_324', 'Lunes', '1', '625 B', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012003', 'II/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_323', 'Miercoles', '1', '612', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012003', 'II/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_322', 'Martes', '1', '612', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012003', 'II/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_321', 'Lunes', '1', '625 B', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012003', 'II/2006_66');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_193', 'Viernes', '2', '660', 0, '02:15:00', '05:15:00', 'II/2006', '11', '15', '2012001', 'II/2006_68');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_192', 'Lunes', '2', 'CAE', 0, '02:15:00', '05:15:00', 'II/2006', '11', '15', '2012001', 'II/2006_68');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_196', 'Jueves', '1', '651', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012017', 'II/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_195', 'Martes', '1', '661', 0, '12:00:00', '01:30:00', 'II/2006', '8', '10', '2012017', 'II/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_194', 'Lunes', '1', '617B', 0, '12:00:00', '01:30:00', 'II/2006', '8', '10', '2012017', 'II/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_194', 'Lunes', '1', '617B', 0, '12:00:00', '01:30:00', 'II/2006', '8', '10', '2012017', 'II/2006_69');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_328', 'Viernes', '1', 'MAG-C', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012020', 'II/2006_93');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_327', 'Lunes', '1', 'MAG-C', 0, '06:00:00', '08:15:00', 'II/2006', '16', '19', '2012020', 'II/2006_93');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_198', 'Viernes', '1', 'CAMPO', 0, '11:15:00', '02:15:00', 'II/2006', '7', '11', '2012006', 'II/2006_70');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_197', 'Martes', '1', '625A', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012006', 'II/2006_70');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_200', 'Miercoles', '1', '647C', 0, '06:45:00', '09:00:00', 'II/2006', '17', '20', '2012026', 'II/2006_72');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_199', 'Lunes', '1', '623', 0, '06:45:00', '09:00:00', 'II/2006', '17', '20', '2012026', 'II/2006_72');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_240', 'Martes', '1', '642', 0, '08:15:00', '09:45:00', 'II/2006', '19', '20', '2012009', 'II/2006_73');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_201', 'Lunes', '1', '617B', 0, '02:15:00', '05:15:00', 'II/2006', '11', '15', '2012009', 'II/2006_73');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_208', 'Viernes', '1', '642', 0, '06:45:00', '08:15:00', 'II/2006', '1', '3', '2012002', 'II/2006_75');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_207', 'Miercoles', '1', '642', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012002', 'II/2006_75');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_206', 'Lunes', '1', '622', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012002', 'II/2006_75');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_239', 'Viernes', '1', '660', 0, '06:45:00', '08:15:00', 'II/2006', '17', '19', '2012060', 'II/2006_74');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_205', 'Jueves', '1', '622', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012060', 'II/2006_74');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_203', 'Lunes', '1', '622', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012060', 'II/2006_74');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_291', 'Jueves', '2', '625 C', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012027', 'II/2006_91');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_219', 'Miercoles', '2', '625 D', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012027', 'II/2006_91');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_287', 'Lunes', '2', 'MAG-C', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012027', 'II/2006_91');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_316', 'Viernes', '2', '625 D', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012022', 'II/2006_89');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_289', 'Jueves', '2', 'MAG-C', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012022', 'II/2006_89');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_315', 'Martes', '2', 'MAG-C', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012022', 'II/2006_89');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_288', 'Miercoles', '2', 'MAG-C', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012012', 'II/2006_88');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_314', 'Lunes', '2', 'MAG-C', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012012', 'II/2006_88');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_224', 'Sabado', '1', '617B', 0, '08:15:00', '09:45:00', 'II/2006', '3', '5', '2012012', 'II/2006_79');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_223', 'Martes', '1', '654', 0, '12:45:00', '02:15:00', 'II/2006', '9', '11', '2012012', 'II/2006_79');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_331', 'Jueves', '2', '656', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012003', 'II/2006_94');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_330', 'Miercoles', '2', '656', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012003', 'II/2006_94');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_329', 'Lunes', '2', '607', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012003', 'II/2006_94');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_334', 'Viernes', '2', 'MAG-C', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012025', 'II/2006_95');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_333', 'Jueves', '2', 'MAG-C', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012025', 'II/2006_95');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_332', 'Martes', '2', 'MAG-C', 0, '03:45:00', '05:15:00', 'II/2006', '13', '15', '2012025', 'II/2006_95');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_336', 'Viernes', '2', 'MAG-C', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012010', 'II/2006_96');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_335', 'Martes', '2', 'MAG-C', 0, '02:15:00', '03:45:00', 'II/2006', '11', '13', '2012010', 'II/2006_96');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_338', 'Lunes', '2', '655', 0, '05:15:00', '06:45:00', 'II/2006', '15', '17', '2012009', 'II/2006_98');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_339', 'Martes', '2', 'MAGNA', 0, '11:15:00', '12:45:00', 'II/2006', '7', '9', '2012009', 'II/2006_98');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('II/2006_340', 'Viernes', '2', '656', 0, '09:45:00', '11:15:00', 'II/2006', '5', '7', '2012009', 'II/2006_98');


--
-- TOC entry 2512 (class 0 OID 29982)
-- Dependencies: 179
-- Data for Name: hist_materia_dicta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2005_5', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 3, 12, 0, 'INVITADO', 'II/2005', 0, 12, 'II/2005_000001', 'II/2005_000002', 'MAT2005_000019');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2005_21', 'AEROPUERTOS', '2012043', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2005', 0, 24, 'II/2005_000008', 'II/2005_000003', 'MAT2005_000057');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2005_20', 'CARRETERAS II', '2012042', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2005', 0, 24, 'II/2005_000008', 'II/2005_000003', 'MAT2005_000056');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2005_22', 'MAQUINARIA Y EQUIPO DE CONSTRUCCION', '2012024', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 4, 8, 8, 'TITULAR', 'II/2005', 0, 16, 'II/2005_000008', 'II/2005_000003', 'MAT2005_000039');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_5', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 3, 12, 0, 'INVITADO', 'I/2006', 0, 12, 'I/2006_000001', 'I/2006_000002', 'MAT2005_000019');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_7', 'INGENIERIA SANITARIA I', '2012016', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 0, 'I/2006_000002', 'I/2006_000006', 'MAT2005_000031');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_30', 'INGENIERIA SANITARIA II', '2012022', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 0, 'I/2006_000002', 'I/2006_000006', 'MAT2005_000037');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_82', 'INSTALACIONES DOMICILIARIAS E INDUSTRIALES', '2012054', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 0, 'I/2006_000002', 'I/2006_000006', 'MAT2005_000065');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_8', 'OBRAS HIDRAULICAS I', '2012029', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'I/2006', 0, 0, 'I/2006_000002', 'I/2006_000006', 'MAT2005_000044');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_10', 'GEOG. Y DEF. DE LOS RECURSOS NATURALES', '2012010', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 8, 8, 'INVITADO', 'I/2006', 88, 200, 'I/2006_000002', 'I/2006_000006', 'MAT2005_000024');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_16', 'QUIMICA DEL AGUA', '2012061', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 24, 'I/2006_000006', 'I/2006_00024', 'MAT2005_000067');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_20', 'CARRETERAS II', '2012042', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 24, 'I/2006_000008', 'I/2006_000003', 'MAT2005_000056');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_22', 'MAQUINARIA Y EQUIPO DE CONSTRUCCION', '2012024', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 8, 8, 'TITULAR', 'I/2006', 0, 16, 'I/2006_000008', 'I/2006_000003', 'MAT2005_000039');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_21', 'AEROPUERTOS', '2012043', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 24, 'I/2006_000008', 'I/2006_000003', 'MAT2005_000057');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_25', 'FUNDACIONES I', '2012033', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 5, 12, 8, 'TITULAR', 'I/2006', 0, 0, 'I/2006_000009', 'I/2006_000004', 'MAT2005_000048');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_26', 'FUNDACIONES II', '2012039', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 5, 12, 8, 'TITULAR', 'I/2006', 0, 0, 'I/2006_000009', 'I/2006_000004', 'MAT2005_000055');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_24', 'ANALISIS NUMERICO', '2012060', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'I/2006', 116, 200, 'I/2006_000009', 'I/2006_000004', 'MAT2005_000020');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_28', 'CONSTRUCCION DE EDIFICIOS', '2012031', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 5, 12, 8, 'TITULAR', 'I/2006', 0, 20, 'I/2006_00010', 'I/2006_000005', 'MAT2005_000046');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_27', 'HORMIGON PREESFORZADO', '2012036', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00010', 'I/2006_000005', 'MAT2005_000052');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_33', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'I/2006', 0, 0, 'I/2006_00011', 'I/2006_000007', 'MAT2005_000022');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_34', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'I/2006', 0, 0, 'I/2006_00011', 'I/2006_000007', 'MAT2005_000022');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_31', 'HIDRAULICA II', '2012011', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 4, 12, 'TITULAR', 'I/2006', 0, 0, 'I/2006_00011', 'I/2006_000007', 'MAT2005_000026');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_32', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 16, 0, 'TITULAR', 'I/2006', 0, 56, 'I/2006_00011', 'I/2006_000007', 'MAT2005_000022');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_35', 'ESTRUCTURAS ESPECIALES', '2012038', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 12, 12, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00012', 'I/2006_000008', 'MAT2005_000054');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_36', 'COMPUTACION PARA INGENIERIA', '2012002', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00012', 'I/2006_000008', 'MAT2005_000013');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_38', 'INGENIERIA DE TRAFICO', '2012044', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00014', 'I/2006_000009', 'MAT2005_000058');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_40', 'TRANSPORTES Y COMUNICACIONES', '2012015', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00015', 'I/2006_00010', 'MAT2005_000030');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_39', 'VIAS FERREAS', '2012045', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00015', 'I/2006_00010', 'MAT2005_000059');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_42', 'DIBUJO TECNICO', '2012001', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 8, 16, 16, 'INVITADO', 'I/2006', 0, 32, 'I/2006_00016', 'I/2006_00011', 'MAT2005_000010');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_43', 'HIDRAULICA DE RIOS', '2012051', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00017', 'I/2006_00012', 'MAT2005_000063');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_44', 'OBRAS HIDRAULICAS II', '2012055', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00017', 'I/2006_00012', 'MAT2005_000066');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_46', 'PUENTES', '2012035', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00018', 'I/2006_00013', 'MAT2005_000051');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_47', 'RESISTENCIA DE MATERIALES II', '2012013', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00018', 'I/2006_00013', 'MAT2005_000028');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_45', 'RESISTENCIA DE MATERIALES II', '2012013', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00018', 'I/2006_00013', 'MAT2005_000028');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_48', 'PLANIFICACION DE PROYECTO DE GRADO', '2012028', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00019', 'I/2006_00014', 'MAT2005_000043');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_49', 'PUERTOS Y VIAS NAVEGABLES', '2012050', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 4, 20, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00019', 'I/2006_00014', 'MAT2005_000062');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_50', 'MODELOS HIDRAULICOS', '2012047', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 88, 160, 'I/2006_00019', 'I/2006_00014', 'MAT2005_000060');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_53', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00022', 'I/2006_00015', 'MAT2005_000018');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_81', 'PLANTAS DE TRATAMIENTO AGUAS', '2012053', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00023', 'I/2006_00016', 'MAT2005_000064');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_55', 'INGENIERIA SANITARIA I', '2012016', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00023', 'I/2006_00016', 'MAT2005_000031');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_60', 'TEMAS ESPECIALES', '2012048', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00025', 'I/2006_00017', 'MAT2005_000061');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_59', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 3, 12, 0, 'INVITADO', 'I/2006', 108, 160, 'I/2006_00025', 'I/2006_00017', 'MAT2005_000019');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_63', 'INGENIERIA ANTISISMICA', '2012037', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'I/2006', 0, 0, 'I/2006_00026', 'I/2006_00018', 'MAT2005_000053');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_62', 'SISTEMAS DE INGENIERIA', '2012020', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00026', 'I/2006_00018', 'MAT2005_000035');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_61', 'GEOG. Y DEF. DE LOS RECURSOS NATURALES', '2012010', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 4, 8, 8, 'INVITADO', 'I/2006', 64, 160, 'I/2006_00026', 'I/2006_00018', 'MAT2005_000024');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_66', 'GEOLOGIA GENERAL', '2012003', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00028', 'I/2006_00019', 'MAT2005_000014');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_68', 'DIBUJO TECNICO', '2012001', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 8, 8, 24, 'INVITADO', 'I/2006', 0, 32, 'I/2006_00029', 'I/2006_00020', 'MAT2005_000010');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_70', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'I/2006', 0, 24, 'I/2006_00031', 'I/2006_00021', 'MAT2005_000018');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_72', 'CARRETERAS I', '2012026', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00031', 'I/2006_00021', 'MAT2005_000041');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_75', 'COMPUTACION PARA INGENIERIA', '2012002', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'TITULAR', 'I/2006', 0, 0, 'I/2006_00032', 'I/2006_00022', 'MAT2005_000013');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_73', 'GEODESIA Y FOTOGRAMETRIA', '2012009', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00032', 'I/2006_00022', 'MAT2005_000023');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_74', 'ANALISIS NUMERICO', '2012060', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'I/2006', 0, 24, 'I/2006_00032', 'I/2006_00022', 'MAT2005_000020');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_78', 'SISTEMAS DE INGENIERIA', '2012020', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 0, 0, 'I/2006_00033', 'I/2006_00023', 'MAT2005_000035');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2006_77', 'GEOLOGIA GENERAL', '2012003', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'I/2006', 112, 160, 'I/2006_00033', 'I/2006_00023', 'MAT2005_000014');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_5', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 3, 12, 0, 'INVITADO', 'II/2006', 0, 12, 'II/2006_000001', 'II/2006_000002', 'MAT2005_000019');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_7', 'INGENIERIA SANITARIA I', '2012016', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_000002', 'II/2006_000006', 'MAT2005_000031');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_30', 'INGENIERIA SANITARIA II', '2012022', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_000002', 'II/2006_000006', 'MAT2005_000037');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_82', 'INSTALACIONES DOMICILIARIAS E INDUSTRIALES', '2012054', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'II/2006', 0, 0, 'II/2006_000002', 'II/2006_000006', 'MAT2005_000065');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_8', 'OBRAS HIDRAULICAS I', '2012029', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'II/2006', 0, 0, 'II/2006_000002', 'II/2006_000006', 'MAT2005_000044');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_16', 'QUIMICA DEL AGUA', '2012061', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_000006', 'II/2006_00024', 'MAT2005_000067');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_20', 'CARRETERAS II', '2012042', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_000008', 'II/2006_000003', 'MAT2005_000056');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_22', 'MAQUINARIA Y EQUIPO DE CONSTRUCCION', '2012024', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 8, 8, 'TITULAR', 'II/2006', 0, 16, 'II/2006_000008', 'II/2006_000003', 'MAT2005_000039');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_21', 'AEROPUERTOS', '2012043', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_000008', 'II/2006_000003', 'MAT2005_000057');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_25', 'FUNDACIONES I', '2012033', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 5, 12, 8, 'TITULAR', 'II/2006', 0, 0, 'II/2006_000009', 'II/2006_000004', 'MAT2005_000048');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_26', 'FUNDACIONES II', '2012039', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 5, 12, 8, 'TITULAR', 'II/2006', 0, 0, 'II/2006_000009', 'II/2006_000004', 'MAT2005_000055');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_24', 'ANALISIS NUMERICO', '2012060', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 116, 200, 'II/2006_000009', 'II/2006_000004', 'MAT2005_000020');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_83', 'TECNOLOGIA DEL HORMIGON', '2012019', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 5, 8, 12, 'INVITADO', 'II/2006', 0, 0, 'II/2006_000009', 'II/2006_000004', 'MAT2005_000034');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_27', 'HORMIGON PREESFORZADO', '2012036', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00010', 'II/2006_000005', 'MAT2005_000052');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_28', 'CONSTRUCCION DE EDIFICIOS', '2012031', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 5, 12, 8, 'TITULAR', 'II/2006', 0, 20, 'II/2006_00010', 'II/2006_000005', 'MAT2005_000046');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_33', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'II/2006', 0, 0, 'II/2006_00011', 'II/2006_000007', 'MAT2005_000022');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_34', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'II/2006', 0, 0, 'II/2006_00011', 'II/2006_000007', 'MAT2005_000022');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_31', 'HIDRAULICA II', '2012011', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 4, 12, 'TITULAR', 'II/2006', 0, 0, 'II/2006_00011', 'II/2006_000007', 'MAT2005_000026');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_32', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 4, 8, 8, 'TITULAR', 'II/2006', 0, 56, 'II/2006_00011', 'II/2006_000007', 'MAT2005_000022');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_35', 'ESTRUCTURAS ESPECIALES', '2012038', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 12, 12, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00012', 'II/2006_000008', 'MAT2005_000054');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_36', 'COMPUTACION PARA INGENIERIA', '2012002', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00012', 'II/2006_000008', 'MAT2005_000013');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_38', 'INGENIERIA DE TRAFICO', '2012044', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00014', 'II/2006_000009', 'MAT2005_000058');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_40', 'TRANSPORTES Y COMUNICACIONES', '2012015', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00015', 'II/2006_00010', 'MAT2005_000030');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_39', 'VIAS FERREAS', '2012045', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00015', 'II/2006_00010', 'MAT2005_000059');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_85', 'CARRETERAS I', '2012026', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 88, 160, 'II/2006_00015', 'II/2006_00010', 'MAT2005_000041');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_42', 'DIBUJO TECNICO', '2012001', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 8, 16, 16, 'INVITADO', 'II/2006', 0, 32, 'II/2006_00016', 'II/2006_00011', 'MAT2005_000010');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_43', 'HIDRAULICA DE RIOS', '2012051', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00017', 'II/2006_00012', 'MAT2005_000063');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_44', 'OBRAS HIDRAULICAS II', '2012055', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00017', 'II/2006_00012', 'MAT2005_000066');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_46', 'PUENTES', '2012035', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00018', 'II/2006_00013', 'MAT2005_000051');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_47', 'RESISTENCIA DE MATERIALES II', '2012013', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00018', 'II/2006_00013', 'MAT2005_000028');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_45', 'RESISTENCIA DE MATERIALES II', '2012013', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00018', 'II/2006_00013', 'MAT2005_000028');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_48', 'PLANIFICACION DE PROYECTO DE GRADO', '2012028', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00019', 'II/2006_00014', 'MAT2005_000043');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_49', 'PUERTOS Y VIAS NAVEGABLES', '2012050', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 4, 20, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00019', 'II/2006_00014', 'MAT2005_000062');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_50', 'MODELOS HIDRAULICOS', '2012047', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'INVITADO', 'II/2006', 88, 160, 'II/2006_00019', 'II/2006_00014', 'MAT2005_000060');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_53', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00022', 'II/2006_00015', 'MAT2005_000018');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_81', 'PLANTAS DE TRATAMIENTO AGUAS', '2012053', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00023', 'II/2006_00016', 'MAT2005_000064');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_55', 'INGENIERIA SANITARIA I', '2012016', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00023', 'II/2006_00016', 'MAT2005_000031');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_60', 'TEMAS ESPECIALES', '2012048', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00025', 'II/2006_00017', 'MAT2005_000061');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_59', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 3, 12, 0, 'INVITADO', 'II/2006', 124, 160, 'II/2006_00025', 'II/2006_00017', 'MAT2005_000019');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_86', 'HORMIGON ARMADO', '2012023', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 7, 20, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00026', 'II/2006_00018', 'MAT2005_000038');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_63', 'INGENIERIA ANTISISMICA', '2012037', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'II/2006', 0, 0, 'II/2006_00026', 'II/2006_00018', 'MAT2005_000053');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_92', 'SISTEMAS DE INGENIERIA', '2012020', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00026', 'II/2006_00018', 'MAT2005_000035');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_61', 'GEOG. Y DEF. DE LOS RECURSOS NATURALES', '2012010', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 4, 8, 8, 'INVITADO', 'II/2006', 68, 160, 'II/2006_00026', 'II/2006_00018', 'MAT2005_000024');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_66', 'GEOLOGIA GENERAL', '2012003', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00028', 'II/2006_00019', 'MAT2005_000014');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_68', 'DIBUJO TECNICO', '2012001', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 8, 8, 24, 'INVITADO', 'II/2006', 0, 32, 'II/2006_00029', 'II/2006_00020', 'MAT2005_000010');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_70', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 8, 16, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00031', 'II/2006_00021', 'MAT2005_000018');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_72', 'CARRETERAS I', '2012026', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00031', 'II/2006_00021', 'MAT2005_000041');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_73', 'GEODESIA Y FOTOGRAMETRIA', '2012009', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00032', 'II/2006_00022', 'MAT2005_000023');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_75', 'COMPUTACION PARA INGENIERIA', '2012002', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 8, 16, 'TITULAR', 'II/2006', 0, 0, 'II/2006_00032', 'II/2006_00022', 'MAT2005_000013');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_74', 'ANALISIS NUMERICO', '2012060', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'ING. CIVIL', 6, 16, 8, 'TITULAR', 'II/2006', 0, 24, 'II/2006_00032', 'II/2006_00022', 'MAT2005_000020');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_91', 'INGENIERIA ECONOMICA', '2012027', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00033', 'II/2006_00023', 'MAT2005_000042');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_89', 'INGENIERIA SANITARIA II', '2012022', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00033', 'II/2006_00023', 'MAT2005_000037');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_88', 'HIDROLOGIA', '2012012', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 4, 8, 8, 'INVITADO', 'II/2006', 96, 160, 'II/2006_00033', 'II/2006_00023', 'MAT2005_000027');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_94', 'GEOLOGIA GENERAL', '2012003', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00035', 'II/2006_00025', 'MAT2005_000014');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_95', 'MECANICA DE SUELOS APLICADA', '2012025', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 0, 'II/2006_00035', 'II/2006_00025', 'MAT2005_000040');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_96', 'GEOG. Y DEF. DE LOS RECURSOS NATURALES', '2012010', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 4, 8, 8, 'INVITADO', 'II/2006', 96, 160, 'II/2006_00035', 'II/2006_00025', 'MAT2005_000024');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('II/2006_98', 'GEODESIA Y FOTOGRAMETRIA', '2012009', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'II/2006', 0, 24, 'II/2006_00036', 'II/2006_00026', 'MAT2005_000023');


--
-- TOC entry 2513 (class 0 OID 29985)
-- Dependencies: 180
-- Data for Name: hist_materia_labo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_6', 'LAB  HIDRAULICA', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'I/2006', 'LAB0001', 'LAB', 'I/2006_000004', 'I/2006_000003', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_7', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'I/2006', '2012008', 'MAT', 'I/2006_000005', 'I/2006_00014', 'MAT2005_000022', '');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_29', 'LAB RESIST  MAT', 'LRUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0003', 'LAB', 'I/2006_000006', 'NULL', '', 'LAB0003');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_28', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0004', 'LAB', 'I/2006_000006', 'NULL', '', 'LAB0004');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_11', 'CASA', 'CASA', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0004', 'LAB', 'I/2006_000007', 'I/2006_000004', '', 'LAB0004');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_12', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'I/2006', 'LAB0002', 'LAB', 'I/2006_000008', 'I/2006_000005', '', 'LAB0002');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_13', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'I/2006', 'LAB0002', 'LAB', 'I/2006_000009', 'I/2006_000006', '', 'LAB0002');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_14', 'MET GEODISICOS', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0005', 'LAB', 'I/2006_00010', 'I/2006_000007', '', 'LAB0005');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_15', 'LAB RESIST MATERIALES', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 11, 0, 11, 'I/2006', 'LAB0003', 'LAB', 'I/2006_00011', 'NULL', '', 'LAB0003');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_16', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0002', 'LAB', 'I/2006_00012', 'I/2006_000008', '', 'LAB0002');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_17', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'I/2006', 'LAB0001', 'LAB', 'I/2006_00013', 'I/2006_000009', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_18', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0001', 'LAB', 'I/2006_00014', 'I/2006_00010', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_19', 'HIDRAULICA II', '2012011', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'I/2006', '2012011', 'MAT', 'I/2006_00015', 'I/2006_00011', 'MAT2005_000026', '');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_24', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'I/2006', 'LAB0001', 'LAB', 'I/2006_00017', 'I/2006_00012', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_25', 'GAB GEODESIA', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0006', 'LAB', 'I/2006_00018', 'I/2006_00013', '', 'LAB0006');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('I/2006_27', 'MET GEODISICOS', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'I/2006', 'LAB0005', 'LAB', 'I/2006_00018', 'I/2006_00013', '', 'LAB0005');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_25', 'GAB GEODESIA', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0006', 'LAB', 'II/2006_00018', 'II/2006_00013', '', 'LAB0006');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_27', 'MET GEODISICOS', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0005', 'LAB', 'II/2006_00018', 'II/2006_00013', '', 'LAB0005');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_30', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'II/2006', 'LAB0001', 'LAB', 'II/2006_00019', 'II/2006_00015', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_31', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'II/2006', 'LAB0001', 'LAB', 'II/2006_00020', 'II/2006_00018', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_32', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0001', 'LAB', 'II/2006_00021', 'II/2006_00017', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_33', 'LAB RESIST  MAT', 'LRUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0003', 'LAB', 'II/2006_00022', 'II/2006_00021', '', 'LAB0003');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_34', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'II/2006', 'LAB0007', 'LAB', 'II/2006_00023', 'II/2006_00016', '', 'LAB0007');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_36', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0002', 'LAB', 'II/2006_00025', 'II/2006_00019', '', 'LAB0002');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_37', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'II/2006', 'LAB0002', 'LAB', 'II/2006_00026', 'II/2006_00022', '', 'LAB0002');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_38', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'II/2006', '2012008', 'MAT', 'II/2006_00027', 'II/2006_00024', 'MAT2005_000022', '');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_39', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0004', 'LAB', 'II/2006_00028', 'II/2006_00025', '', 'LAB0004');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_40', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0004', 'LAB', 'II/2006_00029', 'II/2006_00026', '', 'LAB0004');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_41', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'II/2006', 'LAB0002', 'LAB', 'II/2006_00030', 'II/2006_00023', '', 'LAB0002');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_42', 'MET GEODESICOS', 'CIV214', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 0, 0, 0, 'II/2006', 'LAB0005', 'LAB', 'II/2006_00031', 'II/2006_00029', '', 'LAB0005');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_43', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', '2012006', 'MAT', 'II/2006_00032', 'NULL', 'MAT2005_000018', '');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_45', 'HIDRAULICA II', '2012011', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'II/2006', '2012011', 'MAT', 'II/2006_00033', 'II/2006_00027', 'MAT2005_000026', '');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_46', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'II/2006', 'LAB0001', 'LAB', 'II/2006_00034', 'II/2006_00028', '', 'LAB0001');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_47', 'MET GEODESICOS', 'CIV214', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0005', 'LAB', 'II/2006_00035', 'II/2006_00030', '', 'LAB0005');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_48', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0007', 'LAB', 'II/2006_00036', 'II/2006_00031', '', 'LAB0007');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_49', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0007', 'LAB', 'II/2006_00037', 'NULL', '', 'LAB0007');
INSERT INTO hist_materia_labo (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio) VALUES ('II/2006_50', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'II/2006', 'LAB0007', 'LAB', 'II/2006_00038', 'II/2006_00032', '', 'LAB0007');


--
-- TOC entry 2514 (class 0 OID 29988)
-- Dependencies: 181
-- Data for Name: hist_nombra_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000004', 'TERCEROS GARCIA MARIA CLAUDIA', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-09', '2006-02-09', 'DOS SEMESTRES', 'I/2006', 10, 'AUX2006_000005');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000005', 'RODRIGUEZ ALVAREZ LILIANA ARACELI', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-09', '2006-02-09', 'DOS SEMESTRES', 'I/2006', 20, 'AUX2006_000006');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_00012', 'ROMAY BORTOLINI JOSE MARIA SALVADOR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-09', '2006-02-09', 'DOS SEMESTRES', 'I/2006', 20, 'AUX2006_000015');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_00010', 'BALDELLON ALVAREZ RONALD', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-02-20', 'UN SEMESTRE', 'I/2006', 10, 'AUX2006_000012');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000006', 'CAMACHO PE?A MARCO ANTONIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-02-20', 'UN SEMESTRES', 'I/2006', 20, 'AUX2006_000007');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000008', 'MENESES ESPINOZA ALVARO ALEJANDRO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'interno', '2006-02-20', '2006-02-20', 'UN SEMESTRE', 'I/2006', 10, 'AUX2006_000010');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000009', 'BUSTAMANTE PONCE MAURICIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRES', 'I/2006', 20, 'AUX2005_000001');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_00013', 'ESCOBAR SALGUERO CLAUDIA', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRE', 'I/2006', 20, 'AUX2006_000016');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000007', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRE', 'I/2006', 10, 'AUX2006_000008');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000003', 'GONZALEZ SANCHEZ ALVARO DE JESUS', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'I/2006', 20, 'AUX2006_000011');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_00011', 'MENDIZABAL HERBAS CARLO ANTONIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'interno', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'I/2006', 2, 'AUX2006_000013');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_00014', 'UNZUETA ZEBALLOS JOSE ANTONIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'I/2006', 2, 'AUX2006_000003');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('I/2006_000002', 'FERRUFINO HINOJOSA JAVIER', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'I/2006', 20, 'AUX2006_000004');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_000007', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRE', 'II/2006', 10, 'AUX2006_000008');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00013', 'ESCOBAR SALGUERO CLAUDIA', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRE', 'II/2006', 20, 'AUX2006_000016');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00016', 'QUIROGA ROJAS MAURICIO GONZALO', 'ING. CIVIL', 'INGENIER?A CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'AUX2006_000028');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00015', 'TORREJON O?O FABIOLA ESCARLET', 'ING. CIVIL', 'INGENIER?A CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'AUX2006_000027');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00018', 'ABASTO CRUZ ENRRIQUE', 'ING. CIVIL', 'INGENIER?A CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'AUX2006_000026');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00019', 'CAMACHO PE?A CHRISTIAM BORIS', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000020');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00021', 'RODRIGUEZ MARTINEZ JUAN', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000023');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00022', 'RODRIGUEZ ALVAREZ LILIANA ARACELI', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'AUX2006_000006');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00023', 'UGARTE ONTIVEROS VLADIMIR', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'AUX2006_000019');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00025', 'MONTA?O MONTECINOS JESUS ANTONIO', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000021');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00026', 'ANAYA DOMINGUEZ JAIME ALFREDO', '', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000022');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00020', 'MAMANI GUZMAN BENITO', 'ING. CIVIL', 'INGENIERIA CIVIL ', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000024');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00014', 'UNZUETA ZEBALLOS JOSE ANTONIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'II/2006', 2, 'AUX2006_000003');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00027', 'UNZUETA ZEBALLOS JOSE ANTONIO', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-25', 'DOS SEMESTRES', 'II/2006', 2, 'AUX2006_000032');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00024', 'MARTINEZ ARCE ARIEL', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 2, 'AUX2006_000025');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00028', 'BUSTAMANTE CHAVEZ ARIEL RENE', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'interno', '2006-08-08', '2006-08-28', 'DOS SEMESTRES', 'II/2006', 20, 'AUX2006_000033');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00017', 'COLLARANI ANAGUA FREDDY GUIDO', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'interno', '2006-08-08', '2006-08-28', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000029');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00029', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-10-13', '2006-10-13', 'DOS SEMESTRES', 'II/2006', 0, 'AUX2006_000017');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00030', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'CAMPO', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-10-13', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000034');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00031', 'RIOJA HERRERA HEDBERT', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-10-27', '2006-10-27', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000035');
INSERT INTO hist_nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_auxiliar) VALUES ('II/2006_00032', 'BARRIOS COLOMO ANGELA MARIA', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-10-27', '2006-10-27', 'DOS SEMESTRES', 'II/2006', 10, 'AUX2006_000038');


--
-- TOC entry 2515 (class 0 OID 29991)
-- Dependencies: 182
-- Data for Name: hist_nombra_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2005_000001', 'ALVARADO RIVAS MERY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'ING CIVIL', 'INGENIERO CIVIL', 'parcial', '2005-07-20', '2005-07-20', 'UN SEMESTRE', 'I/2005', 4, 'DOC0001');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2005_000002', 'ALVARADO RIVAS MERY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN ECONOMIA', 'LIC ECONOMIA', 'PARCIAL', '2005-08-22', '2005-08-08', 'UN SEMESTRE', 'II/2005', 3, 'DOC0001');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2005_000003', 'AYLLON ACOSTA JAIME', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2005-08-22', '2005-08-19', 'UN SEMESTRE', 'II/2005', 12, 'DOC0006');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00011', 'MENDEZ VELASQUEZ IVAN', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-07', '2006-02-07', 'UN SEMESTRE', 'I/2006', 8, 'DOC0017');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000002', 'ALVARADO RIVAS MERY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN ECONOMIA', 'LIC ECONOMIA', 'PARCIAL', '2006-02-20', '2006-02-10', 'UN SEMESTRE', 'I/2006', 3, 'DOC0001');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000001', 'ALVARADO RIVAS MERY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN ECONOMIA', 'INGENIERO CIVIL', 'PARCIAL', '2006-02-20', '2006-02-10', 'UN SEMESTRE', 'I/2006', 3, 'DOC0001');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000003', 'AYLLON ACOSTA JAIME', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-13', 'UN SEMESTRE', 'I/2006', 12, 'DOC0006');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00024', 'ARNEZ TORRICO MARITZA', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-13', 'UN SEMESTRE', 'I/2006', 6, 'DOC0005');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000005', 'EDUARDO FRANZ MARCELO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-13', 'UN SEMESTRE', 'I/2006', 6, 'DOC0009');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000008', 'FLORERO  ORTU?O OSCAR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-13', 'UN SEMESTRE', 'I/2006', 6, 'DOC0012');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000009', 'LAZARTE  VILLARROEL  LUIS', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-13', 'UN SEMESTRE', 'I/2006', 6, 'DOC0014');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000007', 'ESCOBAR  SELEME MARCO', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-07', '2006-02-07', 'UN SEMESTRE', 'I/2006', 20, 'DOC0011');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00012', 'MENDEZ TORRICO ROBERTO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-15', 'UN SEMESTRE', 'I/2006', 6, 'DOC0018');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00014', 'MU?OZ VASQUEZ GALO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-20', '2006-02-15', 'UN SEMESTRE', 'I/2006', 18, 'DOC0020');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00015', 'PEREIRA MELGAR MARIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-15', 'UN SEMESTRE', 'I/2006', 6, 'DOC0023');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00013', 'MERUVIA MERUVIA JOSE', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 6, 'DOC0019');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00019', 'TORRES  NAVARRO JULIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 6, 'DOC0032');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00020', 'UREY CONTRERAS MARIO F.', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 8, 'DOC0033');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00021', 'VERA  CORTES CARLOS ALBERTO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 6, 'DOC0035');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00022', 'ZABALAGA MONTA?O OSCAR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 6, 'DOC0037');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00016', 'ROCHA CUADROS JUAN CARLOS', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 6, 'DOC0024');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000006', 'ESCALERA VASQUEZ ARMANDO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'I/2006', 22, 'DOC0010');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00017', 'ROMERO  MERIDA  MAURICIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-02-17', 'UN SEMESTRE', 'I/2006', 13, 'DOC0028');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00010', 'LEON  CLAVIJO  GUIDO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-20', '2006-03-24', 'UN SEMESTRE', 'I/2006', 18, 'DOC0016');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_000004', 'DUCHEN  AYALA MARTIN', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-06', '2006-03-24', 'UN SEMESTRE', 'I/2006', 11, 'DOC0008');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00018', 'SAAVEDRA  ANTEZANA RAMIRO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-20', '2006-03-24', 'UN SEMESTRE', 'I/2006', 18, 'DOC0029');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2006_00023', 'SACA VENTURA OSCAR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'ING CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-04-06', '2006-04-12', 'UN SEMESTRE', 'I/2006', 12, 'DOC0038');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000007', 'ESCOBAR  SELEME MARCO', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-02-07', '2006-02-07', 'UN SEMESTRE', 'II/2006', 20, 'DOC0011');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000001', 'ALVARADO RIVAS MERY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN ECONOMIA', 'INGENIERO CIVIL', 'PARCIAL', '2006-08-08', '2006-07-26', 'UN SEMESTRE', 'II/2006', 3, 'DOC0001');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000002', 'ALVARADO RIVAS MERY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN ECONOMIA', 'LIC ECONOMIA', 'PARCIAL', '2006-08-08', '2006-07-27', 'UN SEMESTRE', 'II/2006', 3, 'DOC0001');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000003', 'AYLLON ACOSTA JAIME', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-07-27', 'UN SEMESTRE', 'II/2006', 12, 'DOC0006');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000008', 'FLORERO  ORTU?O OSCAR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-02', 'UN SEMESTRE', 'II/2006', 6, 'DOC0012');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000006', 'ESCALERA VASQUEZ ARMANDO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-02', 'UN SEMESTRE', 'II/2006', 18, 'DOC0010');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000009', 'LAZARTE  VILLARROEL  LUIS', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-02', 'UN SEMESTRE', 'II/2006', 6, 'DOC0014');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00010', 'LEON  CLAVIJO  GUIDO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-02', 'UN SEMESTRE', 'II/2006', 18, 'DOC0016');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00011', 'MENDEZ VELASQUEZ IVAN', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-02', 'UN SEMESTRE', 'II/2006', 8, 'DOC0017');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00013', 'MERUVIA MERUVIA JOSE', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-02', 'UN SEMESTRE', 'II/2006', 6, 'DOC0019');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00014', 'MU?OZ VASQUEZ GALO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-03', 'UN SEMESTRE', 'II/2006', 18, 'DOC0020');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00015', 'PEREIRA MELGAR MARIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-03', 'UN SEMESTRE', 'II/2006', 6, 'DOC0023');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00016', 'ROCHA CUADROS JUAN CARLOS', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-03', 'UN SEMESTRE', 'II/2006', 6, 'DOC0024');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00012', 'MENDEZ TORRICO ROBERTO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-03', 'UN SEMESTRE', 'II/2006', 6, 'DOC0018');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00019', 'TORRES  NAVARRO JULIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-04', 'UN SEMESTRE', 'II/2006', 6, 'DOC0032');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00021', 'VERA  CORTES CARLOS ALBERTO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-02-20', '2006-08-04', 'UN SEMESTRE', 'II/2006', 6, 'DOC0035');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000004', 'DUCHEN  AYALA MARTIN', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 11, 'DOC0008');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00017', 'ROMERO  MERIDA  MAURICIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 9, 'DOC0028');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00023', 'SACA VENTURA OSCAR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'ING CIVIL', 'ING CIVIL', 'EXCLUSIVO', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 16, 'DOC0038');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00022', 'ZABALAGA MONTA?O OSCAR', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 6, 'DOC0037');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00018', 'SAAVEDRA  ANTEZANA RAMIRO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 17, 'DOC0029');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00020', 'UREY CONTRERAS MARIO F.', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 8, 'DOC0033');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00025', 'LEDEZMA PERIZZA FERNANDO ARTURO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LIC INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-08-08', 'UN SEMESTRE', 'II/2006', 16, 'DOC0039');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00026', 'LEDEZMA MIRANDA VITO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LECENCIATURA EN ING CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-26', '2006-09-18', 'UN SEMESTRE', 'II/2006', 6, 'DOC0040');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_00024', 'ARNEZ TORRICO MARITZA', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-11-13', 'UN SEMESTRE', 'II/2006', 6, 'DOC0005');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('II/2006_000005', 'EDUARDO FRANZ MARCELO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOG?A', 'LICENCIATURA EN INGENIERIA CIVIL', 'ING CIVIL', 'PARCIAL', '2006-08-08', '2006-11-13', 'UN SEMESTRE', 'II/2006', 6, 'DOC0009');


--
-- TOC entry 2516 (class 0 OID 29994)
-- Dependencies: 183
-- Data for Name: hist_segui_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_000004', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2006_000011');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_000005', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'I/2006', '', 'AUX2006_000003');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_000006', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2006_000004');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_000007', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2006', '', 'AUX2006_000005');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_000008', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2006_000006');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_000009', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2006_000007');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00010', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2006', '', 'AUX2006_000008');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00011', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '11', '44', '44', '', '', 'I/2006', '', 'AUX2006_000009');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00012', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2006', '', 'AUX2006_000010');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00013', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2005_000001');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00014', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2006', '', 'AUX2006_000012');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00015', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'I/2006', '', 'AUX2006_000013');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00017', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2006_000015');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('I/2006_00018', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2006', '', 'AUX2006_000016');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_000005', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'II/2006', '', 'AUX2006_000003');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00010', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000008');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00018', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000016');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00019', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000027');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00020', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000026');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00021', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000029');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00022', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000023');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00023', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000028');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00024', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'II/2006', '', 'AUX2006_000024');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00025', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000020');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00026', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000006');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00027', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'II/2006', '', 'AUX2006_000025');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00028', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000021');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00029', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000022');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00030', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000019');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00031', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000017');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00032', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000031');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00033', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'II/2006', '', 'AUX2006_000032');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00034', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000033');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00035', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000034');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00036', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000035');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00037', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000037');
INSERT INTO hist_segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar) VALUES ('II/2006_00038', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000038');


--
-- TOC entry 2517 (class 0 OID 29997)
-- Dependencies: 184
-- Data for Name: hist_segui_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000001', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '3', '12', '12', '', '0', 'II/2005', 'PARCIAL', 'DOC0001');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000002', '', 'N', 'S', 'N', 'N', '', '18', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '28', '112', '160', '', '48', 'II/2005', 'EXCLUSIVO', 'DOC0010');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000003', '', 'N', 'N', 'S', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2005', 'PARCIAL', 'DOC0004');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000004', '', 'N', 'N', 'N', 'N', '', '48', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2005', 'PARCIAL', 'DOC0002');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000005', '', 'N', 'N', 'N', 'N', '', '24', '', '', '', '24', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2005', 'PARCIAL', 'DOC0003');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000006', '', 'N', 'N', 'N', 'N', '', '16', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2005', 'PARCIAL', 'DOC0005');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000007', '', 'N', 'N', 'S', 'N', '', '16', '', '', '', '24', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '0', 'II/2005', 'PARCIAL', 'DOC0007');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2005_000008', '', 'N', 'N', 'S', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '64', '', '0', 'II/2005', 'PARCIAL', 'DOC0006');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000001', '', 'N', 'N', 'N', 'N', '', '3', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '3', '12', '12', '', '0', 'I/2006', 'PARCIAL', 'DOC0001');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000002', '', 'N', 'S', 'N', 'N', '', '16', '', '', '', '12', '', '', '', '', '', '', '', '', '', '', '', '28', '112', '200', '', '88', 'I/2006', 'EXCLUSIVO', 'DOC0010');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000003', '', 'N', 'N', 'S', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2006', 'PARCIAL', 'DOC0004');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000004', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2006', 'PARCIAL', 'DOC0002');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000005', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2006', 'PARCIAL', 'DOC0003');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000006', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2006', 'PARCIAL', 'DOC0005');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000007', '', 'N', 'N', 'S', 'N', '', '4', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '0', 'I/2006', 'PARCIAL', 'DOC0007');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000008', '', 'N', 'N', 'S', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '64', '', '0', 'I/2006', 'PARCIAL', 'DOC0006');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_000009', '', 'N', 'N', 'S', 'N', '', '10', '', '', '', '11', '', '', '', '', '', '', '', '', '', '', '', '21', '84', '200', '', '116', 'I/2006', 'EXCLUSIVO', 'DOC0008');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00010', '', 'N', 'N', 'N', 'N', '', '7', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '11', '44', '44', '', '0', 'I/2006', 'PARCIAL', 'DOC0009');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00011', '', 'N', 'N', 'S', 'N', '', '13', '', '', '', '7', '', '', '', '', '', '', '', '', '', '', '', '14', '56', '56', '', '0', 'I/2006', 'EXCLUSIVO', 'DOC0011');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00012', '', 'N', 'N', 'N', 'N', '', '5', '', '', '', '7', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2006', 'PARCIAL', 'DOC0012');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00013', '', 'N', 'N', 'S', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2006', 'PARCIAL', 'DOC0013');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00014', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '24', '0', 'I/2006', 'PARCIAL', 'DOC0014');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00015', '', 'N', 'S', 'N', 'N', '', '10', '88', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '160', '0', '88', 'I/2006', 'EXCLUSIVO', 'DOC0016');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00016', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '0', 'I/2006', 'PARCIAL', 'DOC0017');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00017', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '48', '0', 'I/2006', 'PARCIAL', 'DOC0018');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00018', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '72', '72', '0', 'I/2006', 'PARCIAL', 'DOC0019');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00019', '', 'N', 'N', 'N', 'N', '', '7', '', '', '', '11', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '160', '', '88', 'I/2006', 'EXCLUSIVO', 'DOC0020');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00020', '', 'N', 'N', 'N', 'N', '', '3', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '5', '20', '20', '20', '0', 'I/2006', 'PARCIAL', 'DOC0021');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00021', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2006', 'PARCIAL', 'DOC0022');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00022', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2006', 'PARCIAL', 'DOC0023');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00023', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '72', '0', 'I/2006', 'PARCIAL', 'DOC0024');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00024', '', 'N', 'N', 'N', 'N', '', '3', '', '', '', '3', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2006', 'PARCIAL', 'DOC0026');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00025', '', 'S', 'N', 'N', 'N', '', '7', '124', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '13', '52', '160', '0', '108', 'I/2006', 'EXCLUSIVO', 'DOC0028');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00026', '', 'N', 'S', 'N', 'N', '', '14', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '24', '96', '160', '', '64', 'I/2006', 'EXCLUSIVO', 'DOC0029');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00027', '', 'N', 'N', 'S', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2006', 'EXCLUSIVO', 'DOC0030');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00028', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '24', '0', 'I/2006', 'PARCIAL', 'DOC0032');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00029', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '0', 'I/2006', 'PARCIAL', 'DOC0033');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00030', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '3', '', '', '', '', '', '', '', '', '', '', '', '7', '28', '28', '28', '0', 'I/2006', 'PARCIAL', 'DOC0034');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00031', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2006', 'PARCIAL', 'DOC0035');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00032', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '72', '', '0', 'I/2006', 'EXCLUSIVO', 'DOC0037');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00033', '', 'N', 'N', 'N', 'N', '', '16', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '160', '', '112', 'I/2006', 'EXCLUSIVO', 'DOC0038');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2006_00034', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2006', 'PARCIAL', 'DOC0027');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000001', '', 'N', 'N', 'N', 'N', '', '3', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '3', '12', '12', '', '0', 'II/2006', 'PARCIAL', 'DOC0001');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000002', '', 'N', 'S', 'N', 'N', '', '14', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '24', '96', '200', '', '104', 'II/2006', 'EXCLUSIVO', 'DOC0010');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000003', '', 'N', 'N', 'S', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2006', 'PARCIAL', 'DOC0004');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000004', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2006', 'PARCIAL', 'DOC0002');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000005', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2006', 'PARCIAL', 'DOC0003');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000006', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2006', 'PARCIAL', 'DOC0005');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000007', '', 'N', 'N', 'S', 'N', '', '4', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '10', '32', '40', '', '0', 'II/2006', 'PARCIAL', 'DOC0007');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000008', '', 'N', 'N', 'S', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '64', '', '0', 'II/2006', 'PARCIAL', 'DOC0006');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_000009', '', 'N', 'N', 'S', 'N', '', '12', '', '', '', '9', '', '', '', '', '', '', '', '', '', '', '', '21', '84', '200', '', '116', 'II/2006', 'EXCLUSIVO', 'DOC0008');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00010', '', 'N', 'N', 'N', 'N', '', '7', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '11', '44', '44', '', '0', 'II/2006', 'PARCIAL', 'DOC0009');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00011', '', 'N', 'N', 'S', 'N', '', '11', '', '', '', '9', '', '', '', '', '', '', '', '', '', '', '', '14', '56', '56', '', '0', 'II/2006', 'EXCLUSIVO', 'DOC0011');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00012', '', 'N', 'N', 'N', 'N', '', '5', '', '', '', '7', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2006', 'PARCIAL', 'DOC0012');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00013', '', 'N', 'N', 'S', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2006', 'PARCIAL', 'DOC0013');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00014', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '24', '0', 'II/2006', 'PARCIAL', 'DOC0014');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00015', '', 'N', 'S', 'N', 'N', '', '10', '88', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '160', '0', '88', 'II/2006', 'EXCLUSIVO', 'DOC0016');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00016', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '0', 'II/2006', 'PARCIAL', 'DOC0017');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00017', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '48', '0', 'II/2006', 'PARCIAL', 'DOC0018');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00018', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '72', '72', '0', 'II/2006', 'PARCIAL', 'DOC0019');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00019', '', 'N', 'N', 'N', 'N', '', '7', '', '', '', '11', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '160', '', '88', 'II/2006', 'EXCLUSIVO', 'DOC0020');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00020', '', 'N', 'N', 'N', 'N', '', '3', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '5', '20', '20', '20', '0', 'II/2006', 'PARCIAL', 'DOC0021');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00021', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2006', 'PARCIAL', 'DOC0022');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00022', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2006', 'PARCIAL', 'DOC0023');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00023', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '72', '0', 'II/2006', 'PARCIAL', 'DOC0024');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00024', '', 'N', 'N', 'N', 'N', '', '3', '', '', '', '3', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'II/2006', 'PARCIAL', 'DOC0026');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00025', '', 'S', 'N', 'N', 'N', '', '5', '124', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '9', '36', '160', '0', '124', 'II/2006', 'EXCLUSIVO', 'DOC0028');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00026', '', 'N', 'S', 'N', 'N', '', '15', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '23', '92', '160', '', '68', 'II/2006', 'EXCLUSIVO', 'DOC0029');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00027', '', 'N', 'N', 'S', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2006', 'EXCLUSIVO', 'DOC0030');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00028', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '24', '0', 'II/2006', 'PARCIAL', 'DOC0032');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00029', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '0', 'II/2006', 'PARCIAL', 'DOC0033');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00030', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '5', '', '', '', '', '', '', '', '', '', '', '', '13', '52', '28', '28', '0', 'II/2006', 'PARCIAL', 'DOC0034');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00031', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'II/2006', 'PARCIAL', 'DOC0035');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00032', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '24', '', '0', 'II/2006', 'EXCLUSIVO', 'DOC0037');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00033', '', 'N', 'S', 'N', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '160', '', '96', 'II/2006', 'EXCLUSIVO', 'DOC0038');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00034', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'II/2006', 'PARCIAL', 'DOC0027');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00035', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '160', '', '96', 'II/2006', 'EXCLUSIVO', 'DOC0039');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('II/2006_00036', '', 'N', 'N', 'N', 'N', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '16', '', '0', 'II/2006', 'PARCIAL', 'DOC0040');


--
-- TOC entry 2518 (class 0 OID 30000)
-- Dependencies: 185
-- Data for Name: historico; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2006-02-06', 'II/2005', 'I/2006');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2006-06-29', 'I/2006', 'II/2006');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2007-03-13', 'II/2006', 'I/2007');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2007-08-23', 'I/2007', 'II/2007');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2011-07-08', 'II/2007', 'II/2011');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2011-12-08', 'II/2011', 'I/2012');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2012-12-14', 'I/2012', 'I/2013');


--
-- TOC entry 2519 (class 0 OID 30003)
-- Dependencies: 186
-- Data for Name: horario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2520 (class 0 OID 30006)
-- Dependencies: 187
-- Data for Name: horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('241', 'Martes', '', 'campo', 0, '08:00:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '14');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('242', 'Martes', '', 'campo', 0, '08:00:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '14');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('243', 'Lunes', '', '', 0, '07:30:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '30');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('244', 'Martes', '', '', 0, '10:30:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '30');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('245', 'Miercoles', '', '', 0, '10:30:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '30');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('246', 'Viernes', '', '', 0, '13:30:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '30');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('247', 'Lunes', '1', 'LAB-H', 0, '08:15:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '31');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('248', 'Martes', '1', 'LAB-H', 0, '08:15:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '31');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('249', 'Miercoles', '1', 'LAB-H', 0, '08:15:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '31');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('250', 'Jueves', '', '', 0, '07:30:00', '12:30:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '32');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('251', 'Viernes', '', '', 0, '07:30:00', '12:30:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '32');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('252', 'Lunes', '1', 'Lab-R', 0, '15:45:00', '17:15:00', 'II/2006', 'INACTIVO', 'LAB0003', 'LAB0003', '', '33');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('253', 'Miercoles', '1', 'Lab-R', 0, '08:15:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0003', 'LAB0003', '', '33');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('254', 'Jueves', '1', 'Lab-R', 0, '14:15:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0003', 'LAB0003', '', '33');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('262', 'Lunes', '1', 'L GEO', 0, '07:30:00', '12:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '36');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('263', 'Viernes', '1', 'L GEO', 0, '07:30:00', '12:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '36');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('264', 'Miercoles', '1', 'L-GEO', 0, '07:30:00', '15:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '37');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('265', 'Jueves', '1', 'L-GEO', 0, '07:30:00', '15:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '37');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('266', 'Viernes', '1', 'L-GEO', 0, '07:30:00', '11:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '37');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('270', 'Lunes', '1', 'CASA', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0004', 'LAB0004', '', '39');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('271', 'Martes', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0004', 'LAB0004', '', '39');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('272', 'Miercoles', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0004', 'LAB0004', '', '39');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('273', 'Lunes', '1', 'CASA', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0004', 'LAB0004', '', '40');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('274', 'Martes', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0004', 'LAB0004', '', '40');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('275', 'Miercoles', '1', 'CASA', 0, '09:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0004', 'LAB0004', '', '40');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('276', 'Lunes', '1', 'L-GEO', 0, '07:30:00', '15:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '41');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('277', 'Martes', '1', 'L-GEO', 0, '07:30:00', '15:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '41');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('278', 'Jueves', '1', 'L-GEO', 0, '07:30:00', '11:30:00', 'II/2006', 'INACTIVO', 'LAB0002', 'LAB0002', '', '41');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('279', 'Martes', '', '', 0, '08:15:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '42');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('260', 'Viernes', '', '', 0, '08:15:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '35');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('261', 'Viernes', '', '', 0, '14:15:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '35');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('280', 'Viernes', '', 'campo', 0, '08:15:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '35');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('281', 'Viernes', '', 'campo', 0, '14:15:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '35');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('284', 'Viernes', '1', 'Hi-II', 0, '17:15:00', '18:45:00', 'II/2006', 'INACTIVO', '2012011', '', '2012011', '44');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('285', 'Viernes', '1', 'hi-II', 0, '17:15:00', '18:45:00', 'II/2006', 'INACTIVO', '2012011', '', '2012011', '45');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('286', 'Miercoles', '1', 'lab', 0, '07:30:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '46');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('287', 'Jueves', '1', 'lab', 0, '07:30:00', '15:45:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '46');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('288', 'Viernes', '1', 'lab', 0, '07:30:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0001', 'LAB0001', '', '46');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('282', 'Viernes', '1', 'campo', 0, '08:15:00', '12:00:00', 'II/2006', 'INACTIVO', '2012006', '', '2012006', '43');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('283', 'Viernes', '1', 'campo', 0, '14:15:00', '18:00:00', 'II/2006', 'INACTIVO', '2012006', '', '2012006', '43');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('289', 'Martes', '1', 'campo', 0, '08:00:00', '18:00:00', 'II/2006', 'INACTIVO', 'LAB0005', 'LAB0005', '', '47');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('293', 'Martes', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0007', 'LAB0007', '', '49');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('294', 'Miercoles', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0007', 'LAB0007', '', '49');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('295', 'Jueves', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0007', 'LAB0007', '', '49');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('296', 'Lunes', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0007', 'LAB0007', '', '50');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('297', 'Jueves', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0007', 'LAB0007', '', '50');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('298', 'Viernes', '1', 'depar', 0, '08:00:00', '12:00:00', 'II/2006', 'INACTIVO', 'LAB0007', 'LAB0007', '', '50');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('299', 'Martes', '1', '625-D', 0, '08:15:00', '09:45:00', 'II/2006', 'INACTIVO', '2012008', '', '2012008', '38');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('300', 'Lunes', '1', '', 0, '14:00:00', '18:00:00', 'I/2007', 'INACTIVO', '2012009', '', '2012009', '51');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('301', 'Martes', '1', '', 0, '14:00:00', '18:00:00', 'I/2007', 'INACTIVO', '2012009', '', '2012009', '51');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('302', 'Miercoles', '1', '', 0, '14:00:00', '18:00:00', 'I/2007', 'INACTIVO', '2012009', '', '2012009', '51');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('303', 'Jueves', '1', '', 0, '14:00:00', '18:00:00', 'I/2007', 'INACTIVO', '2012009', '', '2012009', '51');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('304', 'Viernes', '1', '', 0, '14:00:00', '18:00:00', 'I/2007', 'INACTIVO', '2012009', '', '2012009', '51');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('259', 'Viernes', '', '', 0, '14:15:00', '18:00:00', 'I/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '34');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('258', 'Jueves', '', '', 0, '14:15:00', '18:00:00', 'I/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '34');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('257', 'Miercoles', '', '', 0, '14:15:00', '18:00:00', 'I/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '34');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('256', 'Martes', '', '', 0, '14:15:00', '18:00:00', 'I/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '34');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('255', 'Lunes', '', '', 0, '14:15:00', '18:00:00', 'I/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '34');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('290', 'Martes', '', '', 0, '08:00:00', '12:00:00', 'II/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '48');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('291', 'Miercoles', '', '', 0, '08:00:00', '12:00:00', 'II/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '48');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('292', 'Jueves', '', '', 0, '08:00:00', '12:00:00', 'II/2007', 'ACTIVO', 'LAB0007', 'LAB0007', '', '48');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('305', 'Miercoles', '2', '', 0, '08:00:00', '12:00:00', 'II/2007', 'ACTIVO', 'LAB0003', 'LAB0003', '', '52');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('306', 'Miercoles', '2', '', 0, '14:00:00', '18:00:00', 'II/2007', 'ACTIVO', 'LAB0003', 'LAB0003', '', '52');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('307', 'Viernes', '2', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', '2012006', '', '2012006', '54');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('308', 'Viernes', '2', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', '2012006', '', '2012006', '54');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('309', 'Lunes', '1', '', 0, '08:00:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '55');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('310', 'Martes', '1', '', 0, '08:00:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '55');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('311', 'Miercoles', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '55');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('317', 'Miercoles', '1', '', 0, '10:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '57');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('318', 'Jueves', '1', '', 0, '07:30:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '57');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('319', 'Lunes', '', '', 0, '10:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '58');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('320', 'Martes', '', '', 0, '10:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '58');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('321', 'Miercoles', '', '', 0, '10:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '58');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('322', 'Jueves', '', '', 0, '10:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '58');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('323', 'Viernes', '', '', 0, '10:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '58');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('327', 'Lunes', '', '', 0, '14:30:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('324', 'Lunes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '59');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('325', 'Viernes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '59');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('326', 'Miercoles', '', '', 0, '16:00:00', '18:00:00', 'I/2013', 'INACTIVO', 'LAB0007', 'LAB0007', '', '59');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('330', 'Jueves', '1', '', 0, '16:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0007', 'LAB0007', '', '59');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('331', 'Viernes', '1', '692', 0, '18:45:00', '20:15:00', 'I/2013', 'ACTIVO', '2012008', '', '2012008', '61');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('332', 'Viernes', '1', '692', 0, '17:15:00', '18:45:00', 'I/2013', 'ACTIVO', '2012008', '', '2012008', '61');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('358', 'Viernes', '1', '', 0, '08:00:00', '13:00:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '66');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('359', 'Lunes', '1', '', 0, '08:00:00', '15:00:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '66');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('360', 'Jueves', '1', '', 0, '08:00:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '66');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('361', 'Lunes', '1', '', 0, '07:30:00', '11:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '67');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('333', 'Lunes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('334', 'Lunes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('335', 'Martes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('336', 'Martes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('337', 'Miercoles', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('338', 'Miercoles', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('339', 'Jueves', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('340', 'Jueves', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('341', 'Viernes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('342', 'Viernes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '63');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('343', 'Miercoles', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('344', 'Jueves', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('345', 'Jueves', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('346', 'Viernes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('347', 'Viernes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('348', 'Miercoles', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('349', 'Jueves', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('350', 'Jueves', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('351', 'Viernes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('352', 'Viernes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '64');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('362', 'Martes', '1', '', 0, '07:30:00', '11:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '67');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('363', 'Miercoles', '1', '', 0, '07:30:00', '11:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '67');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('364', 'Jueves', '1', '', 0, '07:30:00', '11:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '67');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('365', 'Viernes', '1', '', 0, '07:30:00', '11:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '67');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('366', 'Lunes', '1', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0003', 'LAB0003', '', '68');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('367', 'Miercoles', '1', '', 0, '14:00:00', '16:00:00', 'I/2013', 'ACTIVO', 'LAB0003', 'LAB0003', '', '68');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('368', 'Viernes', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0003', 'LAB0003', '', '68');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('369', 'Miercoles', '1', '', 0, '15:45:00', '17:15:00', 'I/2013', 'ACTIVO', '2012013', '', '2012013', '69');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('370', 'Miercoles', '1', '', 0, '17:15:00', '18:45:00', 'I/2013', 'ACTIVO', '2012013', '', '2012013', '69');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('371', 'Lunes', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', '2012006', '', '2012006', '70');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('372', 'Lunes', '1', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', '2012006', '', '2012006', '70');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('357', 'Miercoles', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '65');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('355', 'Martes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '65');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('356', 'Martes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '65');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('353', 'Lunes', '', '', 0, '08:00:00', '12:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '65');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('354', 'Lunes', '', '', 0, '14:00:00', '18:00:00', 'I/2013', 'INACTIVO', 'LAB0008', 'LAB0008', '', '65');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('373', 'Lunes', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '71');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('374', 'Lunes', '1', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '71');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('375', 'Martes', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '71');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('376', 'Martes', '1', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '71');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('377', 'Miercoles', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '71');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('382', 'Martes', '1', '', 0, '07:30:00', '12:30:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '74');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('383', 'Jueves', '1', '', 0, '07:30:00', '12:30:00', 'I/2013', 'ACTIVO', 'LAB0002', 'LAB0002', '', '74');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('384', 'Martes', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '75');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('385', 'Miercoles', '1', '', 0, '08:00:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '75');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('386', 'Martes', '1', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '75');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('378', 'Lunes', '1', '', 0, '08:30:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '72');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('379', 'Lunes', '1', '', 0, '14:00:00', '18:00:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '72');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('380', 'Martes', '1', '', 0, '08:30:00', '12:00:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '72');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('312', 'Lunes', '', '', 0, '11:30:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('313', 'Martes', '', '', 0, '11:30:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('314', 'Miercoles', '', '', 0, '11:30:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('315', 'Jueves', '', '', 0, '11:30:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('316', 'Viernes', '', '', 0, '11:30:00', '15:30:00', 'I/2013', 'ACTIVO', 'LAB0001', 'LAB0001', '', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('381', 'Lunes', '1', '', 0, '08:15:00', '11:15:00', 'I/2013', 'ACTIVO', 'LAB0008', 'LAB0008', '', '73');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('328', 'Miercoles', '', '', 0, '08:30:00', '11:00:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('387', 'Lunes', '1', '', 0, '14:00:00', '14:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('388', 'Miercoles', '1', '', 0, '08:00:00', '08:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('389', 'Jueves', '1', '', 0, '08:00:00', '08:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('390', 'Lunes', '1', '', 0, '14:00:00', '14:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('391', 'Miercoles', '1', '', 0, '08:00:00', '08:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('392', 'Jueves', '1', '', 0, '08:00:00', '08:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('329', 'Jueves', '', '', 0, '08:30:00', '11:00:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('393', 'Lunes', '1', '', 0, '14:00:00', '14:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('394', 'Miercoles', '1', '', 0, '08:00:00', '08:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('395', 'Jueves', '1', '', 0, '08:00:00', '08:30:00', 'I/2013', 'ACTIVO', 'LAB0004', 'LAB0004', '', '60');


--
-- TOC entry 2521 (class 0 OID 30009)
-- Dependencies: 188
-- Data for Name: horario_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('2', 'Sabado', '1', '692F', 0, '08:15:00', '10:30:00', 'I/2013', 'ACTIVO', '2012007', '3');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('3', 'Sabado', '1', '692F', 0, '10:30:00', '12:45:00', 'I/2013', 'ACTIVO', '2012007', '3');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('4', 'Martes', '3', '623', 0, '20:15:00', '21:45:00', 'I/2013', 'ACTIVO', '2012017', '4');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('5', 'Jueves', '3', '692B', 0, '17:15:00', '18:45:00', 'I/2013', 'ACTIVO', '2012017', '4');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('6', 'Viernes', '3', '691F', 0, '17:15:00', '18:45:00', 'I/2013', 'ACTIVO', '2012017', '4');


--
-- TOC entry 2522 (class 0 OID 30012)
-- Dependencies: 189
-- Data for Name: horario_rangos_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '18:00:00', '2', '16', 'INACTIVO', 'II/2006', '242');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '18:00:00', '2', '16', 'INACTIVO', 'II/2006', '241');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('13:30:00', '15:45:00', '10', '13', 'INACTIVO', 'II/2006', '246');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:30:00', '15:45:00', '6', '13', 'INACTIVO', 'II/2006', '245');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:30:00', '15:45:00', '6', '13', 'INACTIVO', 'II/2006', '244');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:45:00', '2', '13', 'INACTIVO', 'II/2006', '243');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '15:45:00', '3', '13', 'INACTIVO', 'II/2006', '249');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '15:45:00', '3', '13', 'INACTIVO', 'II/2006', '248');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '15:45:00', '3', '13', 'INACTIVO', 'II/2006', '247');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:30:00', '2', '8', 'INACTIVO', 'II/2006', '251');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:30:00', '2', '8', 'INACTIVO', 'II/2006', '250');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'INACTIVO', 'II/2006', '254');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '12:00:00', '3', '8', 'INACTIVO', 'II/2006', '253');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'II/2006', '252');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:30:00', '2', '8', 'INACTIVO', 'II/2006', '263');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:30:00', '2', '8', 'INACTIVO', 'II/2006', '262');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'INACTIVO', 'II/2006', '266');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:30:00', '2', '12', 'INACTIVO', 'II/2006', '265');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:30:00', '2', '12', 'INACTIVO', 'II/2006', '264');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:00:00', '12:00:00', '4', '8', 'INACTIVO', 'II/2006', '272');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:00:00', '12:00:00', '4', '8', 'INACTIVO', 'II/2006', '271');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '270');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:00:00', '12:00:00', '4', '8', 'INACTIVO', 'II/2006', '275');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:00:00', '12:00:00', '4', '8', 'INACTIVO', 'II/2006', '274');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '273');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'INACTIVO', 'II/2006', '278');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:30:00', '2', '12', 'INACTIVO', 'II/2006', '277');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:30:00', '2', '12', 'INACTIVO', 'II/2006', '276');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '18:00:00', '3', '16', 'INACTIVO', 'II/2006', '279');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'INACTIVO', 'II/2006', '261');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '12:00:00', '3', '8', 'INACTIVO', 'II/2006', '260');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'INACTIVO', 'II/2006', '281');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '12:00:00', '3', '8', 'INACTIVO', 'II/2006', '280');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'INACTIVO', 'II/2006', '261');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '12:00:00', '3', '8', 'INACTIVO', 'II/2006', '260');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'II/2006', '284');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'II/2006', '285');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '288');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:45:00', '2', '13', 'INACTIVO', 'II/2006', '287');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:45:00', '2', '13', 'INACTIVO', 'II/2006', '286');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '12:00:00', '3', '8', 'INACTIVO', 'II/2006', '282');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'INACTIVO', 'II/2006', '283');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '18:00:00', '2', '16', 'INACTIVO', 'II/2006', '289');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '293');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '294');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '295');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '296');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '297');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'INACTIVO', 'II/2006', '298');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'II/2006', '299');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'ACTIVO', 'I/2007', '255');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'ACTIVO', 'I/2007', '256');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'ACTIVO', 'I/2007', '257');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'ACTIVO', 'I/2007', '258');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '18:00:00', '11', '16', 'ACTIVO', 'I/2007', '259');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'II/2007', '290');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'II/2007', '291');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'II/2007', '292');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'II/2007', '306');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'II/2007', '305');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '307');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '308');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '15:30:00', '2', '12', 'ACTIVO', 'I/2013', '309');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '15:30:00', '2', '12', 'ACTIVO', 'I/2013', '310');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '311');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:00:00', '12:00:00', '5', '8', 'ACTIVO', 'I/2013', '317');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '15:30:00', '2', '12', 'ACTIVO', 'I/2013', '318');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:00:00', '12:00:00', '5', '8', 'ACTIVO', 'I/2013', '319');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:00:00', '12:00:00', '5', '8', 'ACTIVO', 'I/2013', '320');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:00:00', '12:00:00', '5', '8', 'ACTIVO', 'I/2013', '321');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:00:00', '12:00:00', '5', '8', 'ACTIVO', 'I/2013', '322');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('10:00:00', '12:00:00', '5', '8', 'ACTIVO', 'I/2013', '323');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '324');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '325');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('16:00:00', '18:00:00', '13', '16', 'ACTIVO', 'I/2013', '330');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('18:45:00', '20:15:00', '17', '19', 'ACTIVO', 'I/2013', '331');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'ACTIVO', 'I/2013', '332');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '333');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '334');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '335');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '336');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '337');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '333');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '334');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '335');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '336');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '337');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '343');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '344');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '345');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '346');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '347');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '333');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '334');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '335');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '336');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '337');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '343');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '344');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '345');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '346');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '347');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '348');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '349');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '350');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '351');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '352');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '13:00:00', '2', '9', 'ACTIVO', 'I/2013', '358');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '15:00:00', '2', '12', 'ACTIVO', 'I/2013', '359');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '15:30:00', '2', '13', 'ACTIVO', 'I/2013', '360');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'ACTIVO', 'I/2013', '361');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'ACTIVO', 'I/2013', '362');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'ACTIVO', 'I/2013', '363');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'ACTIVO', 'I/2013', '364');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '11:30:00', '2', '7', 'ACTIVO', 'I/2013', '365');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '366');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '16:00:00', '10', '13', 'ACTIVO', 'I/2013', '367');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '368');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'ACTIVO', 'I/2013', '369');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'ACTIVO', 'I/2013', '370');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '371');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '372');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '373');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '374');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '375');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '376');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '377');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:30:00', '12:00:00', '3', '8', 'ACTIVO', 'I/2013', '378');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '379');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:30:00', '12:00:00', '3', '8', 'ACTIVO', 'I/2013', '380');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:30:00', '15:30:00', '8', '12', 'ACTIVO', 'I/2013', '312');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:30:00', '15:30:00', '8', '12', 'ACTIVO', 'I/2013', '313');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:30:00', '15:30:00', '8', '12', 'ACTIVO', 'I/2013', '314');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:30:00', '15:30:00', '8', '12', 'ACTIVO', 'I/2013', '315');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:30:00', '15:30:00', '8', '12', 'ACTIVO', 'I/2013', '316');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '11:15:00', '3', '7', 'ACTIVO', 'I/2013', '381');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:30:00', '2', '8', 'ACTIVO', 'I/2013', '382');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('07:30:00', '12:30:00', '2', '8', 'ACTIVO', 'I/2013', '383');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '384');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '12:00:00', '2', '8', 'ACTIVO', 'I/2013', '385');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '18:00:00', '10', '16', 'ACTIVO', 'I/2013', '386');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '14:30:00', '10', '11', 'ACTIVO', 'I/2013', '387');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '388');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '389');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '14:30:00', '10', '11', 'ACTIVO', 'I/2013', '387');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '388');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '389');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '14:30:00', '10', '11', 'ACTIVO', 'I/2013', '390');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '391');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '392');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:30:00', '18:00:00', '11', '16', 'ACTIVO', 'I/2013', '327');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:30:00', '11:00:00', '3', '6', 'ACTIVO', 'I/2013', '328');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '14:30:00', '10', '11', 'ACTIVO', 'I/2013', '387');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '388');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '389');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '14:30:00', '10', '11', 'ACTIVO', 'I/2013', '390');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '391');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '392');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:30:00', '11:00:00', '3', '6', 'ACTIVO', 'I/2013', '329');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:00:00', '14:30:00', '10', '11', 'ACTIVO', 'I/2013', '393');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '394');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '08:30:00', '2', '3', 'ACTIVO', 'I/2013', '395');


--
-- TOC entry 2523 (class 0 OID 30016)
-- Dependencies: 190
-- Data for Name: horario_rangos_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('10:30:00', '12:45:00', '6', '9', 'ACTIVO', 'I/2013', '3');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '10:30:00', '3', '6', 'ACTIVO', 'I/2013', '2');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'ACTIVO', 'I/2013', '6');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'ACTIVO', 'I/2013', '5');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('20:15:00', '21:45:00', '19', '20', 'ACTIVO', 'I/2013', '4');


--
-- TOC entry 2524 (class 0 OID 30020)
-- Dependencies: 191
-- Data for Name: horas_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('1', '06:45:00', '07:30:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('2', '07:30:00', '08:15:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('3', '08:15:00', '09:00:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('4', '09:00:00', '09:45:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('5', '09:45:00', '10:30:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('6', '10:30:00', '11:15:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('7', '11:15:00', '12:00:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('8', '12:00:00', '12:45:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('9', '12:45:00', '13:30:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('10', '13:30:00', '14:15:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('11', '14:15:00', '15:00:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('12', '15:00:00', '15:45:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('13', '15:45:00', '16:30:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('14', '16:30:00', '17:15:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('15', '17:15:00', '18:00:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('16', '18:00:00', '18:45:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('17', '18:45:00', '19:30:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('18', '19:30:00', '20:15:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('19', '20:15:00', '21:00:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('20', '21:00:00', '21:45:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('21', '21:45:00', '22:00:00', 'AUX', 'ACTIVO');
INSERT INTO horas_aux (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('22', '22:00:00', '22:30:00', 'AUX', 'ACTIVO');


--
-- TOC entry 2525 (class 0 OID 30024)
-- Dependencies: 192
-- Data for Name: horas_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('1', '06:45:00', '07:00:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('2', '07:30:00', '08:15:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('3', '08:15:00', '09:00:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('4', '09:00:00', '09:45:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('5', '09:45:00', '10:30:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('6', '10:30:00', '11:15:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('7', '11:15:00', '12:00:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('8', '12:00:00', '12:45:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('9', '12:45:00', '13:30:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('10', '13:30:00', '14:15:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('11', '14:15:00', '15:00:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('12', '15:00:00', '15:45:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('13', '15:45:00', '16:30:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('14', '16:30:00', '17:15:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('15', '17:15:00', '18:00:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('16', '18:00:00', '18:45:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('17', '18:45:00', '19:30:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('18', '19:30:00', '20:15:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('19', '20:15:00', '21:00:00', 'DOC', 'ACTIVO');
INSERT INTO horas_doc (codigo, rango_ini, rango_fin, tipo, estado) VALUES ('20', '21:00:00', '21:45:00', 'DOC', 'ACTIVO');


--
-- TOC entry 2526 (class 0 OID 30028)
-- Dependencies: 193
-- Data for Name: inscritos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2527 (class 0 OID 30031)
-- Dependencies: 194
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2528 (class 0 OID 30034)
-- Dependencies: 195
-- Data for Name: laboratorio; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0002', 'LAB GEOTECNIA', 'GTUMSS', 'ACTIVO', '2005-08-19');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0001', 'LAB  HIDRAULICA', 'LHUMSS', 'ACTIVO', '2005-08-19');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0003', 'LAB RESIST  MAT', 'LRUMSS', 'ACTIVO', '2005-08-19');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0005', 'MET GEODESICOS', 'CIV214', 'ACTIVO', '2006-02-09');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0007', 'SERVICIOS GENERALES', 'SER GRAL', 'ACTIVO', '2006-08-23');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0004', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'ACTIVO', '2005-08-19');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0008', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'ACTIVO', '2013-03-07');
INSERT INTO laboratorio (codigo, descrip, sigla, estado, fecha_estado) VALUES ('LAB0006', 'LABORATORIO DE GEOTECNIA', 'LGEOUMSS', 'ACTIVO', '2006-02-09');


--
-- TOC entry 2529 (class 0 OID 30039)
-- Dependencies: 196
-- Data for Name: materia; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000001', 'QUIMICA GENERAL', '2004046', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000002', 'FISICA I', '2006004', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000003', 'ALGEBRA I', '2008053', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000004', 'CALCULO I', '2008054', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000005', 'GEOM. ANALITICA, PLANA Y DEL ESPACIO', '2008238', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000006', 'FISICA II', '2006005', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000007', 'GEOMETRIA DESCRIPTIVA', '2008013', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000008', 'ALGEBRA II', '2008022', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000009', 'CALCULO II', '2008056', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000010', 'DIBUJO TECNICO', '2012001', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000011', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000012', 'CALCULO III', '2008066', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000013', 'COMPUTACION PARA INGENIERIA', '2012002', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000014', 'GEOLOGIA GENERAL', '2012003', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000015', 'ELECTROTECNIA', '2014001', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000016', 'ESTRUCTURAS ISOSTATICAS', '2012004', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000017', 'MATERIALES DE CONSTRUCCION', '2012005', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000018', 'METODOS GEODESICOS', '2012006', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000019', 'ECONOMIA POLITICA', '2012007', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000020', 'ANALISIS NUMERICO', '2012060', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000021', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000022', 'HIDRAULICA I', '2012008', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000023', 'GEODESIA Y FOTOGRAMETRIA', '2012009', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000024', 'GEOG. Y DEF. DE LOS RECURSOS NATURALES', '2012010', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000025', 'RESISTENCIA DE MATERIALES', '2018002', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000026', 'HIDRAULICA II', '2012011', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000028', 'RESISTENCIA DE MATERIALES II', '2012013', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000029', 'MECANICA DE SUELOS I', '2012014', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000030', 'TRANSPORTES Y COMUNICACIONES', '2012015', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000031', 'INGENIERIA SANITARIA I', '2012016', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000032', 'ESTRUCTURAS HIPERESTATICAS', '2012017', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000033', 'ESTRUCTURAS DE MADERA', '2012018', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000034', 'TECNOLOGIA DEL HORMIGON', '2012019', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000035', 'SISTEMAS DE INGENIERIA', '2012020', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000036', 'MECANICA DE SUELOS II', '2012021', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000037', 'INGENIERIA SANITARIA II', '2012022', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000038', 'HORMIGON ARMADO', '2012023', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000039', 'MAQUINARIA Y EQUIPO DE CONSTRUCCION', '2012024', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000040', 'MECANICA DE SUELOS APLICADA', '2012025', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000041', 'CARRETERAS I', '2012026', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000042', 'INGENIERIA ECONOMICA', '2012027', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000043', 'PLANIFICACION DE PROYECTO DE GRADO', '2012028', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000044', 'OBRAS HIDRAULICAS I', '2012029', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000045', 'ESTRUCTURAS METALICAS', '2012030', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000046', 'CONSTRUCCION DE EDIFICIOS', '2012031', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000047', 'DIRECCION DE OBRAS Y VALUACIONES', '2012032', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000048', 'FUNDACIONES I', '2012033', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000049', 'SANEAMIENTO AMBIENTAL (SANITARIA)', '2012034', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000050', 'PROYECTO DE GRADO', '2012057', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000051', 'PUENTES', '2012035', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000052', 'HORMIGON PREESFORZADO', '2012036', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000053', 'INGENIERIA ANTISISMICA', '2012037', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000054', 'ESTRUCTURAS ESPECIALES', '2012038', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000055', 'FUNDACIONES II', '2012039', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000056', 'CARRETERAS II', '2012042', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000057', 'AEROPUERTOS', '2012043', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000058', 'INGENIERIA DE TRAFICO', '2012044', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000059', 'VIAS FERREAS', '2012045', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000060', 'MODELOS HIDRAULICOS', '2012047', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000061', 'TEMAS ESPECIALES', '2012048', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000062', 'PUERTOS Y VIAS NAVEGABLES', '2012050', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000063', 'HIDRAULICA DE RIOS', '2012051', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000064', 'PLANTAS DE TRATAMIENTO AGUAS', '2012053', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000065', 'INSTALACIONES DOMICILIARIAS E INDUSTRIALES', '2012054', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000066', 'OBRAS HIDRAULICAS II', '2012055', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000067', 'QUIMICA DEL AGUA', '2012061', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2005_000027', 'HIDROLOGIA', '2012012', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');


--
-- TOC entry 2530 (class 0 OID 30043)
-- Dependencies: 197
-- Data for Name: materia_dicta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('3', 'B)', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIVIL', 6, 16, 8, 'INVITADO', 'ACTIVO', 'I/2013', 0, 12, '000002', NULL, 'MAT2005_000019', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('2', 'A)', 'ECONOMIA POLITICA', '2012007', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 0, 0, 0, 'INVITADO', 'ACTIVO', 'I/2013', 0, 0, '000002', NULL, 'MAT2005_000019', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('4', 'A)', 'ESTRUCTURAS HIPERESTATICAS', '2012017', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 6, 16, 8, 'INVITADO', 'ACTIVO', 'I/2013', 0, 24, '000003', NULL, 'MAT2005_000032', '3');


--
-- TOC entry 2531 (class 0 OID 30046)
-- Dependencies: 198
-- Data for Name: materia_labo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('25', 'A)', 'GAB GEODESIA', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0006', 'LAB', '00018', '00013', NULL, 'LAB0006', '');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('27', 'B)', 'MET GEODISICOS', '', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0005', 'LAB', '00018', '00013', NULL, 'LAB0005', '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('30', 'A)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'II/2006', 'LAB0001', 'LAB', '00019', '00015', NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('32', 'A)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0001', 'LAB', '00021', '00017', NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('31', 'A)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'II/2006', 'LAB0001', 'LAB', '00020', '00018', NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('36', 'A)', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0002', 'LAB', '00025', '00019', NULL, 'LAB0002', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('33', 'A)', 'LAB RESIST  MAT', 'LRUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0003', 'LAB', '00022', '00021', NULL, 'LAB0003', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('37', 'A)', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'II/2006', 'LAB0002', 'LAB', '00026', '00022', NULL, 'LAB0002', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('41', 'A)', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'II/2006', 'LAB0002', 'LAB', '00030', '00023', NULL, 'LAB0002', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('39', 'A)', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0004', 'LAB', '00028', '00025', NULL, 'LAB0004', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('40', 'A)', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0004', 'LAB', '00029', '00026', NULL, 'LAB0004', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('44', 'letra', 'HIDRAULICA II', '2012011', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'INACTIVO', 'II/2006', '2012011', 'MAT', '000005', '00014', 'MAT2005_000026', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('45', 'A)', 'HIDRAULICA II', '2012011', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'INACTIVO', 'II/2006', '2012011', 'MAT', '00033', '00027', 'MAT2005_000026', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('46', 'A)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'II/2006', 'LAB0001', 'LAB', '00034', '00028', NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('43', 'A)', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', '2012006', 'MAT', '00032', NULL, 'MAT2005_000018', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('42', 'A)', 'MET GEODESICOS', 'CIV214', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 0, 0, 0, 'INACTIVO', 'II/2006', 'LAB0005', 'LAB', '00031', '00029', NULL, 'LAB0005', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('47', 'A)', 'MET GEODESICOS', 'CIV214', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0005', 'LAB', '00035', '00030', NULL, 'LAB0005', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('49', 'A)', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0007', 'LAB', '00037', NULL, NULL, 'LAB0007', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('50', 'A)', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'INACTIVO', 'II/2006', 'LAB0007', 'LAB', '00038', '00032', NULL, 'LAB0007', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('38', 'A)', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 2, 0, 2, 'INACTIVO', 'II/2006', '2012008', 'MAT', '00027', '00024', 'MAT2005_000022', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('51', 'A)', 'GEODESIA Y FOTOGRAMETRIA', '2012009', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'I/2007', '2012009', 'MAT', '00039', NULL, 'MAT2005_000023', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('34', 'A)', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'ACTIVO', 'I/2007', 'LAB0007', 'LAB', '00023', '00016', NULL, 'LAB0007', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('48', 'A)', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'II/2007', 'LAB0007', 'LAB', '00036', '00031', NULL, 'LAB0007', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('52', 'A)', 'LAB RESIST  MAT', 'LRUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 8, 0, 8, 'ACTIVO', 'II/2007', 'LAB0003', 'LAB', '00040', '00033', NULL, 'LAB0003', '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('53', 'A)', 'METODOS GEODESICOS', '2012006', '', '', '', 0, 0, 0, 'INACTIVO', 'I/2013', '2012006', 'MAT', '00041', '00034', 'MAT2005_000018', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('54', 'B)', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', '2012006', 'MAT', '00041', '00034', 'MAT2005_000018', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('55', 'A)', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 16, 0, 16, 'ACTIVO', 'I/2013', 'LAB0002', 'LAB', '00042', '00035', NULL, 'LAB0002', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('71', 'A)', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 20, 0, 20, 'ACTIVO', 'I/2013', 'LAB0008', 'LAB', '00056', NULL, NULL, 'LAB0008', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('57', 'A)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', 'LAB0001', 'LAB', '00044', '00037', NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('61', 'A)', 'HIDRAULICA I', '2012008', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 4, 0, 4, 'ACTIVO', 'I/2013', '2012008', 'MAT', '00048', '00041', 'MAT2005_000022', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('58', 'A)', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', 'LAB0007', 'LAB', '00045', '00038', NULL, 'LAB0007', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('62', 'B)', 'HIDRAULICA II', '2012011', '', '', '', 0, 0, 0, 'ACTIVO', 'I/2013', '2012011', 'MAT', '00048', '00041', 'MAT2005_000026', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('59', 'A)', 'SERVICIOS GENERALES', 'SER GRAL', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', 'LAB0007', 'LAB', '00046', '00040', NULL, 'LAB0007', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('56', 'B)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 20, 0, 20, 'ACTIVO', 'I/2013', 'LAB0001', 'LAB', '00043', '00036', NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('67', 'A)', 'LAB  HIDRAULICA', 'LHUMSS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 20, 0, 20, 'ACTIVO', 'I/2013', 'LAB0001', 'LAB', '00052', NULL, NULL, 'LAB0001', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('68', 'A)', 'LAB RESIST  MAT', 'LRUMSS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', 'LAB0003', 'LAB', '00053', NULL, NULL, 'LAB0003', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('63', 'A)', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'INACTIVO', 'I/2013', 'LAB0008', 'LAB', '00049', '00042', NULL, 'LAB0008', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('64', 'letra', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'ACTIVO', 'I/2013', 'LAB0008', 'LAB', '00049', NULL, NULL, 'LAB0008', '');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('66', 'A)', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOG?A', 'CIVIL', 'CIV', 20, 0, 20, 'ACTIVO', 'I/2013', 'LAB0002', 'LAB', '00051', NULL, NULL, 'LAB0002', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('70', 'A)', 'METODOS GEODESICOS', '2012006', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', '2012006', 'MAT', '00055', NULL, 'MAT2005_000018', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('65', 'A)', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 0, 0, 0, 'INACTIVO', 'I/2013', 'LAB0008', 'LAB', '00050', NULL, NULL, 'LAB0008', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('69', 'A)', 'RESISTENCIA DE MATERIALES II', '2012013', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 4, 0, 4, 'ACTIVO', 'I/2013', '2012013', 'MAT', '00054', '00043', 'MAT2005_000028', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('72', 'A)', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 12, 0, 12, 'ACTIVO', 'I/2013', 'LAB0004', 'LAB', '00057', NULL, NULL, 'LAB0004', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('74', 'A)', 'LAB GEOTECNIA', 'GTUMSS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', 'LAB0002', 'LAB', '00058', NULL, NULL, 'LAB0002', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('73', 'letra', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 3, 0, 3, 'ACTIVO', 'I/2013', 'LAB0008', 'LAB', '00043', '00036', NULL, 'LAB0008', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('75', 'A)', 'LABORATORIO PAVIMENTOS Y ASFALTOS', 'LPAVAS', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 10, 0, 10, 'ACTIVO', 'I/2013', 'LAB0008', 'LAB', '00059', NULL, NULL, 'LAB0008', '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('60', 'A)', 'CENTRO AGUAS SANEAMIENTO AMB', 'CASA', 'CIENCIAS Y TECNOLOGIA', 'CIVIL', 'CIV', 39, 0, 10, 'ACTIVO', 'I/2013', 'LAB0004', 'LAB', '00047', '00039', NULL, 'LAB0004', '1');


--
-- TOC entry 2532 (class 0 OID 30049)
-- Dependencies: 199
-- Data for Name: mes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2533 (class 0 OID 30052)
-- Dependencies: 200
-- Data for Name: nombra_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('000007', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRE', 'II/2006', 10, 'INACTIVO', 'AUX2006_000008');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00013', 'ESCOBAR SALGUERO CLAUDIA', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-02', 'UN SEMESTRE', 'II/2006', 20, 'INACTIVO', 'AUX2006_000016');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00015', 'TORREJON O?O FABIOLA ESCARLET', 'ING. CIVIL', 'INGENIER?A CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'INACTIVO', 'AUX2006_000027');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00018', 'ABASTO CRUZ ENRRIQUE', 'ING. CIVIL', 'INGENIER?A CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'INACTIVO', 'AUX2006_000026');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00019', 'CAMACHO PE?A CHRISTIAM BORIS', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000020');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00021', 'RODRIGUEZ MARTINEZ JUAN', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000023');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00022', 'RODRIGUEZ ALVAREZ LILIANA ARACELI', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'INACTIVO', 'AUX2006_000006');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00023', 'UGARTE ONTIVEROS VLADIMIR', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 20, 'INACTIVO', 'AUX2006_000019');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00025', 'MONTA?O MONTECINOS JESUS ANTONIO', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000021');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00026', 'ANAYA DOMINGUEZ JAIME ALFREDO', '', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000022');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00020', 'MAMANI GUZMAN BENITO', 'ING. CIVIL', 'INGENIERIA CIVIL ', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000024');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00014', 'UNZUETA ZEBALLOS JOSE ANTONIO', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-02-20', '2006-03-03', 'UN SEMESTRE', 'II/2006', 2, 'INACTIVO', 'AUX2006_000003');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00027', 'UNZUETA ZEBALLOS JOSE ANTONIO', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-25', 'DOS SEMESTRES', 'II/2006', 2, 'INACTIVO', 'AUX2006_000032');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00024', 'MARTINEZ ARCE ARIEL', 'ING. CIVIL', 'INGENIERIA CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'II/2006', 2, 'INACTIVO', 'AUX2006_000025');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00028', 'BUSTAMANTE CHAVEZ ARIEL RENE', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'interno', '2006-08-08', '2006-08-28', 'DOS SEMESTRES', 'II/2006', 20, 'INACTIVO', 'AUX2006_000033');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00017', 'COLLARANI ANAGUA FREDDY GUIDO', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'interno', '2006-08-08', '2006-08-28', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000029');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00029', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-10-13', '2006-10-13', 'DOS SEMESTRES', 'II/2006', 0, 'INACTIVO', 'AUX2006_000017');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00030', 'FLORES CABEZAS LAURIAN', 'ING. CIVIL', 'CAMPO', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-10-13', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000034');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00032', 'BARRIOS COLOMO ANGELA MARIA', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-10-27', '2006-10-27', 'DOS SEMESTRES', 'II/2006', 10, 'INACTIVO', 'AUX2006_000038');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00016', 'QUIROGA ROJAS MAURICIO GONZALO', 'ING. CIVIL', 'INGENIER?A CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-08-08', '2006-08-23', 'DOS SEMESTRES', 'I/2007', 20, 'ACTIVO', 'AUX2006_000028');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00031', 'RIOJA HERRERA HEDBERT', 'ING. CIVIL', 'ING CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2006-10-27', '2006-10-27', 'DOS SEMESTRES', 'II/2007', 10, 'ACTIVO', 'AUX2006_000035');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00033', 'BUSTAMANTE UCHANI KATHYA ARACELY', 'ING. CIVIL', 'CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2007-09-13', '2007-09-13', 'DOS SEMESTRES', 'II/2007', 8, 'ACTIVO', 'AUX2007_000001');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00034', 'ARUQUIPA LARICO EDGAR PEDRO', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 10, 'ACTIVO', 'AUX2013_000006');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00035', 'MOLLO OCAÑA RODRIGO GERMAN', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 16, 'ACTIVO', 'AUX2013_000005');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00037', 'HIDALGO RODRIGUEZ ARIEL', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 10, 'ACTIVO', 'AUX2013_000004');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00038', 'FERREL YAVI JORGE LUIS', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-06', '2013-03-06', 'DOS SEMESTRES', 'I/2013', 10, 'ACTIVO', 'AUX2013_000002');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00040', 'JARA ARIAS EDWIN WINSOR', 'ING. CIVIL', 'ING.CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 10, 'ACTIVO', 'AUX2013_000008');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00041', 'MARTINEZ ARCE ARIEL', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 4, 'ACTIVO', 'AUX2006_000025');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00042', 'LEDEZMA PÉREZ JAHEL SARVIA', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-07', 'DOS SEMESTRES', 'I/2013', 20, 'ACTIVO', 'AUX2013_000011');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00036', 'BECERRA VILLANUEVA DANIEL', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-12', 'UN SEMESTRE', 'I/2013', 23, 'ACTIVO', 'AUX2013_000003');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00043', 'ZULETA NOVILLO ENRRIQUE WALTER', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 4, 'ACTIVO', 'AUX2013_000015');
INSERT INTO nombra_aux (codigo, nombre, carrera, departamento, facultad, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_auxiliar) VALUES ('00039', 'RODRIGUEZ URIBE ANA ROCIO', 'ING. CIVIL', 'ING. CIVIL', 'CIENCIAS Y TECNOLOGIA', 'titular', '2013-03-04', '2013-03-04', 'DOS SEMESTRES', 'I/2013', 39, 'ACTIVO', 'AUX2013_000009');


--
-- TOC entry 2534 (class 0 OID 30055)
-- Dependencies: 201
-- Data for Name: nombra_doc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2535 (class 0 OID 30058)
-- Dependencies: 202
-- Data for Name: nota; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2536 (class 0 OID 30061)
-- Dependencies: 203
-- Data for Name: pga_diagrams; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2537 (class 0 OID 30067)
-- Dependencies: 204
-- Data for Name: pga_forms; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2538 (class 0 OID 30073)
-- Dependencies: 205
-- Data for Name: pga_graphs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2539 (class 0 OID 30079)
-- Dependencies: 206
-- Data for Name: pga_images; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2540 (class 0 OID 30085)
-- Dependencies: 207
-- Data for Name: pga_layout; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO pga_layout (tablename, nrcols, colnames, colwidth) VALUES ('public.docente', 9, 'codigo ci nombre ape_paterno ape_materno estado diploma titulo tiempo', '150 150 150 150 150 150 150 150 150');
INSERT INTO pga_layout (tablename, nrcols, colnames, colwidth) VALUES ('public.gestion', 5, 'codigo gestion fecha_ini fecha_fin estado', '150 150 150 150 150');


--
-- TOC entry 2541 (class 0 OID 30091)
-- Dependencies: 208
-- Data for Name: pga_queries; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2542 (class 0 OID 30097)
-- Dependencies: 209
-- Data for Name: pga_reports; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2543 (class 0 OID 30103)
-- Dependencies: 210
-- Data for Name: pga_scripts; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2544 (class 0 OID 30109)
-- Dependencies: 211
-- Data for Name: plan; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO plan (codigo, nombre, codigo_sis, fecha_ini, fecha_fin, estado, fk_carrera) VALUES ('PLAN0001', 'LICENCIATURA EN INGENIERIA CIVIL', '329201', NULL, NULL, 'ACTIVO', 'CAR0001');


--
-- TOC entry 2545 (class 0 OID 30112)
-- Dependencies: 212
-- Data for Name: plan_mat; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('1', 'PLAN0001', 'MAT2005_000001');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('2', 'PLAN0001', 'MAT2005_000002');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('3', 'PLAN0001', 'MAT2005_000003');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('4', 'PLAN0001', 'MAT2005_000004');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('5', 'PLAN0001', 'MAT2005_000005');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('6', 'PLAN0001', 'MAT2005_000006');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('7', 'PLAN0001', 'MAT2005_000007');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('8', 'PLAN0001', 'MAT2005_000008');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('9', 'PLAN0001', 'MAT2005_000009');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('10', 'PLAN0001', 'MAT2005_000010');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('11', 'PLAN0001', 'MAT2005_000011');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('12', 'PLAN0001', 'MAT2005_000012');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('13', 'PLAN0001', 'MAT2005_000013');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('14', 'PLAN0001', 'MAT2005_000014');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('15', 'PLAN0001', 'MAT2005_000015');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('16', 'PLAN0001', 'MAT2005_000016');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('17', 'PLAN0001', 'MAT2005_000017');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('18', 'PLAN0001', 'MAT2005_000018');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('19', 'PLAN0001', 'MAT2005_000019');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('20', 'PLAN0001', 'MAT2005_000020');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('21', 'PLAN0001', 'MAT2005_000021');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('22', 'PLAN0001', 'MAT2005_000022');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('23', 'PLAN0001', 'MAT2005_000023');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('24', 'PLAN0001', 'MAT2005_000024');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('25', 'PLAN0001', 'MAT2005_000025');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('26', 'PLAN0001', 'MAT2005_000026');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('28', 'PLAN0001', 'MAT2005_000028');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('29', 'PLAN0001', 'MAT2005_000029');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('30', 'PLAN0001', 'MAT2005_000030');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('31', 'PLAN0001', 'MAT2005_000031');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('32', 'PLAN0001', 'MAT2005_000032');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('33', 'PLAN0001', 'MAT2005_000033');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('34', 'PLAN0001', 'MAT2005_000034');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('35', 'PLAN0001', 'MAT2005_000035');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('36', 'PLAN0001', 'MAT2005_000036');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('37', 'PLAN0001', 'MAT2005_000037');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('38', 'PLAN0001', 'MAT2005_000038');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('39', 'PLAN0001', 'MAT2005_000039');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('40', 'PLAN0001', 'MAT2005_000040');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('41', 'PLAN0001', 'MAT2005_000041');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('42', 'PLAN0001', 'MAT2005_000042');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('43', 'PLAN0001', 'MAT2005_000043');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('44', 'PLAN0001', 'MAT2005_000044');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('45', 'PLAN0001', 'MAT2005_000045');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('46', 'PLAN0001', 'MAT2005_000046');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('47', 'PLAN0001', 'MAT2005_000047');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('48', 'PLAN0001', 'MAT2005_000048');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('49', 'PLAN0001', 'MAT2005_000049');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('50', 'PLAN0001', 'MAT2005_000050');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('51', 'PLAN0001', 'MAT2005_000051');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('52', 'PLAN0001', 'MAT2005_000052');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('53', 'PLAN0001', 'MAT2005_000053');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('54', 'PLAN0001', 'MAT2005_000054');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('55', 'PLAN0001', 'MAT2005_000055');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('56', 'PLAN0001', 'MAT2005_000056');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('57', 'PLAN0001', 'MAT2005_000057');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('58', 'PLAN0001', 'MAT2005_000058');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('59', 'PLAN0001', 'MAT2005_000059');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('60', 'PLAN0001', 'MAT2005_000060');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('61', 'PLAN0001', 'MAT2005_000061');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('62', 'PLAN0001', 'MAT2005_000062');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('63', 'PLAN0001', 'MAT2005_000063');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('64', 'PLAN0001', 'MAT2005_000064');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('65', 'PLAN0001', 'MAT2005_000065');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('66', 'PLAN0001', 'MAT2005_000066');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('67', 'PLAN0001', 'MAT2005_000067');
INSERT INTO plan_mat (codigo, fk_plan, fk_materia) VALUES ('68', 'PLAN0001', 'MAT2005_000027');


--
-- TOC entry 2546 (class 0 OID 30115)
-- Dependencies: 213
-- Data for Name: prerequisito; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000007', 'MAT2005_000005');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000008', 'MAT2005_000003');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000009', 'MAT2005_000004');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000010', 'MAT2005_000004');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000011', 'MAT2005_000009');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000012', 'MAT2005_000009');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000013', 'MAT2005_000008');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000014', 'MAT2005_000001');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000015', 'MAT2005_000006');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000016', 'MAT2005_000011');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000017', 'MAT2005_000014');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000018', 'MAT2005_000007');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000018', 'MAT2005_000010');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000019', 'MAT2005_000014');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000020', 'MAT2005_000012');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000020', 'MAT2005_000013');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000021', 'MAT2005_000020');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000022', 'MAT2005_000006');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000022', 'MAT2005_000011');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000023', 'MAT2005_000018');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000024', 'MAT2005_000019');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000025', 'MAT2005_000016');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000026', 'MAT2005_000022');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000028', 'MAT2005_000025');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000029', 'MAT2005_000017');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000029', 'MAT2005_000025');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000030', 'MAT2005_000023');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000030', 'MAT2005_000024');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000031', 'MAT2005_000026');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000031', 'MAT2005_000027');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000032', 'MAT2005_000028');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000033', 'MAT2005_000028');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000034', 'MAT2005_000029');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000035', 'MAT2005_000020');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000036', 'MAT2005_000029');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000037', 'MAT2005_000031');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000038', 'MAT2005_000032');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000038', 'MAT2005_000034');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000039', 'MAT2005_000035');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000040', 'MAT2005_000036');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000041', 'MAT2005_000030');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000041', 'MAT2005_000036');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000042', 'MAT2005_000035');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000043', 'MAT2005_000037');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000043', 'MAT2005_000038');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000043', 'MAT2005_000039');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000043', 'MAT2005_000040');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000043', 'MAT2005_000041');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000043', 'MAT2005_000042');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000044', 'MAT2005_000026');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000044', 'MAT2005_000038');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000045', 'MAT2005_000032');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000045', 'MAT2005_000033');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000046', 'MAT2005_000038');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000046', 'MAT2005_000039');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000047', 'MAT2005_000042');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000048', 'MAT2005_000036');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000048', 'MAT2005_000038');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000049', 'MAT2005_000037');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000050', 'MAT2005_000043');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000051', 'MAT2005_000038');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000051', 'MAT2005_000045');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000052', 'MAT2005_000038');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000053', 'MAT2005_000048');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000054', 'MAT2005_000045');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000055', 'MAT2005_000048');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000056', 'MAT2005_000041');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000056', 'MAT2005_000044');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000057', 'MAT2005_000041');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000058', 'MAT2005_000041');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000058', 'MAT2005_000047');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000059', 'MAT2005_000041');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000060', 'MAT2005_000044');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000061', 'MAT2005_000044');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000062', 'MAT2005_000044');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000063', 'MAT2005_000044');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000064', 'MAT2005_000049');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000065', 'MAT2005_000046');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000065', 'MAT2005_000049');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000066', 'MAT2005_000044');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000067', 'MAT2005_000049');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000027', 'MAT2005_000022');
INSERT INTO prerequisito (fk_materia, fk_pre_materia) VALUES ('MAT2005_000027', 'MAT2005_000021');


--
-- TOC entry 2547 (class 0 OID 30118)
-- Dependencies: 214
-- Data for Name: prestamo_tesis; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2548 (class 0 OID 30124)
-- Dependencies: 215
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2549 (class 0 OID 30127)
-- Dependencies: 216
-- Data for Name: programa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2550 (class 0 OID 30131)
-- Dependencies: 217
-- Data for Name: rango_res; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2551 (class 0 OID 30134)
-- Dependencies: 218
-- Data for Name: remitente; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2552 (class 0 OID 30137)
-- Dependencies: 219
-- Data for Name: reserva; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2553 (class 0 OID 30140)
-- Dependencies: 220
-- Data for Name: sala; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sala (codigo, nombre, cant_equi, descrip, estado) VALUES ('000001', 'LABO1', '25', '', 'ACTIVO');


--
-- TOC entry 2554 (class 0 OID 30144)
-- Dependencies: 221
-- Data for Name: segui_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00010', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000008', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00018', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000016', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00019', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000027', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00020', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000026', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00021', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000029', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00022', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000023', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00025', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000020', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00026', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000006', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00028', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000021', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00029', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000022', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00030', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000019', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00031', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '0', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000017', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00024', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'II/2006', '', 'AUX2006_000024', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000005', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'II/2006', '', 'AUX2006_000003', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00033', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'II/2006', '', 'AUX2006_000032', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00034', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'II/2006', '', 'AUX2006_000033', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00032', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000031', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00035', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000034', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00037', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000037', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00038', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2006', '', 'AUX2006_000038', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00027', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'II/2006', '', 'AUX2006_000025', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00039', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '0', '', '', 'I/2007', '', 'AUX2005_000001', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00023', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2007', '', 'AUX2006_000028', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00036', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'II/2007', '', 'AUX2006_000035', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00040', '', 'N', 'N', 'N', 'N', 'AUXILIAR DE INVESTIGACION', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'II/2007', '', 'AUX2007_000001', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00041', '', 'N', 'N', 'N', 'N', 'Campo', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000006', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00042', '', 'N', 'N', 'N', 'N', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2013', '', 'AUX2013_000005', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00044', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000004', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00045', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000002', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00046', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000008', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00048', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2013', '', 'AUX2006_000025', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00049', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2013', '', 'AUX2013_000011', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00051', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2013', '', 'AUX2013_000012', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00052', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2013', '', 'AUX2013_000007', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00053', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000014', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00054', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2013', '', 'AUX2013_000015', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00055', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000019', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00050', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '0', '', '', 'I/2013', '', 'AUX2013_000016', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00056', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '20', '', '', '', '', '', '', '', '', '', '', '', '20', '80', '80', '', '', 'I/2013', '', 'AUX2013_000017', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00057', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '12', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000010', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00043', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '23', '', '', '', '', '', '', '', '', '', '', '', '23', '92', '80', '', '', 'I/2013', '', 'AUX2013_000003', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00058', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000024', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00059', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000025', 'ACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00047', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2013', '', 'AUX2013_000009', 'ACTIVO');


--
-- TOC entry 2555 (class 0 OID 30147)
-- Dependencies: 222
-- Data for Name: segui_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000002', 'alvarado', 'N', 'N', 'S', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '12', '', '0', 'I/2013', 'PARCIAL', 'DOC0001', 'ACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000003', '', 'N', 'N', 'S', 'N', '', '1', '', '', '', '1', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2013', 'EXCLUSIVO', 'DOC0042', 'ACTIVO');


--
-- TOC entry 2556 (class 0 OID 30150)
-- Dependencies: 223
-- Data for Name: segui_exclu_auto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('168', 'AUTORIDAD', 'OFICINA', 'JEFE DPTO.', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '000009');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('169', 'AUTORIDAD', 'OFICINA', 'JEFE DPTO.', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '000009');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('188', 'AUTORIDAD', 'OFICINA', 'DIR. OBRA', '08:15:00', '3', '12:00:00', '8', 'ACTIVO', '00026');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('189', 'AUTORIDAD', 'OFICINA', 'DIR. OBRA', '14:15:00', '11', '18:00:00', '16', 'ACTIVO', '00026');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('192', 'AUTORIDAD', 'OFICINA', '', '06:45:00', '1', '15:45:00', '13', 'ACTIVO', '00028');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('193', 'AUTORIDAD', 'OFICINA', '', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00028');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('194', 'AUTORIDAD', 'OFICINA', '', '08:15:00', '3', '12:00:00', '8', 'ACTIVO', '00032');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('195', 'AUTORIDAD', 'OFICINA', '', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00032');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('196', 'AUTORIDAD', 'OFICINA', 'DPTO. CIVIL ', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00035');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('197', 'AUTORIDAD', 'OFICINA', 'DPTO. CIVIL ', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00035');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('204', 'AUTORIDAD', 'OFICINA', 'DPTO CIVIL', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00033');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('205', 'AUTORIDAD', 'OFICINA', 'DPTO CIVIL', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00033');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('206', 'EXCLUSIVO', 'CONTINUO', 'LAB GEOTECNIA', '07:30:00', '2', '15:45:00', '13', 'ACTIVO', '00015');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('210', 'AUTORIDAD', 'CONTINUO', 'DIR. GEOTECNIA', '06:45:00', '1', '15:45:00', '13', 'ACTIVO', '00027');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('211', 'EXCLUSIVO', 'OFICINA', 'LAB. HIDRAULICA', '07:30:00', '2', '15:45:00', '13', 'ACTIVO', '00011');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('212', 'EXCLUSIVO', 'OFICINA', 'LAB. HIDRAULICA', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00011');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('213', 'AUTORIDAD', 'OFICINA', 'LAB. HIDRAULICA', '07:30:00', '2', '15:45:00', '13', 'ACTIVO', '00019');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('214', 'AUTORIDAD', 'OFICINA', 'LAB. HIDRAULICA', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00019');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('215', 'AUTORIDAD', 'CONTINUO', 'LAB. HIDRAULICA', '07:30:00', '2', '15:45:00', '13', 'ACTIVO', '00025');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('216', 'AUTORIDAD', 'OFICINA', '', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '000002');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('217', 'AUTORIDAD', 'OFICINA', '', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '000002');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('218', 'EXCLUSIVO', 'OFICINA', '', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '000003');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('219', 'EXCLUSIVO', 'OFICINA', '', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '000003');


--
-- TOC entry 2557 (class 0 OID 30153)
-- Dependencies: 224
-- Data for Name: sesion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2558 (class 0 OID 30157)
-- Dependencies: 225
-- Data for Name: tabla_horario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2559 (class 0 OID 30160)
-- Dependencies: 226
-- Data for Name: tabla_horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2560 (class 0 OID 30163)
-- Dependencies: 227
-- Data for Name: tema; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2561 (class 0 OID 30166)
-- Dependencies: 228
-- Data for Name: temp_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO temp_aux (codigo, cod_adh, nombres, cargo, horas, ci, gestion1, gestion2, fecha, fk_sesion, tipo, condicion) VALUES ('TEMP1', '', ' , ', 'Administrador del Laboratorio de Computo', '80', '', 'I/2013', 'II/2012', '08 de Julio de 2013', 'SES1', '1', '');


--
-- TOC entry 2562 (class 0 OID 30169)
-- Dependencies: 229
-- Data for Name: temp_bibliografia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2563 (class 0 OID 30172)
-- Dependencies: 230
-- Data for Name: temp_cert_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2564 (class 0 OID 30175)
-- Dependencies: 231
-- Data for Name: temp_control_segui; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2565 (class 0 OID 30178)
-- Dependencies: 232
-- Data for Name: temp_destinatario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2566 (class 0 OID 30181)
-- Dependencies: 233
-- Data for Name: temp_detalle_reserva; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2567 (class 0 OID 30184)
-- Dependencies: 234
-- Data for Name: temp_horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2568 (class 0 OID 30187)
-- Dependencies: 235
-- Data for Name: temp_horario_doc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2569 (class 0 OID 30190)
-- Dependencies: 236
-- Data for Name: temp_impresion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2570 (class 0 OID 30193)
-- Dependencies: 237
-- Data for Name: temp_materia_dicta; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2571 (class 0 OID 30196)
-- Dependencies: 238
-- Data for Name: temp_materia_labo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2572 (class 0 OID 30199)
-- Dependencies: 239
-- Data for Name: temp_materias; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2573 (class 0 OID 30202)
-- Dependencies: 240
-- Data for Name: temp_nota; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2574 (class 0 OID 30205)
-- Dependencies: 241
-- Data for Name: temp_rango; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2575 (class 0 OID 30208)
-- Dependencies: 242
-- Data for Name: temp_rep_tesis_defen; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2576 (class 0 OID 30211)
-- Dependencies: 243
-- Data for Name: temp_tesismos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO temp_tesismos (cod_tes, nombres, titulo, modalidad, carrera, gestion) VALUES (52, 'SARAI ROMERO VARGAS', 'DISE?O DE RED DE AGUA POTABLE Y ALCANTARILLA SANITARIO PARA MINEROS SAN JUAN USPHA USPHA', 'Trabajo Dirigido', 'ING. CIVIL', 'II/2007');


--
-- TOC entry 2577 (class 0 OID 30214)
-- Dependencies: 244
-- Data for Name: temp_tesista; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2578 (class 0 OID 30217)
-- Dependencies: 245
-- Data for Name: temp_validar_hor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2579 (class 0 OID 30220)
-- Dependencies: 246
-- Data for Name: tesis; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tesis (codigo, titulo, modalidad, gestion, cod_tes, tomos) VALUES ('TES0001', 'DISE?O DE RED DE AGUA POTABLE Y ALCANTARILLA SANITARIO PARA MINEROS SAN JUAN USPHA USPHA', 'Trabajo Dirigido', 'II/2007', 52, NULL);


--
-- TOC entry 2580 (class 0 OID 30223)
-- Dependencies: 247
-- Data for Name: tesista; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tesista (codigo, nombre, ape_paterno, ape_materno, carrera, ci, fk_tesis) VALUES ('ETS0001', 'SARAI', 'ROMERO', 'VARGAS', 'ING. CIVIL', NULL, 'TES0001');


--
-- TOC entry 2581 (class 0 OID 30226)
-- Dependencies: 248
-- Data for Name: titulo_adic; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2582 (class 0 OID 30229)
-- Dependencies: 249
-- Data for Name: titulo_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2583 (class 0 OID 30232)
-- Dependencies: 250
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2005_0001', 'CIVIL', 'CIVIL', 'CIVIL', 'ACTIVO', 'M', 'civil', '6af2462065474ec7892340e39339eb38', NULL, 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2006_0002', 'JORGE MARTIN', 'DUCHEN', 'AYALA', 'ACTIVO', 'M', 'duchenj', '437b259b8f986fade6593841ea58613f', 'AUT2006_0002', '');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2006_0001', 'ARMANDO', 'ESCALERA', 'VASQUEZ', 'INACTIVO', 'M', 'escaleraa', '7b64d09060db17ca6b96c0af99575903', 'AUT2006_0001', '');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2004_0001', 'ADMINISTRADOR', 'ADMINISTRADOR', 'ADMINISTRADOR', 'ACTIVO', 'F', 'admin', '23e06d95025f65b3a442e63e5e924f9c', '', 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2011_0002', 'HERNAN', 'FLORES', 'GARCIA', 'ACTIVO', 'M', 'floresh', 'd7403066713e9d99bcc97a8db69bfb67', 'AUT2011_0002', '');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2012_0001', 'GUIDO', 'GOMEZ', 'UGARTE', 'ACTIVO', 'M', 'gomezg', 'ec740a96325c72c8e40254ad7f083113', 'AUT2012_0001', '');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2011_0003', 'JULIO', 'GUZMAN', 'GUILLEN', 'INACTIVO', 'M', 'guzmanj', 'd7403066713e9d99bcc97a8db69bfb67', 'AUT2011_0003', '');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2011_0001', 'ORLANDO', 'CAMACHO', 'QUIROGA', 'ACTIVO', 'M', 'camachoo', 'e10adc3949ba59abbe56e057f20f883e', 'AUT2011_0001', '');


SET search_path = apoyo, pg_catalog;

--
-- TOC entry 2172 (class 2606 OID 30237)
-- Name: pk_variable; Type: CONSTRAINT; Schema: apoyo; Owner: -; Tablespace: 
--

ALTER TABLE ONLY variable
    ADD CONSTRAINT pk_variable PRIMARY KEY (id_variable);


SET search_path = public, pg_catalog;

--
-- TOC entry 2174 (class 2606 OID 30239)
-- Name: actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2176 (class 2606 OID 30241)
-- Name: adhonorem_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adhonorem
    ADD CONSTRAINT adhonorem_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2180 (class 2606 OID 30243)
-- Name: autoridad_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY autoridad
    ADD CONSTRAINT autoridad_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2182 (class 2606 OID 30245)
-- Name: aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aux
    ADD CONSTRAINT aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2184 (class 2606 OID 30247)
-- Name: auxiliar_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auxiliar
    ADD CONSTRAINT auxiliar_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2188 (class 2606 OID 30249)
-- Name: auxiliatura_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auxiliatura
    ADD CONSTRAINT auxiliatura_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2190 (class 2606 OID 30251)
-- Name: bibliografia_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bibliografia
    ADD CONSTRAINT bibliografia_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2192 (class 2606 OID 30253)
-- Name: car_adh_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY car_adh
    ADD CONSTRAINT car_adh_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2194 (class 2606 OID 30255)
-- Name: car_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT car_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2196 (class 2606 OID 30257)
-- Name: cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cargo
    ADD CONSTRAINT cargo_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2198 (class 2606 OID 30259)
-- Name: carrera_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2200 (class 2606 OID 30261)
-- Name: carta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY carta
    ADD CONSTRAINT carta_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2204 (class 2606 OID 30263)
-- Name: categoria_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categoria_aux
    ADD CONSTRAINT categoria_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2208 (class 2606 OID 30265)
-- Name: categoria_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categoria_doc
    ADD CONSTRAINT categoria_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2210 (class 2606 OID 30267)
-- Name: certificado_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT certificado_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2212 (class 2606 OID 30269)
-- Name: combo_box_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY combo_box
    ADD CONSTRAINT combo_box_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2218 (class 2606 OID 30271)
-- Name: curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2220 (class 2606 OID 30273)
-- Name: destinatario_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY destinatario
    ADD CONSTRAINT destinatario_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2222 (class 2606 OID 30275)
-- Name: detalle_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY detalle_reserva
    ADD CONSTRAINT detalle_reserva_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2224 (class 2606 OID 30277)
-- Name: dia_res_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dia_res
    ADD CONSTRAINT dia_res_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2226 (class 2606 OID 30279)
-- Name: docente_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY docente
    ADD CONSTRAINT docente_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2228 (class 2606 OID 30281)
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2230 (class 2606 OID 30283)
-- Name: estandarc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY estandarc
    ADD CONSTRAINT estandarc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2232 (class 2606 OID 30285)
-- Name: gestion_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY gestion
    ADD CONSTRAINT gestion_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2234 (class 2606 OID 30287)
-- Name: hist_auxiliatura_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_auxiliatura
    ADD CONSTRAINT hist_auxiliatura_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2236 (class 2606 OID 30289)
-- Name: hist_categoria_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_categoria_doc
    ADD CONSTRAINT hist_categoria_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2238 (class 2606 OID 30291)
-- Name: hist_materia_dicta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT hist_materia_dicta_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2240 (class 2606 OID 30293)
-- Name: hist_nombra_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_nombra_aux
    ADD CONSTRAINT hist_nombra_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2242 (class 2606 OID 30295)
-- Name: hist_nombra_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_nombra_doc
    ADD CONSTRAINT hist_nombra_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2244 (class 2606 OID 30297)
-- Name: hist_segui_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_segui_aux
    ADD CONSTRAINT hist_segui_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2246 (class 2606 OID 30299)
-- Name: hist_segui_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_segui_doc
    ADD CONSTRAINT hist_segui_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2248 (class 2606 OID 30301)
-- Name: horario_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horario_aux
    ADD CONSTRAINT horario_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2250 (class 2606 OID 30303)
-- Name: horario_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horario_doc
    ADD CONSTRAINT horario_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2252 (class 2606 OID 30305)
-- Name: horas_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horas_aux
    ADD CONSTRAINT horas_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2254 (class 2606 OID 30307)
-- Name: horas_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horas_doc
    ADD CONSTRAINT horas_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2256 (class 2606 OID 30309)
-- Name: inscritos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inscritos
    ADD CONSTRAINT inscritos_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2258 (class 2606 OID 30311)
-- Name: laboratorio_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY laboratorio
    ADD CONSTRAINT laboratorio_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2262 (class 2606 OID 30313)
-- Name: materia_dicta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT materia_dicta_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2264 (class 2606 OID 30315)
-- Name: materia_labo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT materia_labo_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2260 (class 2606 OID 30317)
-- Name: materia_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia
    ADD CONSTRAINT materia_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2266 (class 2606 OID 30319)
-- Name: nombra_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nombra_aux
    ADD CONSTRAINT nombra_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2268 (class 2606 OID 30321)
-- Name: nombra_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nombra_doc
    ADD CONSTRAINT nombra_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2270 (class 2606 OID 30323)
-- Name: pga_diagrams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_diagrams
    ADD CONSTRAINT pga_diagrams_pkey PRIMARY KEY (diagramname);


--
-- TOC entry 2272 (class 2606 OID 30325)
-- Name: pga_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_forms
    ADD CONSTRAINT pga_forms_pkey PRIMARY KEY (formname);


--
-- TOC entry 2274 (class 2606 OID 30327)
-- Name: pga_graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_graphs
    ADD CONSTRAINT pga_graphs_pkey PRIMARY KEY (graphname);


--
-- TOC entry 2276 (class 2606 OID 30329)
-- Name: pga_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_images
    ADD CONSTRAINT pga_images_pkey PRIMARY KEY (imagename);


--
-- TOC entry 2278 (class 2606 OID 30331)
-- Name: pga_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_layout
    ADD CONSTRAINT pga_layout_pkey PRIMARY KEY (tablename);


--
-- TOC entry 2280 (class 2606 OID 30333)
-- Name: pga_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_queries
    ADD CONSTRAINT pga_queries_pkey PRIMARY KEY (queryname);


--
-- TOC entry 2282 (class 2606 OID 30335)
-- Name: pga_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_reports
    ADD CONSTRAINT pga_reports_pkey PRIMARY KEY (reportname);


--
-- TOC entry 2284 (class 2606 OID 30337)
-- Name: pga_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_scripts
    ADD CONSTRAINT pga_scripts_pkey PRIMARY KEY (scriptname);


--
-- TOC entry 2178 (class 2606 OID 30339)
-- Name: pk_adhonorem_ext; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adhonorem_ext
    ADD CONSTRAINT pk_adhonorem_ext PRIMARY KEY (fk_adhonorem);


--
-- TOC entry 2186 (class 2606 OID 30341)
-- Name: pk_auxiliar_ext; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auxiliar_ext
    ADD CONSTRAINT pk_auxiliar_ext PRIMARY KEY (fk_auxiliar);


--
-- TOC entry 2202 (class 2606 OID 30343)
-- Name: pk_catalogo_curso; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY catalogo_curso
    ADD CONSTRAINT pk_catalogo_curso PRIMARY KEY (codigo);


--
-- TOC entry 2206 (class 2606 OID 30345)
-- Name: pk_categoria_curso; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categoria_curso
    ADD CONSTRAINT pk_categoria_curso PRIMARY KEY (codigo);


--
-- TOC entry 2214 (class 2606 OID 30347)
-- Name: pk_cprol; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cprol
    ADD CONSTRAINT pk_cprol PRIMARY KEY (codigo);


--
-- TOC entry 2216 (class 2606 OID 30349)
-- Name: pk_cptarea; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cptarea
    ADD CONSTRAINT pk_cptarea PRIMARY KEY (codigo);


--
-- TOC entry 2288 (class 2606 OID 30351)
-- Name: plan_mat_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT plan_mat_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2286 (class 2606 OID 30353)
-- Name: plan_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2290 (class 2606 OID 30355)
-- Name: prestamo_tesis_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prestamo_tesis
    ADD CONSTRAINT prestamo_tesis_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2292 (class 2606 OID 30357)
-- Name: profesor_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT profesor_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2294 (class 2606 OID 30359)
-- Name: programa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT programa_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2296 (class 2606 OID 30361)
-- Name: rango_res_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rango_res
    ADD CONSTRAINT rango_res_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2298 (class 2606 OID 30363)
-- Name: reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reserva
    ADD CONSTRAINT reserva_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2300 (class 2606 OID 30365)
-- Name: sala_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sala
    ADD CONSTRAINT sala_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2302 (class 2606 OID 30367)
-- Name: segui_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY segui_aux
    ADD CONSTRAINT segui_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2304 (class 2606 OID 30369)
-- Name: segui_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY segui_doc
    ADD CONSTRAINT segui_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2306 (class 2606 OID 30371)
-- Name: sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sesion
    ADD CONSTRAINT sesion_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2308 (class 2606 OID 30373)
-- Name: temp_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_aux
    ADD CONSTRAINT temp_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2310 (class 2606 OID 30375)
-- Name: temp_cert_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_cert_curso
    ADD CONSTRAINT temp_cert_curso_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2312 (class 2606 OID 30377)
-- Name: temp_destinatario_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_destinatario
    ADD CONSTRAINT temp_destinatario_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2314 (class 2606 OID 30379)
-- Name: temp_detalle_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_detalle_reserva
    ADD CONSTRAINT temp_detalle_reserva_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2316 (class 2606 OID 30381)
-- Name: temp_validar_hor_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_validar_hor
    ADD CONSTRAINT temp_validar_hor_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2318 (class 2606 OID 30383)
-- Name: tesis_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tesis
    ADD CONSTRAINT tesis_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2320 (class 2606 OID 30385)
-- Name: tesista_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tesista
    ADD CONSTRAINT tesista_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2322 (class 2606 OID 30387)
-- Name: titulo_adic_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY titulo_adic
    ADD CONSTRAINT titulo_adic_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2324 (class 2606 OID 30389)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2335 (class 2606 OID 30390)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cargo
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_laboratorio) REFERENCES laboratorio(codigo);


--
-- TOC entry 2333 (class 2606 OID 30395)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2373 (class 2606 OID 30400)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_carrera) REFERENCES carrera(codigo);


--
-- TOC entry 2374 (class 2606 OID 30405)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_plan) REFERENCES plan(codigo);


--
-- TOC entry 2370 (class 2606 OID 30410)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nombra_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2342 (class 2606 OID 30415)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_doc) REFERENCES nombra_doc(codigo);


--
-- TOC entry 2383 (class 2606 OID 30420)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY segui_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2362 (class 2606 OID 30425)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_doc) REFERENCES segui_doc(codigo);


--
-- TOC entry 2361 (class 2606 OID 30430)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_rangos_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_horario_doc) REFERENCES horario_doc(codigo);


--
-- TOC entry 2357 (class 2606 OID 30435)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2352 (class 2606 OID 30440)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_categoria_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_doc) REFERENCES hist_nombra_doc(codigo);


--
-- TOC entry 2359 (class 2606 OID 30445)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2353 (class 2606 OID 30450)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_doc) REFERENCES hist_segui_doc(codigo);


--
-- TOC entry 2369 (class 2606 OID 30455)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nombra_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2341 (class 2606 OID 30460)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES nombra_aux(codigo);


--
-- TOC entry 2329 (class 2606 OID 30465)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliatura
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES nombra_aux(codigo);


--
-- TOC entry 2382 (class 2606 OID 30470)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY segui_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2365 (class 2606 OID 30475)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_aux) REFERENCES segui_aux(codigo);


--
-- TOC entry 2360 (class 2606 OID 30480)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_rangos_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_horario_aux) REFERENCES horario_aux(codigo);


--
-- TOC entry 2356 (class 2606 OID 30485)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2351 (class 2606 OID 30490)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_auxiliatura
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES hist_nombra_aux(codigo);


--
-- TOC entry 2358 (class 2606 OID 30495)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2385 (class 2606 OID 30500)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tesista
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_tesis) REFERENCES tesis(codigo);


--
-- TOC entry 2378 (class 2606 OID 30505)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prestamo_tesis
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_tesis) REFERENCES tesis(codigo);


--
-- TOC entry 2331 (class 2606 OID 30510)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_adh
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2327 (class 2606 OID 30515)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY autoridad
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2325 (class 2606 OID 30520)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2343 (class 2606 OID 30525)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_aux) REFERENCES aux(codigo);


--
-- TOC entry 2349 (class 2606 OID 30530)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_profesor) REFERENCES profesor(codigo);


--
-- TOC entry 2371 (class 2606 OID 30535)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nota
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_curso) REFERENCES curso(codigo);


--
-- TOC entry 2380 (class 2606 OID 30540)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remitente
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_estandar) REFERENCES estandarc(codigo);


--
-- TOC entry 2336 (class 2606 OID 30545)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_estandarc) REFERENCES estandarc(codigo);


--
-- TOC entry 2337 (class 2606 OID 30550)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta_dest
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2379 (class 2606 OID 30555)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2384 (class 2606 OID 30560)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_programa) REFERENCES programa(codigo);


--
-- TOC entry 2330 (class 2606 OID 30565)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bibliografia
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_programa) REFERENCES programa(codigo);


--
-- TOC entry 2376 (class 2606 OID 30570)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prerequisito
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2386 (class 2606 OID 30575)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titulo_curso
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_titulo) REFERENCES titulo_adic(codigo);


--
-- TOC entry 2334 (class 2606 OID 30580)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2375 (class 2606 OID 30585)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2363 (class 2606 OID 30590)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_doc) REFERENCES nombra_doc(codigo);


--
-- TOC entry 2354 (class 2606 OID 30595)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_doc) REFERENCES hist_nombra_doc(codigo);


--
-- TOC entry 2366 (class 2606 OID 30600)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_aux) REFERENCES nombra_aux(codigo);


--
-- TOC entry 2332 (class 2606 OID 30605)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_adh
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_adhonorem) REFERENCES adhonorem(codigo);


--
-- TOC entry 2344 (class 2606 OID 30610)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_autoridad) REFERENCES autoridad(codigo);


--
-- TOC entry 2387 (class 2606 OID 30615)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titulo_curso
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_curso) REFERENCES curso(codigo);


--
-- TOC entry 2372 (class 2606 OID 30620)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nota
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_inscritos) REFERENCES inscritos(codigo);


--
-- TOC entry 2381 (class 2606 OID 30625)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remitente
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2338 (class 2606 OID 30630)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta_dest
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_destinatario) REFERENCES destinatario(codigo);


--
-- TOC entry 2377 (class 2606 OID 30635)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prerequisito
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_pre_materia) REFERENCES materia(codigo);


--
-- TOC entry 2364 (class 2606 OID 30640)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2355 (class 2606 OID 30645)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2367 (class 2606 OID 30650)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2339 (class 2606 OID 30655)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta_dest
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_carta) REFERENCES carta(codigo);


--
-- TOC entry 2368 (class 2606 OID 30660)
-- Name: $4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$4" FOREIGN KEY (fk_laboratorio) REFERENCES laboratorio(codigo);


--
-- TOC entry 2326 (class 2606 OID 30665)
-- Name: fk_adh_ext_reference_adhonorem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adhonorem_ext
    ADD CONSTRAINT fk_adh_ext_reference_adhonorem FOREIGN KEY (fk_adhonorem) REFERENCES adhonorem(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2328 (class 2606 OID 30670)
-- Name: fk_aux_ext_reference_auxiliar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliar_ext
    ADD CONSTRAINT fk_aux_ext_reference_auxiliar FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2340 (class 2606 OID 30675)
-- Name: fk_cat_cur_reference_catalogo_curso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY catalogo_curso
    ADD CONSTRAINT fk_cat_cur_reference_catalogo_curso FOREIGN KEY (fk_categoria_curso) REFERENCES categoria_curso(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2350 (class 2606 OID 30680)
-- Name: fk_cat_cur_reference_catalogo_curso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT fk_cat_cur_reference_catalogo_curso FOREIGN KEY (fk_catalogo_curso) REFERENCES catalogo_curso(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2347 (class 2606 OID 30685)
-- Name: tiene1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT tiene1 FOREIGN KEY (fk_codigo_rol) REFERENCES cprol(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2345 (class 2606 OID 30690)
-- Name: tiene1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT tiene1 FOREIGN KEY (fk_codigo_rol) REFERENCES cprol(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2348 (class 2606 OID 30695)
-- Name: tiene2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT tiene2 FOREIGN KEY (fk_codigo_tarea) REFERENCES cptarea(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2346 (class 2606 OID 30700)
-- Name: tiene2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT tiene2 FOREIGN KEY (fk_codigo_usr) REFERENCES usuario(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2591 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-12-13 08:44:43 BOT

--
-- PostgreSQL database dump complete
--

