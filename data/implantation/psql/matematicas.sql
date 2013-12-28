--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.7
-- Dumped by pg_dump version 9.3.0
-- Started on 2013-12-13 08:44:45 BOT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 41247)
-- Name: apoyo; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA apoyo;


SET search_path = apoyo, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 252 (class 1259 OID 41248)
-- Name: variable; Type: TABLE; Schema: apoyo; Owner: -; Tablespace: 
--

CREATE TABLE variable (
    id_variable integer NOT NULL,
    nombre_variable character varying(64) NOT NULL,
    valor_variable character varying(64) NOT NULL
);


SET search_path = public, pg_catalog;

--
-- TOC entry 141 (class 1259 OID 40368)
-- Name: actividad; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE actividad (
    codigo character varying(15) NOT NULL,
    nombre character varying(200),
    estado character varying(10) NOT NULL,
    fk_cargo character varying(15)
);


--
-- TOC entry 142 (class 1259 OID 40371)
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
-- TOC entry 143 (class 1259 OID 40375)
-- Name: adhonorem_ext; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE adhonorem_ext (
    fk_adhonorem character varying(15) NOT NULL,
    email character varying(150),
    telefono character varying(35)
);


--
-- TOC entry 144 (class 1259 OID 40378)
-- Name: autoridad; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE autoridad (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(100) NOT NULL,
    ape_materno character varying(100),
    sexo character varying(5),
    estado character varying(10) DEFAULT 'ACTIVO'::character varying,
    ini_gestion date DEFAULT ('now'::text)::date,
    fin_gestion date,
    fk_cargo character varying(15),
    titulo character varying(20),
    grado_firma character varying(20)
);


--
-- TOC entry 145 (class 1259 OID 40383)
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
-- TOC entry 146 (class 1259 OID 40389)
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
-- TOC entry 147 (class 1259 OID 40392)
-- Name: auxiliar_ext; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auxiliar_ext (
    fk_auxiliar character varying(15) NOT NULL,
    email character varying(150),
    telefono character varying(35)
);


--
-- TOC entry 148 (class 1259 OID 40395)
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
-- TOC entry 149 (class 1259 OID 40398)
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
-- TOC entry 150 (class 1259 OID 40401)
-- Name: car_adh; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE car_adh (
    codigo character varying(15) NOT NULL,
    gestion character varying(10) NOT NULL,
    fk_adhonorem character varying(15) NOT NULL,
    fk_cargo character varying(15) NOT NULL,
    fecha_mod date DEFAULT ('now'::text)::date,
    estado character varying(10)
);


--
-- TOC entry 151 (class 1259 OID 40405)
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
-- TOC entry 152 (class 1259 OID 40409)
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
-- TOC entry 153 (class 1259 OID 40413)
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
-- TOC entry 154 (class 1259 OID 40416)
-- Name: carta; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE carta (
    codigo character varying(15) NOT NULL,
    cod_archivo character varying(15),
    fecha date DEFAULT ('now'::text)::date,
    fk_estandarc character varying(15)
);


--
-- TOC entry 155 (class 1259 OID 40420)
-- Name: carta_dest; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE carta_dest (
    fk_docente character varying(15),
    fk_destinatario character varying(15),
    fk_carta character varying(15)
);


--
-- TOC entry 156 (class 1259 OID 40423)
-- Name: catalogo_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE catalogo_curso (
    codigo character varying(6) NOT NULL,
    curso character varying(100) NOT NULL,
    fk_categoria_curso character varying(6) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 157 (class 1259 OID 40427)
-- Name: categoria_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categoria_aux (
    codigo character varying(15) NOT NULL,
    interno character varying(10),
    titular character varying(10),
    fk_nombra_aux character varying(15)
);


--
-- TOC entry 158 (class 1259 OID 40430)
-- Name: categoria_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categoria_curso (
    codigo character varying(6) NOT NULL,
    nombre character varying(100) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying NOT NULL
);


--
-- TOC entry 159 (class 1259 OID 40434)
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
-- TOC entry 160 (class 1259 OID 40437)
-- Name: certificado; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE certificado (
    codigo character varying(15) NOT NULL,
    fecha_emis date DEFAULT ('now'::text)::date,
    fk_aux character varying(15),
    fk_autoridad character varying(15)
);


--
-- TOC entry 161 (class 1259 OID 40441)
-- Name: combo_box; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE combo_box (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character varying(10)
);


--
-- TOC entry 162 (class 1259 OID 40444)
-- Name: cprol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cprol (
    codigo character varying(9) NOT NULL,
    nombre character varying(35) NOT NULL,
    descripcion character varying(60),
    estado character varying(10) NOT NULL
);


--
-- TOC entry 163 (class 1259 OID 40447)
-- Name: cproles_usuario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cproles_usuario (
    fk_codigo_usr character varying(10) NOT NULL,
    fk_codigo_rol character varying(9) NOT NULL
);


--
-- TOC entry 164 (class 1259 OID 40450)
-- Name: cptarea; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cptarea (
    codigo character varying(9) NOT NULL,
    nombre character varying(35) NOT NULL,
    descripcion character varying(60),
    estado character varying(10) NOT NULL
);


--
-- TOC entry 165 (class 1259 OID 40453)
-- Name: cptareas_rol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cptareas_rol (
    fk_codigo_rol character varying(9) NOT NULL,
    fk_codigo_tarea character varying(9) NOT NULL
);


--
-- TOC entry 166 (class 1259 OID 40456)
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
    fk_catalogo_curso character varying(6)
);


--
-- TOC entry 167 (class 1259 OID 40459)
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
-- TOC entry 168 (class 1259 OID 40462)
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
-- TOC entry 169 (class 1259 OID 40465)
-- Name: dia_res; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dia_res (
    codigo character varying(6) NOT NULL,
    nombre character(10) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 170 (class 1259 OID 40468)
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
-- TOC entry 171 (class 1259 OID 40472)
-- Name: empresa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE empresa (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying
);


--
-- TOC entry 172 (class 1259 OID 40476)
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
-- TOC entry 173 (class 1259 OID 40480)
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
-- TOC entry 174 (class 1259 OID 40483)
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
-- TOC entry 175 (class 1259 OID 40486)
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
-- TOC entry 176 (class 1259 OID 40489)
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
-- TOC entry 177 (class 1259 OID 40492)
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
-- TOC entry 178 (class 1259 OID 40495)
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
-- TOC entry 179 (class 1259 OID 40498)
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
-- TOC entry 180 (class 1259 OID 40501)
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
-- TOC entry 181 (class 1259 OID 40504)
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
-- TOC entry 182 (class 1259 OID 40507)
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
-- TOC entry 183 (class 1259 OID 40510)
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
-- TOC entry 184 (class 1259 OID 40513)
-- Name: historico; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE historico (
    fecha date,
    gestion character varying(10),
    ges_creacion character varying(10)
);


--
-- TOC entry 185 (class 1259 OID 40516)
-- Name: horario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario (
    referencia character varying(10),
    dia character varying(10),
    hra_ini time without time zone,
    hra_fin time without time zone
);


--
-- TOC entry 186 (class 1259 OID 40519)
-- Name: horario_aux; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE horario_aux (
    codigo character varying(15) NOT NULL,
    dia character varying(20) NOT NULL,
    grupo character varying(2),
    aula character varying(5),
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
-- TOC entry 187 (class 1259 OID 40522)
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
-- TOC entry 188 (class 1259 OID 40525)
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
-- TOC entry 189 (class 1259 OID 40529)
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
-- TOC entry 190 (class 1259 OID 40533)
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
-- TOC entry 191 (class 1259 OID 40537)
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
-- TOC entry 192 (class 1259 OID 40541)
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
-- TOC entry 193 (class 1259 OID 40544)
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
-- TOC entry 194 (class 1259 OID 40547)
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
-- TOC entry 195 (class 1259 OID 40552)
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
-- TOC entry 196 (class 1259 OID 40556)
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
-- TOC entry 197 (class 1259 OID 40559)
-- Name: sec_codigo_materia_dicta; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sec_codigo_materia_dicta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 198 (class 1259 OID 40561)
-- Name: materia_dicta_sinonimo; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE materia_dicta_sinonimo (
    codigo integer DEFAULT nextval('sec_codigo_materia_dicta'::regclass) NOT NULL,
    materia character varying(255) NOT NULL,
    sismat character varying(255) NOT NULL,
    grupo character varying(255) NOT NULL,
    carrera character varying(255) NOT NULL,
    fk_materia_dicta character varying(255) NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 40565)
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
-- TOC entry 200 (class 1259 OID 40568)
-- Name: mes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mes (
    num character varying(20),
    nombre character varying(10)
);


--
-- TOC entry 201 (class 1259 OID 40571)
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
-- TOC entry 202 (class 1259 OID 40574)
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
-- TOC entry 203 (class 1259 OID 40577)
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
-- TOC entry 204 (class 1259 OID 40580)
-- Name: pga_diagrams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_diagrams (
    diagramname character varying(64) NOT NULL,
    diagramtables text,
    diagramlinks text
);


--
-- TOC entry 205 (class 1259 OID 40586)
-- Name: pga_forms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_forms (
    formname character varying(64) NOT NULL,
    formsource text
);


--
-- TOC entry 206 (class 1259 OID 40592)
-- Name: pga_graphs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_graphs (
    graphname character varying(64) NOT NULL,
    graphsource text,
    graphcode text
);


--
-- TOC entry 207 (class 1259 OID 40598)
-- Name: pga_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_images (
    imagename character varying(64) NOT NULL,
    imagesource text
);


--
-- TOC entry 208 (class 1259 OID 40604)
-- Name: pga_layout; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_layout (
    tablename character varying(64) NOT NULL,
    nrcols smallint,
    colnames text,
    colwidth text
);


--
-- TOC entry 209 (class 1259 OID 40610)
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
-- TOC entry 210 (class 1259 OID 40616)
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
-- TOC entry 211 (class 1259 OID 40622)
-- Name: pga_scripts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pga_scripts (
    scriptname character varying(64) NOT NULL,
    scriptsource text
);


--
-- TOC entry 212 (class 1259 OID 40628)
-- Name: plan; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plan (
    codigo character varying(15) NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo_sis character varying(25),
    fecha_ini date,
    fecha_fin date,
    estado character varying(10) NOT NULL,
    fk_carrera character varying(15)
);


--
-- TOC entry 213 (class 1259 OID 40631)
-- Name: plan_mat; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE plan_mat (
    codigo character varying(15) NOT NULL,
    fk_plan character varying(15),
    fk_materia character varying(15)
);


--
-- TOC entry 214 (class 1259 OID 40634)
-- Name: prerequisito; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prerequisito (
    fk_materia character varying(15),
    fk_pre_materia character varying(15)
);


--
-- TOC entry 215 (class 1259 OID 40637)
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
-- TOC entry 216 (class 1259 OID 40643)
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
    direccion character varying(50),
    ci character varying(100)
);


--
-- TOC entry 217 (class 1259 OID 40646)
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
-- TOC entry 218 (class 1259 OID 40650)
-- Name: rango_res; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rango_res (
    codigo character varying(6) NOT NULL,
    hora_ini character varying(50) NOT NULL,
    hora_fin character varying(50) NOT NULL,
    estado character varying(15) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 40653)
-- Name: remitente; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE remitente (
    fk_cargo character varying(15),
    fk_estandar character varying(15)
);


--
-- TOC entry 220 (class 1259 OID 40656)
-- Name: reserva; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reserva (
    codigo character varying(50) NOT NULL,
    asunto character varying(50) NOT NULL,
    fecha_ini date NOT NULL,
    fecha_fin date NOT NULL,
    cant_equi character varying(50) NOT NULL,
    responsable character varying(200),
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
-- TOC entry 221 (class 1259 OID 40659)
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
-- TOC entry 222 (class 1259 OID 40662)
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
-- TOC entry 223 (class 1259 OID 40665)
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
-- TOC entry 224 (class 1259 OID 40668)
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
-- TOC entry 225 (class 1259 OID 40671)
-- Name: sesion; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sesion (
    codigo character varying(15) NOT NULL,
    fk_usuario character varying(15) NOT NULL,
    fecha timestamp without time zone DEFAULT ('now'::text)::timestamp(6) with time zone
);


--
-- TOC entry 226 (class 1259 OID 40675)
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
-- TOC entry 227 (class 1259 OID 40678)
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
-- TOC entry 228 (class 1259 OID 40681)
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
-- TOC entry 229 (class 1259 OID 40684)
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
-- TOC entry 230 (class 1259 OID 40687)
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
-- TOC entry 231 (class 1259 OID 40690)
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
-- TOC entry 232 (class 1259 OID 40693)
-- Name: temp_control_segui; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_control_segui (
    fk_sesion character varying(15),
    cod_doc_aux character varying(15)
);


--
-- TOC entry 233 (class 1259 OID 40696)
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
-- TOC entry 234 (class 1259 OID 40699)
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
-- TOC entry 235 (class 1259 OID 40702)
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
-- TOC entry 236 (class 1259 OID 40705)
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
-- TOC entry 237 (class 1259 OID 40708)
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
-- TOC entry 238 (class 1259 OID 40711)
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
-- TOC entry 239 (class 1259 OID 40714)
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
-- TOC entry 240 (class 1259 OID 40717)
-- Name: temp_materias; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_materias (
    codigo character varying(15),
    nombre character varying(150),
    sigla character varying(30),
    tipo character varying(30)
);


--
-- TOC entry 241 (class 1259 OID 40720)
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
-- TOC entry 242 (class 1259 OID 40723)
-- Name: temp_rango; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_rango (
    hora time without time zone NOT NULL,
    rango character varying(10),
    fk_sesion character varying(15)
);


--
-- TOC entry 243 (class 1259 OID 40726)
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
-- TOC entry 244 (class 1259 OID 40729)
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
-- TOC entry 245 (class 1259 OID 40732)
-- Name: temp_tesista; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE temp_tesista (
    nombre character varying(100) NOT NULL,
    ape_paterno character varying(100) NOT NULL,
    ape_materno character varying(100),
    carrera character varying(50) NOT NULL
);


--
-- TOC entry 246 (class 1259 OID 40735)
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
-- TOC entry 247 (class 1259 OID 40738)
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
-- TOC entry 248 (class 1259 OID 40741)
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
-- TOC entry 249 (class 1259 OID 40744)
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
-- TOC entry 250 (class 1259 OID 40747)
-- Name: titulo_curso; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE titulo_curso (
    fk_titulo character varying(10) NOT NULL,
    fk_curso character varying(15) NOT NULL
);


--
-- TOC entry 251 (class 1259 OID 40750)
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
-- TOC entry 2591 (class 0 OID 41248)
-- Dependencies: 252
-- Data for Name: variable; Type: TABLE DATA; Schema: apoyo; Owner: -
--

INSERT INTO variable (id_variable, nombre_variable, valor_variable) VALUES (1, 'version', '1.2.r9.1');
INSERT INTO variable (id_variable, nombre_variable, valor_variable) VALUES (2, 'serial', '102091');


SET search_path = public, pg_catalog;

--
-- TOC entry 2480 (class 0 OID 40368)
-- Dependencies: 141
-- Data for Name: actividad; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2481 (class 0 OID 40371)
-- Dependencies: 142
-- Data for Name: adhonorem; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2482 (class 0 OID 40375)
-- Dependencies: 143
-- Data for Name: adhonorem_ext; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2483 (class 0 OID 40378)
-- Dependencies: 144
-- Data for Name: autoridad; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2484 (class 0 OID 40383)
-- Dependencies: 145
-- Data for Name: aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2485 (class 0 OID 40389)
-- Dependencies: 146
-- Data for Name: auxiliar; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000001', '', 'ALEX', 'ALVAREZ', 'GONZALES', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000002', '', 'EDGAR', 'ARELLANO', 'DELGADO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000003', '', 'BLADIMIR', 'ARIAS', 'MEJIA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000004', '', 'SHIRLEY VILMA', 'BALLON', 'MEDRANO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000005', '', 'RAUL', 'BELTRAN', 'GUTIERREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000007', '', 'LUCY', 'COPA', 'GERONIMO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000008', '', 'DAVID ALFREDO', 'DELGADILLO', 'COSSIO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000009', '', 'DAVID', 'FERNANDEZ', 'RAMOS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000010', '', 'EDGAR', 'FLORES', 'TORREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000011', '', 'ROXANA', 'GUILLEN', 'SALVADOR', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000012', '', 'DAVID', 'HERBAS', 'PEREZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000013', '', 'CELSO', 'HERBAS', 'COSSIO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000014', '', 'TITO', 'MEJIA', 'PAREDES', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000016', '', 'REMY', 'PEREZ', 'FUENTES', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000017', '', 'ORLANDO', 'RODRIGUEZ', 'ACUYA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000018', '', 'JUAN', 'RODRIGUEZ', 'MARTINEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000019', '', 'JANNETH', 'ROJAS', 'QUISPE', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000020', '', 'RENE', 'SAAVEDRA', 'VILLA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000022', '', 'DAVID ALFREDO', 'SOSSA', 'AGUIRRE', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000023', '', 'JUAN CARLOS', 'SOTO', 'MOREIRA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000024', '', 'EDGAR', 'VILLANUEVA', 'VILLARROEL', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000026', '', 'EDGAR', 'FLORES', 'FLORES', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000027', '', 'ROGER', 'FLORES', 'VARGAS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000028', '', 'HUGO', 'JIMENEZ', 'CLAROS', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000029', '', 'PAVEL', 'SEJAS', 'PAZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2007_000030', '', 'PABLO', 'SOLIZ', 'PANOZO', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000002', '', 'MANOLO', 'RODRIGUEZ', 'HEREDIA', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000003', '', 'ALINA', 'YNTURIAS', 'JIMENEZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000004', '', 'ARCENIO', 'CANAVIRI', 'CALLE', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000005', '', 'RAMIRO', 'TOTORA', 'VELIZ', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000006', '', 'SAUL S', 'FERNANDEZ', 'P', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000007', '', 'GABY', 'SALVATIERRA', 'R', 'AUXILIAR', 'ACTIVO');
INSERT INTO auxiliar (codigo, ci, nombre, ape_paterno, ape_materno, tipo, estado) VALUES ('AUX2008_000008', '', 'ZPRUEBA', 'PRUEBA', '', 'AUXILIAR', 'ACTIVO');


--
-- TOC entry 2486 (class 0 OID 40392)
-- Dependencies: 147
-- Data for Name: auxiliar_ext; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2487 (class 0 OID 40395)
-- Dependencies: 148
-- Data for Name: auxiliatura; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2488 (class 0 OID 40398)
-- Dependencies: 149
-- Data for Name: bibliografia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2489 (class 0 OID 40401)
-- Dependencies: 150
-- Data for Name: car_adh; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2490 (class 0 OID 40405)
-- Dependencies: 151
-- Data for Name: car_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000001', 'I/2008', 'AUX2008_000002', 'CAR0003', 'ACTIVO', '2008-06-04', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000002', 'I/2008', 'AUX2008_000003', 'CAR0003', 'ACTIVO', '2008-06-04', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000003', 'I/2008', 'AUX2008_000004', 'CAR0003', 'ACTIVO', '2008-06-05', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000004', 'I/2008', 'AUX2008_000005', 'CAR0003', 'ACTIVO', '2008-06-05', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000005', 'I/2008', 'AUX2008_000006', 'CAR0003', 'ACTIVO', '2008-06-05', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000006', 'I/2008', 'AUX2008_000007', 'CAR0003', 'ACTIVO', '2008-06-05', '8');
INSERT INTO car_aux (codigo, gestion, fk_auxiliar, fk_cargo, estado, fecha_mod, carga_horaria) VALUES ('CAX2008_000007', 'I/2008', 'AUX2008_000008', 'CAR0003', 'ACTIVO', '2008-09-24', '8');


--
-- TOC entry 2491 (class 0 OID 40409)
-- Dependencies: 152
-- Data for Name: cargo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0001', 'JEFE DE DEPARTAMENTO', 'AUTORIDAD', 'No Definido', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0002', 'DIRECTOR DE CARRERA', 'AUTORIDAD', 'No Definido', 'ACTIVO', NULL);
INSERT INTO cargo (codigo, nombre, tipo, carga_horaria, estado, fk_laboratorio) VALUES ('CAR0003', 'AUXILIAR DE PIZARRA', 'DOCENCIA', '8', 'ACTIVO', NULL);


--
-- TOC entry 2492 (class 0 OID 40413)
-- Dependencies: 153
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO carrera (codigo, nombre, sigla, facultad, depto) VALUES ('CAR0001', 'LIC. EN MATEMATICAS', 'MAT', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS');
INSERT INTO carrera (codigo, nombre, sigla, facultad, depto) VALUES ('CAR0002', 'ING. MATEMATICA', 'MAT', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS');


--
-- TOC entry 2493 (class 0 OID 40416)
-- Dependencies: 154
-- Data for Name: carta; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2494 (class 0 OID 40420)
-- Dependencies: 155
-- Data for Name: carta_dest; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2495 (class 0 OID 40423)
-- Dependencies: 156
-- Data for Name: catalogo_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2496 (class 0 OID 40427)
-- Dependencies: 157
-- Data for Name: categoria_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2497 (class 0 OID 40430)
-- Dependencies: 158
-- Data for Name: categoria_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2498 (class 0 OID 40434)
-- Dependencies: 159
-- Data for Name: categoria_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('000002', 'N', 'S', 'N', 'N', 'N', '000002');
INSERT INTO categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('000003', 'N', 'N', 'N', 'N', 'S', '000003');


--
-- TOC entry 2499 (class 0 OID 40437)
-- Dependencies: 160
-- Data for Name: certificado; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2500 (class 0 OID 40441)
-- Dependencies: 161
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
-- TOC entry 2501 (class 0 OID 40444)
-- Dependencies: 162
-- Data for Name: cprol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000001', 'Administrador laboratorios', 'Encargado de curso, auxiliares de laboratorio y certificados', 'ACTIVO');
INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000002', 'Secretaria', 'Encargada de nombramientos, seguimientos', 'ACTIVO');
INSERT INTO cprol (codigo, nombre, descripcion, estado) VALUES ('ROL000003', 'Administrador', 'admin', 'ACTIVO');


--
-- TOC entry 2502 (class 0 OID 40447)
-- Dependencies: 163
-- Data for Name: cproles_usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cproles_usuario (fk_codigo_usr, fk_codigo_rol) VALUES ('2005_0001', 'ROL000002');
INSERT INTO cproles_usuario (fk_codigo_usr, fk_codigo_rol) VALUES ('2004_0001', 'ROL000003');


--
-- TOC entry 2503 (class 0 OID 40450)
-- Dependencies: 164
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
INSERT INTO cptarea (codigo, nombre, descripcion, estado) VALUES ('TAR000060', 'AsignacionMateria', 'Administracion de asignacion de multiples nombres y materias', 'ACTIVO');


--
-- TOC entry 2504 (class 0 OID 40453)
-- Dependencies: 165
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
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000002', 'TAR000040');
INSERT INTO cptareas_rol (fk_codigo_rol, fk_codigo_tarea) VALUES ('ROL000003', 'TAR000060');


--
-- TOC entry 2505 (class 0 OID 40456)
-- Dependencies: 166
-- Data for Name: curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2506 (class 0 OID 40459)
-- Dependencies: 167
-- Data for Name: destinatario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2507 (class 0 OID 40462)
-- Dependencies: 168
-- Data for Name: detalle_reserva; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2508 (class 0 OID 40465)
-- Dependencies: 169
-- Data for Name: dia_res; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2509 (class 0 OID 40468)
-- Dependencies: 170
-- Data for Name: docente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0027', '', 'JORGE', 'ROCHA ', '', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0029', '', 'OSCAR', 'SALAZAR ', '', 'ACTIVO', 'ING EN MINAS', 'INGENIERO MINAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0034', '', 'ROBERTO', 'VALDIVIESO ', '', 'ACTIVO', 'ECONOMISTA', 'LICENCIADO ECONOM?A', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0035', '', 'LUIS', 'VILLARROEL ', '', 'ACTIVO', 'INDUSTRIAL', 'MGR.INDUSTRIAL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0001', '782191-', 'OSCAR', 'ANTEZANA', 'MENDOZA', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0039', '7654321-SCZ', 'JUAN', 'PEREZ', 'VALDEZ', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0040', '7654321-PAN', 'JUANCHO', 'PERES', 'LIZARAZU', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0003', '', 'JAVIER', 'CABALLERO', 'ESPINOZA', 'ACTIVO', 'AGRONOMO', 'INGENIERO AGRONOMO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0004', '', 'GERARDO', 'C?CERES', 'GARCIA', 'ACTIVO', 'ELECTRICO', 'INGENIERO EL?CTRICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0006', '', 'GUSTAVO', 'CANO', 'PRADO', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0007', '', 'ALVARO', 'CARRASCO', 'CALVO', 'ACTIVO', 'MATEMATICO', 'MGR.MATEMATICAS', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0008', '', 'RA?L', 'CATARI', 'RIOS', 'ACTIVO', 'ELECTRICO', 'INGENIERO EL?CTRICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0009', '', 'GUALBERTO', 'CUP?', 'CLEMENTE', 'ACTIVO', 'MATEMATICO', 'MGR.MATEMATICAS', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0010', '', 'HERN?N', 'FLORES', 'GARCIA', 'ACTIVO', 'MEC?NICO', 'INGENIERO MEC?NICO', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0012', '', 'CARLOS ESTEBAN', 'GONZALES', 'CASTELLON', 'ACTIVO', 'MATEMATICO', 'LICENCIADO MATEMATICAS', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0011', '', 'LUCIO', 'GONZALES', 'CARTAGENA', 'ACTIVO', 'QUIMICO', 'DR.QUIMICA', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0013', '', 'JULIO', 'GUZM?N', 'GUILLEN', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0014', '', 'MAURICIO', 'HOEPFNER', 'REYNOLDS', 'ACTIVO', 'QUIMICO', 'LICENCIADOQU?MICA', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0016', '', 'RUPERTO', 'LE?N', 'ROMERO', 'ACTIVO', 'MEC?NICO', 'INGENIERO MEC?NICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0015', '', 'DEMETRIO', 'JUCHANI', 'BAZUALDO', 'ACTIVO', 'MATEMATICO', 'LICENCIADO MATEMATICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0017', '', 'ROBERTO', 'MANCHEGO', 'CASTELLON', 'ACTIVO', 'INDUSTRIAL', 'INGENIERO INDUSTRIAL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0019', '', 'JULIO', 'MEDINA', 'GAMBOA', 'ACTIVO', 'MEC?NICO', 'INGENIERO MEC?NICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0020', '', 'MARTIN', 'MOYA', 'ALBARRACIN', 'ACTIVO', 'ECONOMISTA', 'LICENCIADO ECONOM?A', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0021', '', 'HANS', 'MULLER', 'SANTA CRUZ', 'ACTIVO', 'MATEMATICO', 'LICENCIADO EN MATEM?TICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0023', '', 'ROBERTO', 'OMONTE', 'OJALVO', 'ACTIVO', 'QUIMICO', 'INGENIERO QU?MICO', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0022', '', 'JOS? GIL', 'OMONTE', 'OJALVO', 'ACTIVO', 'QUIMICO', 'INGENIERO QU?MICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0024', '', 'SANTIAGO', 'RELOS', 'PACO', 'ACTIVO', 'MATEMATICO', 'MGR.MATEMATICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0026', '', 'MAURICIO', 'ROMERO', 'MERIDA', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0041', '', 'JUAN ANTONIO', 'RODRIGUEZ', 'SEJAS', 'ACTIVO', 'INGENIERO CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0028', '', 'RAMIRO', 'ROJAS', 'ZURITA', 'ACTIVO', 'ELECTRICO', 'INGENIERO EL?CTRICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0025', '', 'RA?L', 'ROMERO', 'ENCINAS', 'ACTIVO', 'ELECTRICO', 'INGENIERO ELECTRICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0042', '', 'MARTIN', 'SANCHEZ', 'ROCHA', 'ACTIVO', 'INGENIERO', 'INGENIERO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0030', '', 'GONZALO', 'SALINAS', 'PERICON', 'ACTIVO', 'MATEMATICO', 'LICENCIADO MATEMATEMATICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0031', '', 'JOS?', 'SORUCO', 'MAITA', 'ACTIVO', 'QUIMICO', 'INGENIERO QUIMICO', 'EXCLUSIVO');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0032', '', 'FIDEL', 'TABORGA', 'ACHA', 'ACTIVO', 'ECONOMISTA', 'LICENCIADO ECONOM?A', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0043', '', 'DARLONG', 'TAYLOR', 'TERRAZAS', 'ACTIVO', 'INGENIERO', 'INGENIERO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0033', '', 'JUAN', 'TERRAZAS', 'LOBO', 'ACTIVO', 'MEC?NICO', 'INGENIERO MEC?NICO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0044', '', 'WILSON', 'TRUJILLO', 'ARANIBAR', 'ACTIVO', 'LICENCIADO', 'LICENCIADO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0036', '', 'OSCAR', 'ZABALAGA', 'MONTA?O', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0038', '', 'ROBERTO', 'ZEGARRA', '', 'ACTIVO', 'MATEMATICO', 'MGR.MATEM?TICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0037', '', 'LUIS R.', 'ZEGARRA', 'DORADO', 'ACTIVO', 'MATEMATICO', 'MGR.MATEM?TICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0045', '', 'RIMER  MAURICIO', 'ZURITA', 'ORELLANA', 'ACTIVO', 'LICENCIADO', 'LICENCIADO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0005', '', 'ORLANDO', 'CAMACHO', 'QUIROGA', 'ACTIVO', 'CIVIL', 'INGENIERO CIVIL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0046', '', 'AMERICO', 'FIORILO', 'LOZADA', 'ACTIVO', 'LICENCIADO EN SISTEMAS', 'LICENCIADO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0047', '', 'EMIR', 'VARGAS', 'PEREDO', 'ACTIVO', 'INGENIERO INDUSTRIAL', 'LIC INUDSTRIAL', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0048', '', 'RUBEN', 'GARCIA', 'M', 'ACTIVO', 'INGIENIERO INDUSTRIAL', 'LICENDIATURA', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0050', '', 'ALEX', 'BUSTILLOS', '', 'ACTIVO', 'INGENIERO ELECTRICO', 'INGENIERO', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0049', '', 'RONALD', 'PATI?O', 'TITO', 'ACTIVO', 'INGENIERO INDUSTRIAL', 'LICENCIATURA', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0018', '', 'AMILCAR SAUL', 'MARTINEZ', 'MAIDA', 'ACTIVO', 'MATEMATICO', 'LICENCIADO MATEM?TICAS', 'PARCIAL');
INSERT INTO docente (codigo, ci, nombre, ape_paterno, ape_materno, estado, diploma, titulo, tiempo) VALUES ('DOC0051', '', 'ALFREDO', 'DELGADILLO', 'COSSIO', 'ACTIVO', 'INGENIERO INDUSTRIAL', 'ING', 'EXCLUSIVO');


--
-- TOC entry 2510 (class 0 OID 40472)
-- Dependencies: 171
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2511 (class 0 OID 40476)
-- Dependencies: 172
-- Data for Name: estandarc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2512 (class 0 OID 40480)
-- Dependencies: 173
-- Data for Name: gestion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('1', 'I/2005', '2005-03-01', '2005-08-15', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('2', 'I/2006', '2006-01-31', '2006-06-30', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('3', 'II/2006', '2006-06-28', '2006-12-20', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('4', 'I/2007', '2007-03-01', '2007-07-20', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('5', 'II/2007', '2007-09-13', '2008-02-10', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('6', 'I/2008', '2008-02-13', '2008-07-04', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('7', 'I/2012', '2012-01-16', '2012-06-14', 'INACTIVO');
INSERT INTO gestion (codigo, gestion, fecha_ini, fecha_fin, estado) VALUES ('8', 'I/2013', '2013-02-07', '2013-07-07', 'ACTIVO');


--
-- TOC entry 2513 (class 0 OID 40483)
-- Dependencies: 174
-- Data for Name: hist_auxiliatura; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2514 (class 0 OID 40486)
-- Dependencies: 175
-- Data for Name: hist_categoria_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2008_000002', 'N', 'S', 'N', 'N', 'N', 'I/2008_000002');
INSERT INTO hist_categoria_doc (codigo, interno, invitado, asistentea, adjuntob, catedraticoc, fk_nombra_doc) VALUES ('I/2008_000003', 'N', 'N', 'N', 'N', 'S', 'I/2008_000003');


--
-- TOC entry 2515 (class 0 OID 40489)
-- Dependencies: 176
-- Data for Name: hist_horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2516 (class 0 OID 40492)
-- Dependencies: 177
-- Data for Name: hist_horario_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2007_2', 'Jueves', '1', '673', 0, '06:45:00', '08:15:00', 'I/2007', '17', '19', '2008048', 'I/2007_2');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2007_3', 'Sabado', '1', '654', 0, '08:15:00', '09:45:00', 'I/2007', '3', '5', '2008048', 'I/2007_2');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2007_4', 'Lunes', '9', '624', 0, '08:15:00', '09:45:00', 'I/2007', '3', '5', '2008054', 'I/2007_3');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2007_5', 'Viernes', '9', '624', 0, '02:15:00', '03:45:00', 'I/2007', '11', '13', '2008054', 'I/2007_3');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_213', 'Lunes', '2', '607', 0, '08:15:00', '09:45:00', 'I/2008', '3', '5', '2008019', 'I/2008_3');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_214', 'Miercoles', '2', '623', 0, '09:45:00', '11:15:00', 'I/2008', '5', '7', '2008019', 'I/2008_3');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_215', 'Lunes', '1', '622', 0, '09:45:00', '11:15:00', 'I/2008', '5', '7', '2008022', 'I/2008_2');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_216', 'Viernes', '1', '607', 0, '08:15:00', '09:45:00', 'I/2008', '3', '5', '2008022', 'I/2008_2');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_217', 'Miercoles', '1', '622', 0, '08:15:00', '09:45:00', 'I/2008', '3', '5', '2008063', 'I/2008_4');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_218', 'Jueves', '1', '622', 0, '08:15:00', '09:45:00', 'I/2008', '3', '5', '2008063', 'I/2008_4');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_219', 'Martes', '1', '607', 0, '08:15:00', '09:45:00', 'I/2008', '3', '5', '2008057', 'I/2008_5');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_220', 'Jueves', '1', '624', 0, '09:45:00', '11:15:00', 'I/2008', '5', '7', '2008057', 'I/2008_5');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_221', 'Sabado', '1', '623', 0, '08:15:00', '09:45:00', 'I/2008', '3', '5', '2008057', 'I/2008_5');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_222', 'Lunes', '1', '641', 0, '18:45:00', '20:15:00', 'I/2008', '17', '19', '2008060', 'I/2008_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_223', 'Martes', '1', '660', 0, '12:45:00', '14:15:00', 'I/2008', '9', '11', '2008060', 'I/2008_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_224', 'Jueves', '1', '661', 0, '18:45:00', '20:15:00', 'I/2008', '17', '19', '2008060', 'I/2008_6');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_225', 'Lunes', '1', '617', 0, '06:45:00', '08:15:00', 'I/2008', '1', '3', '2008013', 'I/2008_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_226', 'Martes', '1', '623', 0, '14:15:00', '15:45:00', 'I/2008', '11', '13', '2008013', 'I/2008_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_227', 'Viernes', '1', '617', 0, '06:45:00', '08:15:00', 'I/2008', '1', '3', '2008013', 'I/2008_7');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_231', 'Miercoles', '2', '624', 0, '06:45:00', '08:15:00', 'I/2008', '1', '3', '2008013', 'I/2008_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_232', 'Jueves', '2', '651', 0, '14:15:00', '15:45:00', 'I/2008', '11', '13', '2008013', 'I/2008_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2008_233', 'Sabado', '2', '607', 0, '06:45:00', '08:15:00', 'I/2008', '1', '3', '2008013', 'I/2008_9');
INSERT INTO hist_horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, rango_ini, rango_fin, fk_materia_dicta, fk_materia_dicta1) VALUES ('I/2012_517', 'Martes', '2B', '692C', 0, '08:15:00', '09:45:00', 'I/2012', '3', '5', '2008054', 'I/2012_135');


--
-- TOC entry 2517 (class 0 OID 40495)
-- Dependencies: 178
-- Data for Name: hist_materia_dicta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2008_3', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'I/2008', 0, 16, 'I/2008_000002', 'I/2008_000003', 'MAT2008_000002');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2008_2', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'I/2008', 0, 16, 'I/2008_000002', 'I/2008_000003', 'MAT2008_000004');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2008_4', 'ALGEBRA LINEAL', '2008063', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'I/2008', 0, 16, 'I/2008_000002', 'I/2008_000003', 'MAT2008_000060');
INSERT INTO hist_materia_dicta (codigo, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia) VALUES ('I/2008_5', 'MATEMATICA DISCRETA', '2008057', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'I/2008', 0, 24, 'I/2008_000002', 'I/2008_000003', 'MAT2008_000010');


--
-- TOC entry 2518 (class 0 OID 40498)
-- Dependencies: 179
-- Data for Name: hist_materia_labo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2519 (class 0 OID 40501)
-- Dependencies: 180
-- Data for Name: hist_nombra_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2520 (class 0 OID 40504)
-- Dependencies: 181
-- Data for Name: hist_nombra_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2008_000002', 'BUSTILLOS  ALEX', 'LIC. EN MATEMATICAS', 'MATEMATICAS', 'CIENCIAS Y TECNOLOG?A', 'INGENIERO ELECTRICO', 'INGENIERO', 'PARCIAL', '2008-07-10', '2008-07-10', 'UN SEMESTRE', 'I/2008', 4, 'DOC0050');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2008_000003', 'CABALLERO ESPINOZA JAVIER', 'LIC. EN MATEMATICAS', 'MATEMATICAS', 'CIENCIAS Y TECNOLOG?A', 'AGRONOMO', 'INGENIERO AGRONOMO', 'PARCIAL', '2008-02-06', '2008-03-11', 'UN SEMESTRE', 'I/2008', 18, 'DOC0003');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2012_000002', 'BUSTILLOS  ALEX', 'LIC. EN MATEMATICAS', 'MATEMATICAS', 'CIENCIAS Y TECNOLOG?A', 'INGENIERO ELECTRICO', 'INGENIERO', 'PARCIAL', '2008-07-10', '2008-07-10', 'UN SEMESTRE', 'I/2008', 4, 'DOC0050');
INSERT INTO hist_nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, fk_docente) VALUES ('I/2012_000003', 'CABALLERO ESPINOZA JAVIER', 'LIC. EN MATEMATICAS', 'MATEMATICAS', 'CIENCIAS Y TECNOLOG?A', 'AGRONOMO', 'INGENIERO AGRONOMO', 'PARCIAL', '2008-02-06', '2008-03-11', 'UN SEMESTRE', 'I/2008', 18, 'DOC0003');


--
-- TOC entry 2521 (class 0 OID 40507)
-- Dependencies: 182
-- Data for Name: hist_segui_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2522 (class 0 OID 40510)
-- Dependencies: 183
-- Data for Name: hist_segui_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2008_000002', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '32', '', '0', 'I/2008', 'PARCIAL', 'DOC0003');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2008_000003', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2008', 'PARCIAL', 'DOC0004');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2008_000004', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '72', '', '0', 'I/2008', 'PARCIAL', 'DOC0005');
INSERT INTO hist_segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente) VALUES ('I/2012_00043', '', 'N', 'N', 'N', 'N', '', '1', '', '', '', '1', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '160', '', '152', 'I/2012', 'EXCLUSIVO', 'DOC0051');


--
-- TOC entry 2523 (class 0 OID 40513)
-- Dependencies: 184
-- Data for Name: historico; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2007-09-13', 'I/2007', 'II/2007');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2008-02-13', 'II/2007', 'I/2008');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2012-02-27', 'I/2008', 'I/2012');
INSERT INTO historico (fecha, gestion, ges_creacion) VALUES ('2013-05-02', 'I/2012', 'I/2013');


--
-- TOC entry 2524 (class 0 OID 40516)
-- Dependencies: 185
-- Data for Name: horario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2525 (class 0 OID 40519)
-- Dependencies: 186
-- Data for Name: horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('4', 'Jueves', '3', '624', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008058', '', '2008058', '4');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('5', 'Viernes', '2', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008066', '', '2008066', '5');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('6', 'Viernes', '3', '625B', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008061', '', '2008061', '6');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('7', 'Viernes', '2', '624', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008061', '', '2008061', '7');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('8', 'Martes', '1', '651', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008058', '', '2008058', '8');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('9', 'Viernes', '2', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008058', '', '2008058', '9');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('10', 'Martes', '1', '655', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008160', '', '2008160', '10');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('11', 'Lunes', '6', '612', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '11');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('12', 'Martes', '3', '651', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008059', '', '2008059', '12');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('13', 'Martes', '2', '641', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008029', '', '2008029', '13');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('14', 'Lunes', '5', '622', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '14');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('15', 'Miercoles', '6', '617', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '15');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('16', 'Miercoles', '6', '660', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '16');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('17', 'Lunes', '1', '617B', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008059', '', '2008059', '17');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('24', 'Martes', '4', '673', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '24');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('25', 'Martes', '10', '655', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '25');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('26', 'Viernes', '7', '642', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '26');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('27', 'Miercoles', '2', '612', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008238', '', '2008238', '27');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('28', 'Viernes', '4', '623', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '28');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('29', 'Miercoles', '4', '607', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '29');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('30', 'Sabado', '3', '673', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '30');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('31', 'Sabado', '1', '623', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008014', '', '2008014', '31');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('32', 'Miercoles', '3', '641', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '32');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('33', 'Sabado', '9', '661', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '33');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('34', 'Martes', '3', '651', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008058', '', '2008058', '34');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('35', 'Martes', '1', '654', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008237', '', '2008237', '35');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('36', 'Martes', '3', '622', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '36');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('37', 'Miercoles', '4', '641', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '37');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('42', 'Jueves', '11', '642', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '42');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('43', 'Viernes', '2', '673', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '43');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('44', 'Jueves', '2', '623', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '44');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('45', 'Lunes', '5', '654', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '45');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('46', 'Miercoles', '7', '651', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '46');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('51', 'Viernes', '18', '617B', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '47');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('49', 'Lunes', '6', '651', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '50');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('50', 'Miercoles', '1', '654', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008056', '', '2008056', '50');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('47', 'Miercoles', '12', '673', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '48');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('52', 'Viernes', '18', '617B', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '48');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('53', 'Jueves', '3', '617', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '51');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('21', 'Viernes', '5', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '52');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('22', 'Lunes', '1', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '52');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('54', 'Martes', '2', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '52');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('55', 'Sabado', '16', '617C', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '52');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('2', 'Martes', '2', '654', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008059', '', '2008059', '3');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('3', 'Martes', '1', '654', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008059', '', '2008059', '3');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('23', 'Sabado', '1', '651', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '23');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('72', 'Miercoles', '1', '623', 0, '06:45:00', '07:30:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '20');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('68', 'Viernes', '5', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '21');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('69', 'Viernes', '1', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '21');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('70', 'Viernes', '5', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '21');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('71', 'Viernes', '1', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '21');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('39', 'Jueves', '8', '617C', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '41');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('40', 'Jueves', '9', '622', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '41');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('41', 'Sabado', '1', '617C', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '', '2008054', '41');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('73', 'Miercoles', '2', '673', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '38');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('38', 'Miercoles', '2', '673', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '18');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('57', 'Viernes', '8', '692C', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '18');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('74', 'Martes', '7', '660', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '18');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('62', 'Viernes', '8', '625B', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '19');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('64', 'Viernes', '8', '625B', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '19');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('66', 'Viernes', '8', '625B', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '19');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('80', 'Lunes', '1', '969', 0, '08:00:00', '09:30:00', 'I/2008', 'INACTIVO', '2008084', '', '2008084', '53');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('90', 'Martes', '1', '623', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008098', '', '2008098', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('61', 'Viernes', '8', '692C', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '55');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('75', 'Lunes', '1', '632', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '55');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('91', 'Lunes', '1', '690', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008070', '', '2008070', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('95', 'Jueves', '1', '679', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('96', 'Jueves', '1', '679', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('97', 'Jueves', '1', '660', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('98', 'Jueves', '1', '660', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008022', '', '2008022', '56');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('99', 'Viernes', '1', '660', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '57');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('100', 'Viernes', '1', '660', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '57');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('101', 'Viernes', '1', '678', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '57');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('102', 'Lunes', '1', '660', 0, '11:45:00', '12:45:00', 'I/2008', 'INACTIVO', '2008239', '', '2008239', '54');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('103', 'Jueves', '1', '623', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008239', '', '2008239', '54');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('104', 'Jueves', '1', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008239', '', '2008239', '54');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('105', 'Jueves', '1', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008239', '', '2008239', '54');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('106', 'Lunes', '1', '654', 0, '06:45:00', '10:00:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '57');
INSERT INTO horario_aux (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, sigla_lab, fk_materia_labo, fk_materia_dicta, fk_materia_labo1) VALUES ('107', 'Lunes', '1', '654', 0, '06:45:00', '10:00:00', 'I/2008', 'INACTIVO', '2008019', '', '2008019', '57');


--
-- TOC entry 2526 (class 0 OID 40522)
-- Dependencies: 187
-- Data for Name: horario_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('213', 'Lunes', '2', '607', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '3');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('214', 'Miercoles', '2', '623', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '3');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('215', 'Lunes', '1', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008022', '2');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('216', 'Viernes', '1', '607', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008022', '2');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('217', 'Miercoles', '1', '622', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008063', '4');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('218', 'Jueves', '1', '622', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008063', '4');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('219', 'Martes', '1', '607', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008057', '5');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('220', 'Jueves', '1', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008057', '5');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('221', 'Sabado', '1', '623', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008057', '5');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('222', 'Lunes', '1', '641', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008060', '6');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('223', 'Martes', '1', '660', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008060', '6');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('224', 'Jueves', '1', '661', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008060', '6');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('275', 'Miercoles', '1', '607', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '29');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('276', 'Jueves', '1', '623', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '29');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('310', 'Lunes', '1', '617C', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008140', '45');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('311', 'Martes', '1', '607', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008140', '45');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('312', 'Lunes', '1', '625D', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008019', '46');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('313', 'Sabado', '1', '607', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '46');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('314', 'Lunes', '2', '651', 0, '20:15:00', '21:45:00', 'I/2008', 'INACTIVO', '2008238', '47');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('315', 'Martes', '2', '625B', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008238', '47');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('324', 'Jueves', '1', '612', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008043', '51');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('325', 'Viernes', '1', '622', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008043', '51');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('326', 'Sabado', '1', '661', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008043', '51');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('321', 'Martes', '2', '612', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008043', '50');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('322', 'Viernes', '2', '642', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008043', '50');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('323', 'Sabado', '2', '661', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008043', '50');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('316', 'Lunes', '9', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '48');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('317', 'Viernes', '9', '624', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008054', '48');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('318', 'Lunes', '2', '622', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008060', '49');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('319', 'Jueves', '2', '646', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008060', '49');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('320', 'Viernes', '2', '641', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008060', '49');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('327', 'Lunes', '1', '617C', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008075', '52');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('328', 'Miercoles', '1', '617B', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008075', '52');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('329', 'Jueves', '1', '661', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008075', '52');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('330', 'Martes', '3', '617', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008022', '53');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('331', 'Miercoles', '3', '622', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008022', '53');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('332', 'Martes', '8', '624', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008019', '54');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('333', 'Jueves', '8', '673', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008019', '54');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('334', 'Lunes', '1', '657', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008239', '55');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('335', 'Martes', '1', '662', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008239', '55');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('336', 'Miercoles', '1', '625C', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008239', '55');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('337', 'Lunes', '11', '651', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008019', '56');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('338', 'Martes', '11', '624', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008019', '56');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('339', 'Lunes', '7', '617', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008054', '57');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('340', 'Jueves', '7', '623', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008054', '57');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('341', 'Viernes', '7', '612', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008054', '57');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('349', 'Viernes', '1', '622', 0, '20:15:00', '21:45:00', 'I/2008', 'INACTIVO', '2008059', '61');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('350', 'Sabado', '1', '661', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008059', '61');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('347', 'Miercoles', '2', '607', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008059', '60');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('348', 'Sabado', '2', '623', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008059', '60');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('342', 'Lunes', '3', '607', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008059', '58');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('343', 'Viernes', '3', '623', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008059', '58');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('344', 'Lunes', '1', '624', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008061', '59');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('345', 'Martes', '1', '612', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008061', '59');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('346', 'Viernes', '1', '622', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008061', '59');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('241', 'Lunes', '2', '673', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008057', '13');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('351', 'Martes', '5', '673', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008029', '62');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('352', 'Miercoles', '5', '673', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008029', '62');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('353', 'Lunes', '7', '623', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008022', '63');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('354', 'Martes', '7', '661', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008022', '63');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('355', 'Viernes', '7', '651', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008022', '63');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('356', 'Lunes', '6', '624', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008022', '64');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('357', 'Martes', '6', '641', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008022', '64');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('358', 'Martes', '4', '623', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008022', '65');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('359', 'Jueves', '4', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008022', '65');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('360', 'Jueves', '4', '623', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008058', '66');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('361', 'Martes', '4', '607', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008058', '66');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('362', 'Jueves', '1', '617B', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008160', '68');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('363', 'Viernes', '1', '625C', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008160', '68');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('364', 'Lunes', '1', '690', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008082', '70');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('365', 'Jueves', '1', '617A', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008082', '70');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('370', 'Martes', '1', '690', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008087', '73');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('371', 'Jueves', '1', '690', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008087', '73');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('366', 'Lunes', '1', '607', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008058', '71');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('367', 'Miercoles', '1', '607', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008058', '71');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('368', 'Martes', '2', '623', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008058', '72');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('369', 'Jueves', '2', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008058', '72');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('372', 'Martes', '1', '675', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008131', '74');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('373', 'Viernes', '1', '690', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008131', '74');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('374', 'Miercoles', '1', '607', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008091', '75');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('375', 'Lunes', '1', '690', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008091', '75');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('376', 'Sabado', '1', '691', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008091', '75');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('377', 'Lunes', '8', '623', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '76');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('378', 'Viernes', '8', '673', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '76');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('379', 'Lunes', '5', '624', 0, '20:15:00', '21:45:00', 'I/2008', 'INACTIVO', '2008059', '77');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('380', 'Jueves', '5', '641', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008059', '77');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('381', 'Sabado', '5', '622', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008059', '77');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('382', 'Martes', '1', '612', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '78');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('383', 'Sabado', '1', '622', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '78');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('384', 'Jueves', '3', '612', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '79');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('385', 'Viernes', '3', '654', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '79');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('386', 'Martes', '3', '623', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '79');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('387', 'Lunes', '9', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '80');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('388', 'Jueves', '9', '651', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '80');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('389', 'Sabado', '9', '660', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '80');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('390', 'Lunes', '1', '680', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008080', '81');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('391', 'Sabado', '1', '654', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008080', '81');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('394', 'Jueves', '3', '654', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008054', '83');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('395', 'Sabado', '3', '624', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008054', '83');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('392', 'Martes', '4', '625C', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008056', '82');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('393', 'Sabado', '4', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '82');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('396', 'Miercoles', '1', '690', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008110', '84');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('397', 'Viernes', '1', '617C', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008110', '84');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('401', 'Jueves', '14', '607', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '86');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('402', 'Lunes', '14', '607', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '86');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('403', 'Jueves', '14', '654', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008054', '86');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('404', 'Martes', '2', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '87');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('405', 'Jueves', '2', '617', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '87');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('406', 'Martes', '10', '623', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008019', '88');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('407', 'Miercoles', '10', '651', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '88');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('408', 'Viernes', '10', '641', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '88');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('409', 'Lunes', '11', '622', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '89');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('410', 'Miercoles', '11', '655', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '89');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('411', 'Viernes', '11', '673', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '89');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('412', 'Martes', '1', '654', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008024', '90');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('413', 'Jueves', '1', '617C', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008024', '90');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('414', 'Viernes', '1', '622', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008024', '90');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('415', 'Martes', '2', '655', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008014', '91');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('416', 'Jueves', '2', '617B', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008014', '91');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('417', 'Viernes', '2', '617C', 0, '20:15:00', '21:45:00', 'I/2008', 'INACTIVO', '2008014', '91');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('442', 'Jueves', '1', '623', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008237', '103');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('443', 'Viernes', '1', '622', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008237', '103');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('439', 'Miercoles', '1', '617C', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008161', '102');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('440', 'Jueves', '1', '652', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008161', '102');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('441', 'Viernes', '1', '617A', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008161', '102');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('444', 'Martes', '17', '673', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008054', '104');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('445', 'Miercoles', '17', '682', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008054', '104');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('432', 'Lunes', '3', '680', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008061', '99');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('433', 'Jueves', '3', '682', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008061', '99');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('436', 'Lunes', '4', '612', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008029', '101');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('437', 'Viernes', '4', '673', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008029', '101');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('438', 'Viernes', '4', '623', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008029', '101');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('434', 'Lunes', '8', '623', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008022', '100');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('435', 'Martes', '8', '643', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008022', '100');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('446', 'Lunes', '7', '612', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '105');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('447', 'Jueves', '7', '655', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008019', '105');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('448', 'Lunes', '2', '654', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008019', '106');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('449', 'Viernes', '2', '654', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008019', '106');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('450', 'Sabado', '2', '617B', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '106');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('453', 'Lunes', '1', '645', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008063', '108');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('454', 'Martes', '1', '625C', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008063', '108');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('455', 'Jueves', '1', '617B', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008063', '108');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('469', 'Lunes', '1', '617', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008070', '115');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('470', 'Miercoles', '1', '617B', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008070', '115');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('471', 'Jueves', '1', '660', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008070', '115');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('460', 'Lunes', '12', '673', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '111');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('461', 'Viernes', '12', '654', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '111');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('466', 'Martes', '1', '642', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008241', '114');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('467', 'Miercoles', '1', '661', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008241', '114');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('468', 'Viernes', '1', '661', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008241', '114');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('456', 'Viernes', '4', '617', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008059', '109');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('457', 'Martes', '4', '624', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008059', '109');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('458', 'Lunes', '2', '623', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008061', '110');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('459', 'Jueves', '2', '612', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008061', '110');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('462', 'Lunes', '1', '660', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008081', '112');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('463', 'Jueves', '1', '655', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008081', '112');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('464', 'Martes', '2', '656', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008067', '113');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('465', 'Viernes', '2', '636', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008067', '113');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('472', 'Miercoles', '5', '617', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008019', '116');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('473', 'Viernes', '5', '617', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008019', '116');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('474', 'Miercoles', '7', '673', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008056', '117');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('475', 'Jueves', '7', '625A', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008056', '117');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('476', 'Lunes', '3', '617C', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008022', '118');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('477', 'Martes', '3', '607', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008022', '118');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('478', 'Miercoles', '3', '642', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008022', '118');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('479', 'Lunes', '1', '622', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008238', '119');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('480', 'Martes', '1', '624', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008238', '119');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('481', 'Jueves', '1', '624', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008238', '119');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('482', 'Miercoles', '6', '607', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008056', '120');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('483', 'Jueves', '6', '612', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008056', '120');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('484', 'Miercoles', '2', '641', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008029', '121');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('485', 'Jueves', '2', '641', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008029', '121');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('486', 'Martes', '1', '656', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008067', '122');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('487', 'Jueves', '1', '655', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008067', '122');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('488', 'Viernes', '1', '661', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008067', '122');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('498', 'Martes', '1', '655', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008098', '128');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('499', 'Jueves', '1', '617A', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008098', '128');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('500', 'Jueves', '1', '675', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008084', '129');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('501', 'Viernes', '1', '690', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008084', '129');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('502', 'Jueves', '1', '625C', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008079', '130');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('503', 'Viernes', '1', '693C', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008079', '130');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('504', 'Miercoles', '1', '656', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008019', '131');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('505', 'Viernes', '1', '656', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008019', '131');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('511', 'Miercoles', '5', '624', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '134');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('512', 'Jueves', '5', '654', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '134');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('225', 'Lunes', '1', '617', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008013', '7');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('226', 'Martes', '1', '623', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008013', '7');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('227', 'Viernes', '1', '617', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008013', '7');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('231', 'Miercoles', '2', '624', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008013', '9');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('232', 'Jueves', '2', '651', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008013', '9');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('233', 'Sabado', '2', '607', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008013', '9');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('228', 'Lunes', '3', '617b', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008014', '8');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('229', 'Martes', '3', '617B', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008014', '8');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('230', 'Viernes', '3', '651', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008014', '8');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('234', 'Martes', '9', '612', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '10');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('235', 'Jueves', '9', '622', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '10');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('260', 'Miercoles', '2', '612', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008054', '20');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('261', 'Viernes', '2', '673', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008054', '20');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('255', 'Martes', '3', '641', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '18');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('256', 'Miercoles', '3', '641', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '18');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('254', 'Sabado', '3', '622', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008056', '18');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('251', 'Lunes', '7', '622', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008056', '17');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('252', 'Martes', '7', '607', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008056', '17');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('253', 'Miercoles', '7', '642', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008056', '17');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('257', 'Lunes', '12', '642', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '19');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('258', 'Jueves', '12', '612', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '19');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('259', 'Viernes', '12', '673', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008019', '19');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('279', 'Martes', '1', '624', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '31');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('280', 'Jueves', '1', '612', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '31');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('286', 'Jueves', '6', '625A', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '35');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('287', 'Viernes', '6', '654', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008056', '35');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('281', 'Miercoles', '8', '617C', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '32');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('282', 'Viernes', '8', '654', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '32');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('283', 'Sabado', '8', '622', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '32');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('284', 'Miercoles', '3', '654', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008058', '33');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('285', 'Viernes', '3', '661', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008058', '33');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('277', 'Lunes', '5', '612', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '30');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('278', 'Jueves', '5', '612', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '30');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('506', 'Jueves', '1', '673', 0, '18:45:00', '20:15:00', 'I/2008', 'INACTIVO', '2008061', '132');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('507', 'Sabado', '1', '654', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008061', '132');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('306', 'Lunes', '6', '673', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '43');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('307', 'Martes', '6', '617', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '43');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('308', 'Miercoles', '10', '673', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '44');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('309', 'Jueves', '10', '623', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008054', '44');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('288', 'Lunes', '16', '625B', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '36');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('289', 'Jueves', '16', '641', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '36');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('290', 'Martes', '18', '680', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008054', '37');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('291', 'Jueves', '18', '617B', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008054', '37');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('298', 'Viernes', '3', '625D', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '40');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('297', 'Martes', '3', '645', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '40');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('292', 'Martes', '1', '625C', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008078', '38');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('293', 'Miercoles', '1', '632', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008078', '38');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('294', 'Viernes', '1', '632', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008078', '38');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('295', 'Martes', '2', '617B', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008237', '39');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('299', 'Miercoles', '2', '651', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008237', '39');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('300', 'Lunes', '3', '655', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008060', '41');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('301', 'Miercoles', '3', '655', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008060', '41');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('302', 'Jueves', '3', '617', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008060', '41');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('303', 'Lunes', '1', '607', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008060', '42');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('304', 'Miercoles', '1', '624', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008060', '42');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('305', 'Viernes', '1', '617', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008060', '42');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('425', 'Martes', '15', '625C', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008054', '95');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('426', 'Viernes', '15', '625C', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008054', '95');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('423', 'Martes', '4', '624', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008054', '94');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('424', 'Viernes', '4', '612', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008054', '94');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('427', 'Martes', '2', '607', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008056', '96');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('428', 'Miercoles', '2', '641', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008056', '96');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('429', 'Jueves', '2', '641', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008056', '96');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('430', 'Miercoles', '3', '623', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008058', '97');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('431', 'Viernes', '3', '660', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008058', '97');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('418', 'Lunes', '5', '654', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008058', '92');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('419', 'Martes', '5', '642', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008058', '92');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('420', 'Miercoles', '5', '654', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008058', '92');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('421', 'Lunes', '6', '654', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008019', '93');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('422', 'Viernes', '6', '651', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '93');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('398', 'Lunes', '1', '660', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008029', '85');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('399', 'Viernes', '1', '625A', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008029', '85');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('400', 'Sabado', '1', '625A', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008029', '85');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('497', 'Miercoles', '1', '690', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008123', '127');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('489', 'Lunes', '1', '690', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008096', '123');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('490', 'Viernes', '1', '691', 0, '12:45:00', '14:15:00', 'I/2008', 'INACTIVO', '2008096', '123');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('491', 'Lunes', '1', '690', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008095', '124');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('492', 'Viernes', '1', '690', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008095', '124');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('493', 'Martes', '1', '690', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008023', '125');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('494', 'Jueves', '1', '690', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008023', '125');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('495', 'Martes', '1', '690', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008085', '126');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('496', 'Jueves', '1', '690', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008085', '126');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('508', 'Lunes', '2', '654', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008019', '133');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('510', 'Viernes', '2', '651', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008019', '133');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('513', 'Miercoles', '2', '651', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008019', '133');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('236', 'Lunes', '2', '655', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008060', '11');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('237', 'Martes', '2', '617C', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008060', '11');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('238', 'Viernes', '2', '617C', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008060', '11');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('249', 'Miercoles', '1', '656', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008242', '16');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('250', 'Jueves', '1', '617A', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008242', '16');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('247', 'Martes', '1', '656', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008086', '15');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('248', 'Miercoles', '1', '646', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008086', '15');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('242', 'Jueves', '2', '625C', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008057', '13');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('243', 'Viernes', '2', '641', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008057', '13');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('244', 'Martes', '1', '673', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008157', '14');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('245', 'Jueves', '1', '624', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008157', '14');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('246', 'Viernes', '1', '673', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008157', '14');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('239', 'Lunes', '7', '625C', 0, '09:45:00', '11:15:00', 'I/2008', 'INACTIVO', '2008056', '12');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('240', 'Jueves', '7', '973', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008056', '12');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('268', 'Martes', '1', '617', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008014', '24');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('269', 'Miercoles', '1', '617', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008014', '24');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('266', 'Lunes', '1', '655', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008090', '23');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('267', 'Viernes', '1', '655', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008090', '23');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('270', 'Miercoles', '1', '656', 0, '17:15:00', '18:45:00', 'I/2008', 'INACTIVO', '2008100', '25');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('271', 'Jueves', '1', '656', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008100', '25');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('272', 'Viernes', '1', '655', 0, '14:15:00', '15:45:00', 'I/2008', 'INACTIVO', '2008301', '27');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('264', 'Lunes', '1', '636', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008103', '22');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('265', 'Viernes', '1', '655', 0, '15:45:00', '17:15:00', 'I/2008', 'INACTIVO', '2008103', '22');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('263', 'Miercoles', '3', '622', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '21');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('516', 'Lunes', '3', '660', 0, '06:45:00', '08:15:00', 'I/2008', 'INACTIVO', '2008056', '21');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('273', 'Martes', '1', '625D', 0, '11:15:00', '12:45:00', 'I/2008', 'INACTIVO', '2008083', '28');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('274', 'Sabado', '1', '625D', 0, '08:15:00', '09:45:00', 'I/2008', 'INACTIVO', '2008083', '28');
INSERT INTO horario_doc (codigo, dia, grupo, aula, num_alum, hora_ini, hora_fin, gestion, estado, fk_materia_dicta, fk_materia_dicta1) VALUES ('517', 'Martes', '2B', '692C', 0, '08:15:00', '09:45:00', 'I/2012', 'INACTIVO', '2008054', '135');


--
-- TOC entry 2527 (class 0 OID 40525)
-- Dependencies: 188
-- Data for Name: horario_rangos_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '4');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '5');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '6');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '7');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '8');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '9');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '10');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '11');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '12');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '13');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '14');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '15');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '16');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '17');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '24');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '25');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '26');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '27');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '28');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '29');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '30');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '31');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '32');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '33');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '34');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '35');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '36');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '37');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '42');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '43');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '44');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '45');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '46');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '51');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '49');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '50');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '47');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '52');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '53');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '2');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '3');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '23');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '07:30:00', '1', '2', 'INACTIVO', 'I/2008', '72');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '68');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '69');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '70');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '71');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '39');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '40');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '41');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '73');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '21');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '22');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '54');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '55');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '38');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '57');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '74');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '62');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '64');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '66');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '3', '5', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '103');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '103');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '103');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '104');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '103');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '104');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '105');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '10:00:00', '1', '6', 'INACTIVO', 'I/2008', '106');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:00:00', '09:30:00', '2', '4', 'INACTIVO', 'I/2008', '80');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '90');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '61');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '75');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '91');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '95');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '96');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '97');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '98');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '99');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '100');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '101');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:45:00', '12:45:00', '8', '9', 'INACTIVO', 'I/2008', '102');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '103');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '104');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '105');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '10:00:00', '1', '6', 'INACTIVO', 'I/2008', '106');
INSERT INTO horario_rangos_aux (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_aux) VALUES ('06:45:00', '10:00:00', '1', '6', 'INACTIVO', 'I/2008', '107');


--
-- TOC entry 2528 (class 0 OID 40529)
-- Dependencies: 189
-- Data for Name: horario_rangos_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '213');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '214');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '215');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '216');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '217');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '218');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '219');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '220');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '221');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '222');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '223');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '224');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '275');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '276');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '310');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '311');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '312');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '313');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('20:15:00', '21:45:00', '19', '20', 'INACTIVO', 'I/2008', '314');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '315');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '324');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '325');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '326');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '321');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '322');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '323');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '316');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '317');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '318');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '319');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '320');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '327');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '328');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '329');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '330');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '331');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '332');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '333');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '334');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '335');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '336');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '337');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '338');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '339');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '340');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '341');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('20:15:00', '21:45:00', '19', '20', 'INACTIVO', 'I/2008', '349');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '350');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '347');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '348');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '342');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '343');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '344');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '345');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '346');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '351');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '352');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '353');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '354');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '355');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '356');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '357');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '358');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '359');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '360');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '361');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '362');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '363');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '364');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '365');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '370');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '371');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '366');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '367');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '368');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '369');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '372');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '373');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '374');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '375');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '376');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '510');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '377');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '378');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('20:15:00', '21:45:00', '19', '20', 'INACTIVO', 'I/2008', '379');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '380');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '381');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '382');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '383');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '384');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '385');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '386');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '387');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '388');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '389');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '390');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '391');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '394');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '395');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '392');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '393');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '396');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '397');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '401');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '402');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '403');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '404');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '405');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '406');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '407');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '408');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '409');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '410');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '411');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '412');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '413');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '414');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '415');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '416');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('20:15:00', '21:45:00', '19', '20', 'INACTIVO', 'I/2008', '417');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '442');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '443');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '439');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '440');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '441');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '444');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '445');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '432');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '433');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '436');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '437');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '438');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '434');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '435');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '446');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '447');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '448');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '449');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '450');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '453');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '454');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '455');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '469');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '470');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '471');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '460');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '461');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '466');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '467');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '468');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '456');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '457');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '458');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '459');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '462');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '463');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '464');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '465');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '472');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '473');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '474');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '475');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '476');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '477');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '478');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '479');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '480');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '481');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '482');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '483');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '484');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '485');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '486');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '487');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '488');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '498');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '499');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '500');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '501');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '502');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '503');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '504');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '505');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '511');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '512');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '225');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '226');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '227');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '231');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '232');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '233');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '228');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '229');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '230');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '234');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '235');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '260');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '261');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '255');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '256');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '254');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '251');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '252');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '253');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '257');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '258');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '259');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '279');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '280');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '286');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '287');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '281');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '282');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '283');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '284');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '285');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '277');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '278');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('18:45:00', '20:15:00', '17', '19', 'INACTIVO', 'I/2008', '506');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '507');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '306');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '307');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '308');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '309');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '288');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '289');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '290');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '291');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '298');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '297');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '292');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '293');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '294');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '295');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '299');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '300');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '301');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '302');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '303');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '304');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '305');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '425');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '426');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '423');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '424');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '427');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '428');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '429');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '430');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '431');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '418');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '419');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '420');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '421');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '422');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '398');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '399');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '400');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '497');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '489');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('12:45:00', '14:15:00', '9', '11', 'INACTIVO', 'I/2008', '490');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '491');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '492');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '493');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '494');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '495');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '496');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '508');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '513');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '236');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '237');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '238');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '249');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '250');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '247');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '248');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '241');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '242');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '243');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '244');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '245');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '246');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('09:45:00', '11:15:00', '5', '7', 'INACTIVO', 'I/2008', '239');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '240');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '268');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '269');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '266');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '267');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('17:15:00', '18:45:00', '15', '17', 'INACTIVO', 'I/2008', '270');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '271');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('14:15:00', '15:45:00', '11', '13', 'INACTIVO', 'I/2008', '272');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '264');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('15:45:00', '17:15:00', '13', '15', 'INACTIVO', 'I/2008', '265');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '263');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('06:45:00', '08:15:00', '1', '3', 'INACTIVO', 'I/2008', '516');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('11:15:00', '12:45:00', '7', '9', 'INACTIVO', 'I/2008', '273');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2008', '274');
INSERT INTO horario_rangos_doc (hor_ini, hor_fin, rango_ini, rango_fin, estado, gestion, fk_horario_doc) VALUES ('08:15:00', '09:45:00', '3', '5', 'INACTIVO', 'I/2012', '517');


--
-- TOC entry 2529 (class 0 OID 40533)
-- Dependencies: 190
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
-- TOC entry 2530 (class 0 OID 40537)
-- Dependencies: 191
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
-- TOC entry 2531 (class 0 OID 40541)
-- Dependencies: 192
-- Data for Name: inscritos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2532 (class 0 OID 40544)
-- Dependencies: 193
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2533 (class 0 OID 40547)
-- Dependencies: 194
-- Data for Name: laboratorio; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2534 (class 0 OID 40552)
-- Dependencies: 195
-- Data for Name: materia; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000001', 'GEOMETRIA II', '2008084', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000002', 'ALGEBRA I', '2008019', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000003', 'CALCULO I', '2008054', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000004', 'ALGEBRA II', '2008022', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000005', 'CALCULO II', '2008056', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000007', 'CALCULO COMPUTARIZADO', '2008043', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000009', 'ESTADISTICA II', '2008061', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000010', 'MATEMATICA DISCRETA', '2008057', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000011', 'ECUACIONES DIFERENCIALES', '2008058', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000012', 'ESTADISTICA I', '2008059', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000013', 'CALCULO NUMERICO', '2008060', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000014', 'LOGICA', '2008140', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000015', 'ALGEBRA', '2008239', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000016', 'VARIABLE COMPLEJA', '2008024', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000017', 'TRANFORMADAS INTEGRALES', '2008157', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000018', 'ESTADISTICA APLICADA', '2008241', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000019', 'CALCULO III', '2008066', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000020', 'GEOMETRIA ANALITICA PLANA Y DEL ESPACIO', '2008238', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000021', 'GEOMETRIA DESCRIPTIVA', '2008013', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000022', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000024', 'MATEMATICA COMPUTACIONAL II', '2008214', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000025', 'TEORIA AXIOMATICA DE CONJUNTOS', '2008078', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000026', 'GEOMETRIA I', '2008079', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000028', 'ANALISIS I', '2008080', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000029', 'GEOMETRIA III', '2008086', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000030', 'ALGEBRA LINEAL AVANZADA', '2008082', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000031', 'ANALISIS II', '2008083', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000032', 'ANALISIS III', '2008087', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000033', 'ANALISIS NUMERICO I', '2008122', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000034', 'ANALISIS IV', '2008089', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000035', 'GEOMETRIA IV', '2008090', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000036', 'ANALISIS NUMERICO II', '2008091', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000037', 'ALGEBRA ABSTRACTA II', '2008123', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000038', 'ALGEBRA ABSTRACTA I', '2008085', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000039', 'ANALISIS FUNCIONAL', '2008092', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000040', 'SISTEMAS DINAMICOS', '2008093', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000041', 'INVESTIGACION OPERATIVA', '2008236', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000042', 'TALLER DE INVESTIGACION OPERATIVA', '2008023', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000043', 'OPTIMIZACION', '2008095', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000044', 'SEMINARIO DE GRADO', '2008100', 'CURRICULAR', 'ACTIVO', 'NO', 'I', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000045', 'TRABAJO DE GRADO', '2008103', 'CURRICULAR', 'ACTIVO', 'NO', 'J', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000046', 'TOPOLOGIA ALGEBRAICA', '2008131', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000047', 'TEMAS TRANSVERSALES I', '2008301', 'CURRICULAR', 'ACTIVO', 'NO', 'B', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000048', 'DIDACTICA DE LAS CIENCIAS I', '2008172', 'CURRICULAR', 'ACTIVO', 'NO', 'E', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000049', 'DIDACTICA DE LAS CIANCIAS II', '2008173', 'CURRICULAR', 'ACTIVO', 'NO', 'F', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000050', 'DIDACTICA DE LAS CIENCIAS III', '2008174', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000051', 'APLICACIONES DIDACTICAS I', '2008175', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000052', 'APLICACIONES DIDACTICAS II', '2008176', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000053', 'INVESTIGACION DIDACTICA', '2008177', 'CURRICULAR', 'ACTIVO', 'NO', 'G', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000054', 'DIDACTICA DE LAS CIENCIAS IV', '2008178', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000056', 'TEMAS TRANSVERDALES II', '2008180', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000055', 'CIENCIA TECNOLOGIA SOCIEDAD', '2008179', 'CURRICULAR', 'ACTIVO', 'NO', 'H', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000057', 'CALCULO COMPLEJO', '2008156', 'CURRICULAR', 'ACTIVO', 'NO', 'D', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000058', 'ANALISIS NUMERICO', '2008067', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000059', 'BIOESTADISTICA', '2008161', 'CURRICULAR', 'ACTIVO', 'NO', 'C', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000060', 'ALGEBRA LINEAL', '2008063', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000061', 'FUNCIONES ESPECIALES', '2008242', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000062', 'ANALISIS MATEMATICO III', '2008144', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000063', 'ALGEBRA LINEAL Y TEORIA MATRICIAL', '2008237', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000064', 'ESTRUCTURAS DISCRETAS', '2008075', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000065', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000068', 'CALCULO', '2008160', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000069', 'TEORIA DE LA MEDIDA', '2008110', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000070', 'PROBABILIDAD Y ESTADISTICA II', '2008081', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000071', 'GEOMETRIA', '2008070', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000072', 'MODELAJE Y SIMULACION', '2008096', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');
INSERT INTO materia (codigo, nombre, sigla, tipo, estado, seg_nom, nivel, acronimo) VALUES ('MAT2008_000073', 'TENSORES Y FORMAS', '2008098', 'CURRICULAR', 'ACTIVO', 'NO', 'A', '');


--
-- TOC entry 2535 (class 0 OID 40556)
-- Dependencies: 196
-- Data for Name: materia_dicta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('6', 'A)', 'CALCULO NUMERICO', '2008060', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000003', NULL, 'MAT2008_000013', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('29', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '000009', NULL, 'MAT2008_000003', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('45', 'A)', 'LOGICA', '2008140', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00014', NULL, 'MAT2008_000014', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('46', 'B)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00014', NULL, 'MAT2008_000002', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('47', 'C)', 'GEOMETRIA ANALITICA PLANA Y DEL ESPACIO', '2008238', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00014', NULL, 'MAT2008_000020', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('51', 'D)', 'CALCULO COMPUTARIZADO', '2008043', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00015', NULL, 'MAT2008_000007', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('50', 'C)', 'CALCULO COMPUTARIZADO', '2008043', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00015', NULL, 'MAT2008_000007', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('48', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00015', NULL, 'MAT2008_000003', '9');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('49', 'B)', 'CALCULO NUMERICO', '2008060', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00015', NULL, 'MAT2008_000013', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('52', 'letra', 'ESTRUCTURAS DISCRETAS', '2008075', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00015', NULL, 'MAT2008_000064', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('53', 'A)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00016', NULL, 'MAT2008_000004', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('54', 'B)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00016', NULL, 'MAT2008_000002', '8');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('55', 'C)', 'ALGEBRA', '2008239', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00016', NULL, 'MAT2008_000015', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('56', 'D)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00016', NULL, 'MAT2008_000002', '11');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('57', 'E)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00016', NULL, 'MAT2008_000003', '7');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('61', 'D)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00017', NULL, 'MAT2008_000012', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('60', 'C)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00017', NULL, 'MAT2008_000012', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('58', 'A)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00017', NULL, 'MAT2008_000012', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('59', 'B)', 'ESTADISTICA II', '2008061', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00017', NULL, 'MAT2008_000009', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('62', 'letra', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00017', NULL, 'MAT2008_000065', '5');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('63', 'A)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00018', NULL, 'MAT2008_000004', '7');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('64', 'B)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00018', NULL, 'MAT2008_000004', '6');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('65', 'C)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00018', NULL, 'MAT2008_000004', '4');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('66', 'D)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00018', NULL, 'MAT2008_000011', '4');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('68', 'B)', 'CALCULO', '2008160', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00019', NULL, 'MAT2008_000068', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('70', 'B)', 'ALGEBRA LINEAL AVANZADA', '2008082', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00020', NULL, 'MAT2008_000030', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('73', 'E)', 'ANALISIS III', '2008087', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00020', NULL, 'MAT2008_000032', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('71', 'C)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00020', NULL, 'MAT2008_000011', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('72', 'D)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00020', NULL, 'MAT2008_000011', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('74', 'F)', 'TOPOLOGIA ALGEBRAICA', '2008131', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00020', NULL, 'MAT2008_000046', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('75', 'letra', 'ANALISIS NUMERICO II', '2008091', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00020', NULL, 'MAT2008_000036', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('76', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00021', NULL, 'MAT2008_000003', '8');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('77', 'B)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00021', NULL, 'MAT2008_000012', '5');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('78', 'C)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00021', NULL, 'MAT2008_000002', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('79', 'D)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00021', NULL, 'MAT2008_000002', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('80', 'E)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00021', NULL, 'MAT2008_000002', '9');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('81', 'A)', 'ANALISIS I', '2008080', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00022', NULL, 'MAT2008_000028', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('83', 'C)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00022', NULL, 'MAT2008_000003', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('82', 'B)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 8, '00022', NULL, 'MAT2008_000005', '4');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('84', 'letra', 'TEORIA DE LA MEDIDA', '2008110', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00022', NULL, 'MAT2008_000069', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('86', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00024', NULL, 'MAT2008_000003', '14');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('87', 'B)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00024', NULL, 'MAT2008_000002', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('88', 'C)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00024', NULL, 'MAT2008_000002', '10');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('89', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00025', NULL, 'MAT2008_000003', '11');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('90', 'B)', 'VARIABLE COMPLEJA', '2008024', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00025', NULL, 'MAT2008_000016', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('91', 'C)', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00025', NULL, 'MAT2008_000022', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('103', 'F)', 'ALGEBRA LINEAL Y TEORIA MATRICIAL', '2008237', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00027', NULL, 'MAT2008_000063', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('102', 'E)', 'BIOESTADISTICA', '2008161', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00027', NULL, 'MAT2008_000059', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('104', 'G)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00027', NULL, 'MAT2008_000003', '17');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('99', 'B)', 'ESTADISTICA II', '2008061', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00027', NULL, 'MAT2008_000009', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('101', 'D)', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00027', NULL, 'MAT2008_000065', '4');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('100', 'C)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'TITULAR', 'INACTIVO', 'I/2008', 48, 160, '00027', NULL, 'MAT2008_000004', '8');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('105', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00028', NULL, 'MAT2008_000002', '7');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('106', 'B)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00028', NULL, 'MAT2008_000002', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('108', 'A)', 'ALGEBRA LINEAL', '2008063', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00029', NULL, 'MAT2008_000060', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('115', 'letra', 'GEOMETRIA', '2008070', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 56, 160, '00030', NULL, 'MAT2008_000071', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('111', 'C)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00030', NULL, 'MAT2008_000003', '12');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('114', 'letra', 'ESTADISTICA APLICADA', '2008241', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00030', NULL, 'MAT2008_000018', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('109', 'A)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00030', NULL, 'MAT2008_000012', '4');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('110', 'B)', 'ESTADISTICA II', '2008061', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00030', NULL, 'MAT2008_000009', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('112', 'letra', 'PROBABILIDAD Y ESTADISTICA II', '2008081', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00030', NULL, 'MAT2008_000070', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('113', 'letra', 'ANALISIS NUMERICO', '2008067', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 56, 160, '00030', NULL, 'MAT2008_000058', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('116', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00031', NULL, 'MAT2008_000002', '5');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('117', 'A)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00032', NULL, 'MAT2008_000005', '7');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('118', 'A)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00033', NULL, 'MAT2008_000004', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('119', 'B)', 'GEOMETRIA ANALITICA PLANA Y DEL ESPACIO', '2008238', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00033', NULL, 'MAT2008_000020', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('120', 'C)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00033', NULL, 'MAT2008_000005', '6');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('121', 'A)', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00034', NULL, 'MAT2008_000065', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('122', 'A)', 'ANALISIS NUMERICO', '2008067', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00035', NULL, 'MAT2008_000058', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('128', 'A)', 'TENSORES Y FORMAS', '2008098', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00037', NULL, 'MAT2008_000073', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('129', 'A)', 'GEOMETRIA II', '2008084', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00038', NULL, 'MAT2008_000001', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('130', 'B)', 'GEOMETRIA I', '2008079', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00038', NULL, 'MAT2008_000026', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('131', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00039', NULL, 'MAT2008_000002', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('134', 'A)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00042', '000002', 'MAT2008_000005', '5');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('7', 'A)', 'GEOMETRIA DESCRIPTIVA', '2008013', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000004', NULL, 'MAT2008_000021', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('9', 'C)', 'GEOMETRIA DESCRIPTIVA', '2008013', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000004', NULL, 'MAT2008_000021', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('8', 'B)', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000004', NULL, 'MAT2008_000022', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('10', 'A)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '000005', NULL, 'MAT2008_000005', '9');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('20', 'letra', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '000007', NULL, 'MAT2008_000003', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('18', 'B)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000007', NULL, 'MAT2008_000005', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('17', 'A)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 32, '000007', NULL, 'MAT2008_000005', '7');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('19', 'letra', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000007', NULL, 'MAT2008_000002', '12');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('31', 'B)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00010', NULL, 'MAT2008_000005', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('35', 'letra', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00010', NULL, 'MAT2008_000005', '6');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('32', 'C)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00010', NULL, 'MAT2008_000005', '8');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('33', 'D)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00010', NULL, 'MAT2008_000011', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('30', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 72, 160, '00010', NULL, 'MAT2008_000003', '5');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('132', 'A)', 'ESTADISTICA II', '2008061', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00040', NULL, 'MAT2008_000009', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('43', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00013', NULL, 'MAT2008_000003', '6');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('44', 'B)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00013', NULL, 'MAT2008_000003', '10');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('36', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00011', NULL, 'MAT2008_000003', '16');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('37', 'letra', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00011', NULL, 'MAT2008_000003', '18');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('40', 'letra', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00011', NULL, 'MAT2008_000005', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('38', 'letra', 'TEORIA AXIOMATICA DE CONJUNTOS', '2008078', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '00011', NULL, 'MAT2008_000025', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('39', 'letra', 'ALGEBRA LINEAL Y TEORIA MATRICIAL', '2008237', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 72, 160, '00011', NULL, 'MAT2008_000063', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('41', 'A)', 'CALCULO NUMERICO', '2008060', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00012', NULL, 'MAT2008_000013', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('42', 'B)', 'CALCULO NUMERICO', '2008060', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00012', NULL, 'MAT2008_000013', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('95', 'letra', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00026', NULL, 'MAT2008_000003', '15');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('94', 'letra', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00026', NULL, 'MAT2008_000003', '4');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('96', 'letra', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00026', NULL, 'MAT2008_000005', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('97', 'letra', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00026', NULL, 'MAT2008_000011', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('92', 'A)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00026', NULL, 'MAT2008_000011', '5');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('93', 'letra', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00026', NULL, 'MAT2008_000002', '6');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('85', 'A)', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00023', NULL, 'MAT2008_000065', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('127', 'E)', 'ALGEBRA ABSTRACTA II', '2008123', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 4, 4, 'INVITADO', 'INACTIVO', 'I/2008', 0, 8, '00036', NULL, 'MAT2008_000037', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('123', 'A)', 'MODELAJE Y SIMULACION', '2008096', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00036', NULL, 'MAT2008_000072', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('124', 'B)', 'OPTIMIZACION', '2008095', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00036', NULL, 'MAT2008_000043', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('125', 'C)', 'TALLER DE INVESTIGACION OPERATIVA', '2008023', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00036', NULL, 'MAT2008_000042', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('126', 'D)', 'ALGEBRA ABSTRACTA I', '2008085', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '00036', NULL, 'MAT2008_000038', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('133', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '00041', NULL, 'MAT2008_000002', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('11', 'A)', 'CALCULO NUMERICO', '2008060', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000006', NULL, 'MAT2008_000013', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('16', 'letra', 'FUNCIONES ESPECIALES', '2008242', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000006', NULL, 'MAT2008_000061', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('15', 'letra', 'GEOMETRIA III', '2008086', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000006', NULL, 'MAT2008_000029', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('13', 'letra', 'MATEMATICA DISCRETA', '2008057', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000006', NULL, 'MAT2008_000010', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('14', 'letra', 'TRANFORMADAS INTEGRALES', '2008157', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000006', NULL, 'MAT2008_000017', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('12', 'letra', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 40, 160, '000006', NULL, 'MAT2008_000005', '7');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('3', 'letra', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '000002', '000003', 'MAT2008_000002', '2');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('2', 'A)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '000002', '000003', 'MAT2008_000004', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('4', 'letra', 'ALGEBRA LINEAL', '2008063', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 16, '000002', '000003', 'MAT2008_000060', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('5', 'letra', 'MATEMATICA DISCRETA', '2008057', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 6, 16, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 24, '000002', '000003', 'MAT2008_000010', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('24', 'D)', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000008', NULL, 'MAT2008_000022', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('23', 'C)', 'GEOMETRIA IV', '2008090', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000008', NULL, 'MAT2008_000035', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('25', 'E)', 'SEMINARIO DE GRADO', '2008100', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000008', NULL, 'MAT2008_000044', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('27', 'G)', 'TEMAS TRANSVERSALES I', '2008301', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 4, 4, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000008', NULL, 'MAT2008_000047', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('22', 'B)', 'TRABAJO DE GRADO', '2008103', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000008', NULL, 'MAT2008_000045', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('21', 'A)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 0, 0, '000008', NULL, 'MAT2008_000005', '3');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('28', 'H)', 'ANALISIS II', '2008083', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 4, 8, 8, 'INVITADO', 'INACTIVO', 'I/2008', 56, 160, '000008', NULL, 'MAT2008_000031', '1');
INSERT INTO materia_dicta (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, tipo, estado, gestion, exclu, hor_auto, fk_segui_doc, fk_nombra_doc, fk_materia, grupo) VALUES ('135', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 4, 4, 'INVITADO', 'INACTIVO', 'I/2012', 152, 160, '00043', NULL, 'MAT2008_000003', '2B');


--
-- TOC entry 2537 (class 0 OID 40561)
-- Dependencies: 198
-- Data for Name: materia_dicta_sinonimo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2538 (class 0 OID 40565)
-- Dependencies: 199
-- Data for Name: materia_labo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('4', 'A)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008058', 'MAT', '000003', NULL, 'MAT2008_000011', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('5', 'A)', 'CALCULO III', '2008066', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008066', 'MAT', '000004', NULL, 'MAT2008_000019', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('6', 'A)', 'ESTADISTICA II', '2008061', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008061', 'MAT', '000005', NULL, 'MAT2008_000009', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('7', 'B)', 'ESTADISTICA II', '2008061', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008061', 'MAT', '000005', NULL, 'MAT2008_000009', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('8', 'A)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008058', 'MAT', '000006', NULL, 'MAT2008_000011', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('9', 'B)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008058', 'MAT', '000006', NULL, 'MAT2008_000011', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('10', 'A)', 'CALCULO', '2008160', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008160', 'MAT', '000007', NULL, 'MAT2008_000068', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('11', 'B)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '000007', NULL, 'MAT2008_000005', NULL, '6');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('12', 'C)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008059', 'MAT', '000007', NULL, 'MAT2008_000012', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('13', 'D)', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008029', 'MAT', '000007', NULL, 'MAT2008_000065', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('14', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '000008', NULL, 'MAT2008_000002', NULL, '5');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('15', 'B)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '000008', NULL, 'MAT2008_000002', NULL, '6');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('16', 'C)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008022', 'MAT', '000008', NULL, 'MAT2008_000004', NULL, '6');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('17', 'D)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008059', 'MAT', '000008', NULL, 'MAT2008_000012', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('24', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '00011', NULL, 'MAT2008_000002', NULL, '4');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('25', 'B)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00011', NULL, 'MAT2008_000003', NULL, '10');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('26', 'C)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00011', NULL, 'MAT2008_000003', NULL, '7');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('27', 'D)', 'GEOMETRIA ANALITICA PLANA Y DEL ESPACIO', '2008238', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008238', 'MAT', '00011', NULL, 'MAT2008_000020', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('28', 'A)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 0, 'INACTIVO', 'I/2008', '2008022', 'MAT', '00012', NULL, 'MAT2008_000004', NULL, '4');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('29', 'B)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00012', NULL, 'MAT2008_000005', NULL, '4');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('30', 'C)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00012', NULL, 'MAT2008_000005', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('31', 'A)', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008014', 'MAT', '00013', NULL, 'MAT2008_000022', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('32', 'B)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00013', NULL, 'MAT2008_000005', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('33', 'C)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00013', NULL, 'MAT2008_000005', NULL, '9');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('34', 'D)', 'ECUACIONES DIFERENCIALES', '2008058', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008058', 'MAT', '00013', NULL, 'MAT2008_000011', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('35', 'A)', 'ALGEBRA LINEAL Y TEORIA MATRICIAL', '2008237', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008237', 'MAT', '00014', NULL, 'MAT2008_000063', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('36', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00015', NULL, 'MAT2008_000003', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('37', 'B)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00015', NULL, 'MAT2008_000003', NULL, '4');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('42', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '00017', NULL, 'MAT2008_000002', NULL, '11');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('43', 'B)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '00017', NULL, 'MAT2008_000002', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('44', 'C)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008022', 'MAT', '00017', NULL, 'MAT2008_000004', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('45', 'D)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00017', NULL, 'MAT2008_000005', NULL, '5');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('46', 'E)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00017', NULL, 'MAT2008_000005', NULL, '7');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('47', 'A)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00018', NULL, 'MAT2008_000003', NULL, '12');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('49', 'C)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00018', NULL, 'MAT2008_000005', NULL, '6');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('50', 'D)', 'CALCULO II', '2008056', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008056', 'MAT', '00018', NULL, 'MAT2008_000005', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('48', 'B)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00018', NULL, 'MAT2008_000003', NULL, '18');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('51', 'A)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008022', 'MAT', '00019', NULL, 'MAT2008_000004', NULL, '3');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('2', 'A)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008059', 'MAT', '000002', NULL, 'MAT2008_000012', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('3', 'B)', 'ESTADISTICA I', '2008059', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008059', 'MAT', '000002', NULL, 'MAT2008_000012', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('23', 'letra', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008022', 'MAT', '00010', NULL, 'MAT2008_000004', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('20', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '00010', NULL, 'MAT2008_000002', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('22', 'C)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00010', NULL, 'MAT2008_000003', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('21', 'B)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00010', NULL, 'MAT2008_000003', NULL, '5');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('39', 'B)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00016', NULL, 'MAT2008_000003', NULL, '8');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('40', 'C)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00016', NULL, 'MAT2008_000003', NULL, '9');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('41', 'D)', 'CALCULO I', '2008054', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008054', 'MAT', '00016', NULL, 'MAT2008_000003', NULL, '1');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('38', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '00016', NULL, 'MAT2008_000002', NULL, '2');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('18', 'A)', 'ALGEBRA I', '2008019', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008019', 'MAT', '000009', NULL, 'MAT2008_000002', NULL, '7');
INSERT INTO materia_labo (codigo, cod_nom, nombre_mat, sigla, facultad, departamento, carrera, hor_sem, hor_teo, hor_pra, estado, gestion, sigla_lab, tipo, fk_segui_aux, fk_nombra_aux, fk_materia, fk_laboratorio, grupo) VALUES ('19', 'B)', 'ALGEBRA II', '2008022', 'CIENCIAS Y TECNOLOG?A', 'MATEMATICAS', 'MAT-MAT', 2, 0, 2, 'INACTIVO', 'I/2008', '2008022', 'MAT', '000009', NULL, 'MAT2008_000004', NULL, '8');


--
-- TOC entry 2539 (class 0 OID 40568)
-- Dependencies: 200
-- Data for Name: mes; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2540 (class 0 OID 40571)
-- Dependencies: 201
-- Data for Name: nombra_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2541 (class 0 OID 40574)
-- Dependencies: 202
-- Data for Name: nombra_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_docente) VALUES ('000002', 'BUSTILLOS  ALEX', 'LIC. EN MATEMATICAS', 'MATEMATICAS', 'CIENCIAS Y TECNOLOG?A', 'INGENIERO ELECTRICO', 'INGENIERO', 'PARCIAL', '2008-07-10', '2008-07-10', 'UN SEMESTRE', 'I/2008', 4, 'INACTIVO', 'DOC0050');
INSERT INTO nombra_doc (codigo, nombre, carrera, departamento, facultad, diploma, titulo, tiempo, fecha_nom, fecha_sol, duracion, gestion, hrs_sem, estado, fk_docente) VALUES ('000003', 'CABALLERO ESPINOZA JAVIER', 'LIC. EN MATEMATICAS', 'MATEMATICAS', 'CIENCIAS Y TECNOLOG?A', 'AGRONOMO', 'INGENIERO AGRONOMO', 'PARCIAL', '2008-02-06', '2008-03-11', 'UN SEMESTRE', 'I/2008', 18, 'INACTIVO', 'DOC0003');


--
-- TOC entry 2542 (class 0 OID 40577)
-- Dependencies: 203
-- Data for Name: nota; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2543 (class 0 OID 40580)
-- Dependencies: 204
-- Data for Name: pga_diagrams; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2544 (class 0 OID 40586)
-- Dependencies: 205
-- Data for Name: pga_forms; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2545 (class 0 OID 40592)
-- Dependencies: 206
-- Data for Name: pga_graphs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2546 (class 0 OID 40598)
-- Dependencies: 207
-- Data for Name: pga_images; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2547 (class 0 OID 40604)
-- Dependencies: 208
-- Data for Name: pga_layout; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO pga_layout (tablename, nrcols, colnames, colwidth) VALUES ('public.gestion', 5, 'codigo gestion fecha_ini fecha_fin estado', '150 150 150 150 150');
INSERT INTO pga_layout (tablename, nrcols, colnames, colwidth) VALUES ('public.segui_doc', 32, 'codigo ape_esposo asist adj cat aux_doc otro_cargo hrs_teor hrs_inves hrs_ext hrs_ser hrs_prac rcfn1 rcfn2 rcfn3 hrs_prod hrs_serv hrs_prod_acad hrs_adm_acad rcfn4 rcfn5 rcfn6 rcfn7 hrs_trab_sem hrs_trab_mes hrs_auto tiempo_par dedi_exclu gestion obs fk_docente estado', '150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150');


--
-- TOC entry 2548 (class 0 OID 40610)
-- Dependencies: 209
-- Data for Name: pga_queries; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2549 (class 0 OID 40616)
-- Dependencies: 210
-- Data for Name: pga_reports; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2550 (class 0 OID 40622)
-- Dependencies: 211
-- Data for Name: pga_scripts; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2551 (class 0 OID 40628)
-- Dependencies: 212
-- Data for Name: plan; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO plan (codigo, nombre, codigo_sis, fecha_ini, fecha_fin, estado, fk_carrera) VALUES ('PLAN0001', 'LICENCIATURA EN MATEMATICAS', '349701', NULL, NULL, 'ACTIVO', 'CAR0001');
INSERT INTO plan (codigo, nombre, codigo_sis, fecha_ini, fecha_fin, estado, fk_carrera) VALUES ('PLAN0002', 'LICENCIATURA EN INGENIERIA MATEMATICA', '439801', NULL, NULL, 'ACTIVO', 'CAR0002');


--
-- TOC entry 2552 (class 0 OID 40631)
-- Dependencies: 213
-- Data for Name: plan_mat; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2553 (class 0 OID 40634)
-- Dependencies: 214
-- Data for Name: prerequisito; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2554 (class 0 OID 40637)
-- Dependencies: 215
-- Data for Name: prestamo_tesis; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2555 (class 0 OID 40643)
-- Dependencies: 216
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2556 (class 0 OID 40646)
-- Dependencies: 217
-- Data for Name: programa; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2557 (class 0 OID 40650)
-- Dependencies: 218
-- Data for Name: rango_res; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2558 (class 0 OID 40653)
-- Dependencies: 219
-- Data for Name: remitente; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2559 (class 0 OID 40656)
-- Dependencies: 220
-- Data for Name: reserva; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2560 (class 0 OID 40659)
-- Dependencies: 221
-- Data for Name: sala; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 197
-- Name: sec_codigo_materia_dicta; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sec_codigo_materia_dicta', 1, false);


--
-- TOC entry 2561 (class 0 OID 40662)
-- Dependencies: 222
-- Data for Name: segui_aux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000003', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'I/2008', '', 'AUX2007_000003', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000004', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'I/2008', '', 'AUX2007_000001', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000005', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2008', '', 'AUX2007_000004', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000006', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2008', '', 'AUX2007_000005', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000007', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000007', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000008', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000009', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00011', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000028', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00012', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '', 'I/2008', '', 'AUX2007_000016', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00013', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000023', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00014', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'I/2008', '', 'AUX2007_000019', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00015', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2008', '', 'AUX2008_000002', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00017', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '', 'I/2008', '', 'AUX2007_000022', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00018', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000030', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00019', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '8', '', '', 'I/2008', '', 'AUX2008_000003', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000002', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2008', '', 'AUX2007_000002', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00010', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000027', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00016', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '', 'I/2008', '', 'AUX2007_000020', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('000009', '', 'N', 'N', 'N', 'N', '', '0', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '4', '32', '32', '', '', 'I/2008', '', 'AUX2007_000026', 'INACTIVO');
INSERT INTO segui_aux (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_auxiliar, estado) VALUES ('00020', '', 'N', 'N', 'N', 'N', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '', 'I/2008', '', 'AUX2008_000008', 'INACTIVO');


--
-- TOC entry 2562 (class 0 OID 40665)
-- Dependencies: 223
-- Data for Name: segui_doc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000002', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '32', '', '0', 'I/2008', 'PARCIAL', 'DOC0003', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000003', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2008', 'PARCIAL', 'DOC0004', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000009', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0046', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00014', '', 'N', 'N', 'N', 'N', '', '6', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2008', 'PARCIAL', 'DOC0014', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00015', '', 'N', 'N', 'N', 'N', '', '18', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '28', '112', '88', '', '0', 'I/2008', 'parcial', 'DOC0015', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00016', '', 'N', 'N', 'N', 'N', '', '14', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '24', '96', '96', '', '0', 'I/2008', 'PARCIAL', 'DOC0016', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00017', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '22', '88', '72', '', '0', 'I/2008', 'PARCIAL', 'DOC0017', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00018', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '72', '', '0', 'I/2008', 'PARCIAL', 'DOC0019', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00019', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0020', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00020', '', 'N', 'N', 'N', 'N', '', '14', '', '', '', '12', '', '', '', '', '', '', '', '', '', '', '', '26', '104', '80', '', '0', 'I/2008', 'PARCIAL', 'DOC0021', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00021', '', 'N', 'N', 'N', 'N', '', '16', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '26', '104', '104', '', '0', 'I/2008', 'PARCIAL', 'DOC0022', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00022', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '48', '', '0', 'I/2008', 'PARCIAL', 'DOC0024', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00024', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '64', '', '0', 'I/2008', 'PARCIAL', 'DOC0041', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00025', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '72', '', '0', 'I/2008', 'PARCIAL', 'DOC0028', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00027', '', 'N', 'N', 'N', 'N', '', '16', '', '', '', '12', '', '', '', '', '', '', '', '', '', '', '', '28', '112', '160', '', '48', 'I/2008', 'EXCLUSIVO', 'DOC0023', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00028', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '10', '40', '40', '', '0', 'I/2008', 'PARCIAL', 'DOC0042', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00029', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2008', 'PARCIAL', 'DOC0030', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00030', '', 'N', 'N', 'N', 'N', '', '18', '', '', '', '14', '', '', '', '', '', '', '', '', '', '', '', '32', '128', '160', '', '56', 'I/2008', 'EXCLUSIVO', 'DOC0031', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00031', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0032', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00032', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0043', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00033', '', 'N', 'N', 'N', 'N', '', '10', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '16', '64', '64', '', '0', 'I/2008', 'PARCIAL', 'DOC0033', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00034', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0044', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00035', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2008', 'PARCIAL', 'DOC0036', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00037', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '160', '16', '', '0', 'I/2008', 'EXCLUSIVO', 'DOC0045', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00038', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '0', 'I/2008', 'EXCLUSIVO', 'DOC0018', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00039', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0047', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00042', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0050', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000004', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '6', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '72', '', '0', 'I/2008', 'PARCIAL', 'DOC0005', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000005', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0006', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000007', '', 'N', 'N', 'N', 'N', '', '14', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '22', '88', '96', '', '0', 'I/2008', 'PARCIAL', 'DOC0008', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00010', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '22', '88', '160', '', '72', 'I/2008', 'EXCLUSIVO', 'DOC0010', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00040', '', 'N', 'N', 'N', 'N', '', '2', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '4', '16', '16', '', '0', 'I/2008', 'PARCIAL', 'DOC0048', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00013', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '8', '32', '32', '', '0', 'I/2008', 'PARCIAL', 'DOC0011', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00011', '', 'N', 'N', 'N', 'N', '', '12', '', '', '', '10', '', '', '', '', '', '', '', '', '', '', '', '22', '88', '160', '', '72', 'I/2008', 'EXCLUSIVO', 'DOC0012', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00012', '', 'N', 'N', 'N', 'N', '', '8', '', '', '', '4', '', '', '', '', '', '', '', '', '', '', '', '12', '48', '48', '', '0', 'I/2008', 'PARCIAL', 'DOC0013', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00026', '', 'N', 'N', 'N', 'N', '', '16', '', '', '', '12', '', '', '', '', '', '', '', '', '', '', '', '28', '112', '112', '', '0', 'I/2008', 'EXCLUSIVO', 'DOC0025', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00023', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2008', 'PARCIAL', 'DOC0026', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00036', '', 'N', 'N', 'N', 'N', '', '9', '', '', '', '9', '', '', '', '', '', '', '', '', '', '', '', '18', '72', '72', '', '0', 'I/2008', 'EXCLUSIVO', 'DOC0037', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00041', '', 'N', 'N', 'N', 'N', '', '4', '', '', '', '2', '', '', '', '', '', '', '', '', '', '', '', '6', '24', '24', '', '0', 'I/2008', 'PARCIAL', 'DOC0049', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000006', '', 'N', 'N', 'N', 'N', '', '18', '', '', '', '12', '', '', '', '', '', '', '', '', '', '', '', '30', '120', '160', '', '40', 'I/2008', 'EXCLUSIVO', 'DOC0007', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('000008', '', 'N', 'N', 'N', 'N', '', '13', '', '', '', '13', '', '', '', '', '', '', '', '', '', '', '', '26', '104', '160', '', '56', 'I/2008', 'EXCLUSIVO', 'DOC0009', 'INACTIVO');
INSERT INTO segui_doc (codigo, ape_esposo, asist, adj, cat, aux_doc, otro_cargo, hrs_teor, hrs_inves, hrs_ext, hrs_ser, hrs_prac, rcfn1, rcfn2, rcfn3, hrs_prod, hrs_serv, hrs_prod_acad, hrs_adm_acad, rcfn4, rcfn5, rcfn6, rcfn7, hrs_trab_sem, hrs_trab_mes, hrs_auto, tiempo_par, dedi_exclu, gestion, obs, fk_docente, estado) VALUES ('00043', '', 'N', 'N', 'N', 'N', '', '1', '', '', '', '1', '', '', '', '', '', '', '', '', '', '', '', '2', '8', '160', '', '152', 'I/2012', 'EXCLUSIVO', 'DOC0051', 'INACTIVO');


--
-- TOC entry 2563 (class 0 OID 40668)
-- Dependencies: 224
-- Data for Name: segui_exclu_auto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('26', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00027');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('27', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00027');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('28', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00030');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('29', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00030');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('32', 'EXCLUSIVO', 'OFICINA', 'JEFE DEPARTAMENTO', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00010');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('33', 'EXCLUSIVO', 'OFICINA', 'JEFE DEPARTAMENTO', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00010');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('34', 'EXCLUSIVO', 'OFICINA', '', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00013');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('35', 'EXCLUSIVO', 'OFICINA', '', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00013');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('36', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00011');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('37', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00011');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('38', 'EXCLUSIVO', 'OFICINA', '', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00023');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('39', 'EXCLUSIVO', 'OFICINA', '', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00023');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('40', 'EXCLUSIVO', 'OFICINA', 'EXCLUSIVO', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '000006');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('41', 'EXCLUSIVO', 'OFICINA', 'EXCLUSIVO', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '000006');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('42', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '000008');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('43', 'EXCLUSIVO', 'OFICINA', 'DEDICACION EXCLUSIVA', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '000008');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('44', 'EXCLUSIVO', 'OFICINA', 'EXCLUSIVO', '08:00:00', '2', '12:00:00', '8', 'ACTIVO', '00043');
INSERT INTO segui_exclu_auto (codigo, caso, tipo, nombre, hora_ini, rango_ini, hora_fin, rango_fin, estado, fk_segui_doc) VALUES ('45', 'EXCLUSIVO', 'OFICINA', 'EXCLUSIVO', '14:00:00', '10', '18:00:00', '16', 'ACTIVO', '00043');


--
-- TOC entry 2564 (class 0 OID 40671)
-- Dependencies: 225
-- Data for Name: sesion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2565 (class 0 OID 40675)
-- Dependencies: 226
-- Data for Name: tabla_horario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2566 (class 0 OID 40678)
-- Dependencies: 227
-- Data for Name: tabla_horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2567 (class 0 OID 40681)
-- Dependencies: 228
-- Data for Name: tema; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2568 (class 0 OID 40684)
-- Dependencies: 229
-- Data for Name: temp_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2569 (class 0 OID 40687)
-- Dependencies: 230
-- Data for Name: temp_bibliografia; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2570 (class 0 OID 40690)
-- Dependencies: 231
-- Data for Name: temp_cert_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2571 (class 0 OID 40693)
-- Dependencies: 232
-- Data for Name: temp_control_segui; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2572 (class 0 OID 40696)
-- Dependencies: 233
-- Data for Name: temp_destinatario; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2573 (class 0 OID 40699)
-- Dependencies: 234
-- Data for Name: temp_detalle_reserva; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2574 (class 0 OID 40702)
-- Dependencies: 235
-- Data for Name: temp_horario_aux; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2575 (class 0 OID 40705)
-- Dependencies: 236
-- Data for Name: temp_horario_doc; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2576 (class 0 OID 40708)
-- Dependencies: 237
-- Data for Name: temp_impresion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2577 (class 0 OID 40711)
-- Dependencies: 238
-- Data for Name: temp_materia_dicta; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2578 (class 0 OID 40714)
-- Dependencies: 239
-- Data for Name: temp_materia_labo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2579 (class 0 OID 40717)
-- Dependencies: 240
-- Data for Name: temp_materias; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000001', 'GEOMETRIA II', '2008084', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000002', 'ALGEBRA I', '2008019', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000003', 'CALCULO I', '2008054', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000004', 'ALGEBRA II', '2008022', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000005', 'CALCULO II', '2008056', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000007', 'CALCULO COMPUTARIZADO', '2008043', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000009', 'ESTADISTICA II', '2008061', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000010', 'MATEMATICA DISCRETA', '2008057', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000011', 'ECUACIONES DIFERENCIALES', '2008058', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000012', 'ESTADISTICA I', '2008059', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000013', 'CALCULO NUMERICO', '2008060', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000014', 'LOGICA', '2008140', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000015', 'ALGEBRA', '2008239', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000016', 'VARIABLE COMPLEJA', '2008024', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000017', 'TRANFORMADAS INTEGRALES', '2008157', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000018', 'ESTADISTICA APLICADA', '2008241', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000019', 'CALCULO III', '2008066', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000020', 'GEOMETRIA ANALITICA PLANA Y DEL ESPACIO', '2008238', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000021', 'GEOMETRIA DESCRIPTIVA', '2008013', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000022', 'ANALISIS VECTORIAL Y TENSORIAL', '2008014', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000024', 'MATEMATICA COMPUTACIONAL II', '2008214', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000025', 'TEORIA AXIOMATICA DE CONJUNTOS', '2008078', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000026', 'GEOMETRIA I', '2008079', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000028', 'ANALISIS I', '2008080', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000029', 'GEOMETRIA III', '2008086', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000030', 'ALGEBRA LINEAL AVANZADA', '2008082', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000031', 'ANALISIS II', '2008083', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000032', 'ANALISIS III', '2008087', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000033', 'ANALISIS NUMERICO I', '2008122', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000034', 'ANALISIS IV', '2008089', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000035', 'GEOMETRIA IV', '2008090', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000036', 'ANALISIS NUMERICO II', '2008091', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000037', 'ALGEBRA ABSTRACTA II', '2008123', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000038', 'ALGEBRA ABSTRACTA I', '2008085', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000039', 'ANALISIS FUNCIONAL', '2008092', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000040', 'SISTEMAS DINAMICOS', '2008093', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000041', 'INVESTIGACION OPERATIVA', '2008236', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000042', 'TALLER DE INVESTIGACION OPERATIVA', '2008023', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000043', 'OPTIMIZACION', '2008095', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000044', 'SEMINARIO DE GRADO', '2008100', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000045', 'TRABAJO DE GRADO', '2008103', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000046', 'TOPOLOGIA ALGEBRAICA', '2008131', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000047', 'TEMAS TRANSVERSALES I', '2008301', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000048', 'DIDACTICA DE LAS CIENCIAS I', '2008172', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000049', 'DIDACTICA DE LAS CIANCIAS II', '2008173', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000050', 'DIDACTICA DE LAS CIENCIAS III', '2008174', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000051', 'APLICACIONES DIDACTICAS I', '2008175', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000052', 'APLICACIONES DIDACTICAS II', '2008176', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000053', 'INVESTIGACION DIDACTICA', '2008177', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000054', 'DIDACTICA DE LAS CIENCIAS IV', '2008178', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000056', 'TEMAS TRANSVERDALES II', '2008180', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000055', 'CIENCIA TECNOLOGIA SOCIEDAD', '2008179', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000057', 'CALCULO COMPLEJO', '2008156', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000058', 'ANALISIS NUMERICO', '2008067', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000059', 'BIOESTADISTICA', '2008161', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000060', 'ALGEBRA LINEAL', '2008063', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000061', 'FUNCIONES ESPECIALES', '2008242', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000062', 'ANALISIS MATEMATICO III', '2008144', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000063', 'ALGEBRA LINEAL Y TEORIA MATRICIAL', '2008237', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000064', 'ESTRUCTURAS DISCRETAS', '2008075', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000065', 'PROBABILIDAD Y ESTADISTICA', '2008029', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000068', 'CALCULO', '2008160', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000069', 'TEORIA DE LA MEDIDA', '2008110', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000070', 'PROBABILIDAD Y ESTADISTICA II', '2008081', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000071', 'GEOMETRIA', '2008070', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000072', 'MODELAJE Y SIMULACION', '2008096', 'MAT');
INSERT INTO temp_materias (codigo, nombre, sigla, tipo) VALUES ('MAT2008_000073', 'TENSORES Y FORMAS', '2008098', 'MAT');


--
-- TOC entry 2580 (class 0 OID 40720)
-- Dependencies: 241
-- Data for Name: temp_nota; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2581 (class 0 OID 40723)
-- Dependencies: 242
-- Data for Name: temp_rango; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2582 (class 0 OID 40726)
-- Dependencies: 243
-- Data for Name: temp_rep_tesis_defen; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2583 (class 0 OID 40729)
-- Dependencies: 244
-- Data for Name: temp_tesismos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2584 (class 0 OID 40732)
-- Dependencies: 245
-- Data for Name: temp_tesista; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2585 (class 0 OID 40735)
-- Dependencies: 246
-- Data for Name: temp_validar_hor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2586 (class 0 OID 40738)
-- Dependencies: 247
-- Data for Name: tesis; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2587 (class 0 OID 40741)
-- Dependencies: 248
-- Data for Name: tesista; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2588 (class 0 OID 40744)
-- Dependencies: 249
-- Data for Name: titulo_adic; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2589 (class 0 OID 40747)
-- Dependencies: 250
-- Data for Name: titulo_curso; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2590 (class 0 OID 40750)
-- Dependencies: 251
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2004_0001', 'Administrador', 'Administrador', 'Administrador', 'ACTIVO', '', 'admin', '21232f297a57a5a743894a0e4a801fc3', '', 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2007_0002', 'GUALBERTO', 'CUPE', 'CLEMENTE', 'INACTIVO', 'M', 'cupeg', '055bfa8e3a3cf96157546445a4cb1457', 'AUT2007_0002', 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2007_0001', 'HERNAN', 'FLORES', 'GARCIA', 'INACTIVO', 'M', 'floresh', 'a95094d4fcf59dc43912cea8fea7077e', 'AUT2007_0001', 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2012_0001', 'SECRETARIA', 'MATEMATICAS', '', 'ACTIVO', 'M', 'matematicass', '008c9c6db07b7d4b8f2a3ea20c98ebf4', NULL, 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2012_0002', 'ALFREDO', 'DELGADILLO', '', 'ACTIVO', 'M', 'delgadillocossio', 'b20f910687bb8375fd79f585f6a0d6ed', NULL, 'CAR0001');
INSERT INTO usuario (codigo, nombre, ape_paterno, ape_materno, estado, sexo, cuenta, clave, fk_autoridad, fk_carrera) VALUES ('2005_0001', 'MIRIAM LUCY', 'PEÑA', 'CASTILLO', 'ACTIVO', 'F', 'matematicas', 'e0147107f34b9f31cef695f5826ec1fb', NULL, 'CAR0001');


SET search_path = apoyo, pg_catalog;

--
-- TOC entry 2327 (class 2606 OID 41252)
-- Name: pk_variable; Type: CONSTRAINT; Schema: apoyo; Owner: -; Tablespace: 
--

ALTER TABLE ONLY variable
    ADD CONSTRAINT pk_variable PRIMARY KEY (id_variable);


SET search_path = public, pg_catalog;

--
-- TOC entry 2165 (class 2606 OID 40756)
-- Name: actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT actividad_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2167 (class 2606 OID 40758)
-- Name: adhonorem_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adhonorem
    ADD CONSTRAINT adhonorem_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2171 (class 2606 OID 40760)
-- Name: autoridad_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY autoridad
    ADD CONSTRAINT autoridad_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2173 (class 2606 OID 40762)
-- Name: aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aux
    ADD CONSTRAINT aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2175 (class 2606 OID 40764)
-- Name: auxiliar_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auxiliar
    ADD CONSTRAINT auxiliar_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2179 (class 2606 OID 40766)
-- Name: auxiliatura_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auxiliatura
    ADD CONSTRAINT auxiliatura_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2181 (class 2606 OID 40768)
-- Name: bibliografia_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bibliografia
    ADD CONSTRAINT bibliografia_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2183 (class 2606 OID 40770)
-- Name: car_adh_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY car_adh
    ADD CONSTRAINT car_adh_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2185 (class 2606 OID 40772)
-- Name: car_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT car_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2187 (class 2606 OID 40774)
-- Name: cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cargo
    ADD CONSTRAINT cargo_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2189 (class 2606 OID 40776)
-- Name: carrera_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2191 (class 2606 OID 40778)
-- Name: carta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY carta
    ADD CONSTRAINT carta_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2195 (class 2606 OID 40780)
-- Name: categoria_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categoria_aux
    ADD CONSTRAINT categoria_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2199 (class 2606 OID 40782)
-- Name: categoria_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categoria_doc
    ADD CONSTRAINT categoria_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2201 (class 2606 OID 40784)
-- Name: certificado_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT certificado_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2203 (class 2606 OID 40786)
-- Name: combo_box_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY combo_box
    ADD CONSTRAINT combo_box_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2209 (class 2606 OID 40788)
-- Name: curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT curso_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2211 (class 2606 OID 40790)
-- Name: destinatario_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY destinatario
    ADD CONSTRAINT destinatario_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2213 (class 2606 OID 40792)
-- Name: detalle_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY detalle_reserva
    ADD CONSTRAINT detalle_reserva_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2215 (class 2606 OID 40794)
-- Name: dia_res_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dia_res
    ADD CONSTRAINT dia_res_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2217 (class 2606 OID 40796)
-- Name: docente_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY docente
    ADD CONSTRAINT docente_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2219 (class 2606 OID 40798)
-- Name: empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2221 (class 2606 OID 40800)
-- Name: estandarc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY estandarc
    ADD CONSTRAINT estandarc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2223 (class 2606 OID 40802)
-- Name: gestion_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY gestion
    ADD CONSTRAINT gestion_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2225 (class 2606 OID 40804)
-- Name: hist_auxiliatura_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_auxiliatura
    ADD CONSTRAINT hist_auxiliatura_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2227 (class 2606 OID 40806)
-- Name: hist_categoria_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_categoria_doc
    ADD CONSTRAINT hist_categoria_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2229 (class 2606 OID 40808)
-- Name: hist_horario_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_horario_aux
    ADD CONSTRAINT hist_horario_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2231 (class 2606 OID 40810)
-- Name: hist_horario_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_horario_doc
    ADD CONSTRAINT hist_horario_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2233 (class 2606 OID 40812)
-- Name: hist_materia_dicta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT hist_materia_dicta_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2235 (class 2606 OID 40814)
-- Name: hist_materia_labo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_materia_labo
    ADD CONSTRAINT hist_materia_labo_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2237 (class 2606 OID 40816)
-- Name: hist_nombra_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_nombra_aux
    ADD CONSTRAINT hist_nombra_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2239 (class 2606 OID 40818)
-- Name: hist_nombra_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_nombra_doc
    ADD CONSTRAINT hist_nombra_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2241 (class 2606 OID 40820)
-- Name: hist_segui_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_segui_aux
    ADD CONSTRAINT hist_segui_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2243 (class 2606 OID 40822)
-- Name: hist_segui_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hist_segui_doc
    ADD CONSTRAINT hist_segui_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2245 (class 2606 OID 40824)
-- Name: horario_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horario_aux
    ADD CONSTRAINT horario_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2247 (class 2606 OID 40826)
-- Name: horario_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horario_doc
    ADD CONSTRAINT horario_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2249 (class 2606 OID 40828)
-- Name: horas_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horas_aux
    ADD CONSTRAINT horas_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2251 (class 2606 OID 40830)
-- Name: horas_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY horas_doc
    ADD CONSTRAINT horas_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2253 (class 2606 OID 40832)
-- Name: inscritos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inscritos
    ADD CONSTRAINT inscritos_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2255 (class 2606 OID 40834)
-- Name: institucion_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2257 (class 2606 OID 40836)
-- Name: laboratorio_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY laboratorio
    ADD CONSTRAINT laboratorio_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2261 (class 2606 OID 40838)
-- Name: materia_dicta_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT materia_dicta_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2265 (class 2606 OID 40840)
-- Name: materia_labo_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT materia_labo_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2259 (class 2606 OID 40842)
-- Name: materia_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia
    ADD CONSTRAINT materia_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2267 (class 2606 OID 40844)
-- Name: nombra_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nombra_aux
    ADD CONSTRAINT nombra_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2269 (class 2606 OID 40846)
-- Name: nombra_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nombra_doc
    ADD CONSTRAINT nombra_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2271 (class 2606 OID 40848)
-- Name: pga_diagrams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_diagrams
    ADD CONSTRAINT pga_diagrams_pkey PRIMARY KEY (diagramname);


--
-- TOC entry 2273 (class 2606 OID 40850)
-- Name: pga_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_forms
    ADD CONSTRAINT pga_forms_pkey PRIMARY KEY (formname);


--
-- TOC entry 2275 (class 2606 OID 40852)
-- Name: pga_graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_graphs
    ADD CONSTRAINT pga_graphs_pkey PRIMARY KEY (graphname);


--
-- TOC entry 2277 (class 2606 OID 40854)
-- Name: pga_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_images
    ADD CONSTRAINT pga_images_pkey PRIMARY KEY (imagename);


--
-- TOC entry 2279 (class 2606 OID 40856)
-- Name: pga_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_layout
    ADD CONSTRAINT pga_layout_pkey PRIMARY KEY (tablename);


--
-- TOC entry 2281 (class 2606 OID 40858)
-- Name: pga_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_queries
    ADD CONSTRAINT pga_queries_pkey PRIMARY KEY (queryname);


--
-- TOC entry 2283 (class 2606 OID 40860)
-- Name: pga_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_reports
    ADD CONSTRAINT pga_reports_pkey PRIMARY KEY (reportname);


--
-- TOC entry 2285 (class 2606 OID 40862)
-- Name: pga_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pga_scripts
    ADD CONSTRAINT pga_scripts_pkey PRIMARY KEY (scriptname);


--
-- TOC entry 2169 (class 2606 OID 40864)
-- Name: pk_adhonorem_ext; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY adhonorem_ext
    ADD CONSTRAINT pk_adhonorem_ext PRIMARY KEY (fk_adhonorem);


--
-- TOC entry 2177 (class 2606 OID 40866)
-- Name: pk_auxiliar_ext; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auxiliar_ext
    ADD CONSTRAINT pk_auxiliar_ext PRIMARY KEY (fk_auxiliar);


--
-- TOC entry 2193 (class 2606 OID 40868)
-- Name: pk_catalogo_curso; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY catalogo_curso
    ADD CONSTRAINT pk_catalogo_curso PRIMARY KEY (codigo);


--
-- TOC entry 2197 (class 2606 OID 40870)
-- Name: pk_categoria_curso; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categoria_curso
    ADD CONSTRAINT pk_categoria_curso PRIMARY KEY (codigo);


--
-- TOC entry 2205 (class 2606 OID 40872)
-- Name: pk_cprol; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cprol
    ADD CONSTRAINT pk_cprol PRIMARY KEY (codigo);


--
-- TOC entry 2207 (class 2606 OID 40874)
-- Name: pk_cptarea; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cptarea
    ADD CONSTRAINT pk_cptarea PRIMARY KEY (codigo);


--
-- TOC entry 2263 (class 2606 OID 40876)
-- Name: pk_etapa; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materia_dicta_sinonimo
    ADD CONSTRAINT pk_etapa PRIMARY KEY (codigo);


--
-- TOC entry 2289 (class 2606 OID 40878)
-- Name: plan_mat_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT plan_mat_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2287 (class 2606 OID 40880)
-- Name: plan_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2291 (class 2606 OID 40882)
-- Name: prestamo_tesis_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prestamo_tesis
    ADD CONSTRAINT prestamo_tesis_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2293 (class 2606 OID 40884)
-- Name: profesor_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT profesor_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2295 (class 2606 OID 40886)
-- Name: programa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT programa_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2297 (class 2606 OID 40888)
-- Name: rango_res_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rango_res
    ADD CONSTRAINT rango_res_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2299 (class 2606 OID 40890)
-- Name: reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reserva
    ADD CONSTRAINT reserva_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2301 (class 2606 OID 40892)
-- Name: sala_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sala
    ADD CONSTRAINT sala_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2303 (class 2606 OID 40894)
-- Name: segui_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY segui_aux
    ADD CONSTRAINT segui_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2305 (class 2606 OID 40896)
-- Name: segui_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY segui_doc
    ADD CONSTRAINT segui_doc_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2307 (class 2606 OID 40898)
-- Name: sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sesion
    ADD CONSTRAINT sesion_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2309 (class 2606 OID 40900)
-- Name: temp_aux_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_aux
    ADD CONSTRAINT temp_aux_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2311 (class 2606 OID 40902)
-- Name: temp_cert_curso_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_cert_curso
    ADD CONSTRAINT temp_cert_curso_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2313 (class 2606 OID 40904)
-- Name: temp_destinatario_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_destinatario
    ADD CONSTRAINT temp_destinatario_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2315 (class 2606 OID 40906)
-- Name: temp_detalle_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_detalle_reserva
    ADD CONSTRAINT temp_detalle_reserva_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2317 (class 2606 OID 40908)
-- Name: temp_validar_hor_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY temp_validar_hor
    ADD CONSTRAINT temp_validar_hor_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2319 (class 2606 OID 40910)
-- Name: tesis_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tesis
    ADD CONSTRAINT tesis_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2321 (class 2606 OID 40912)
-- Name: tesista_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tesista
    ADD CONSTRAINT tesista_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2323 (class 2606 OID 40914)
-- Name: titulo_adic_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY titulo_adic
    ADD CONSTRAINT titulo_adic_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2325 (class 2606 OID 40916)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2338 (class 2606 OID 40917)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cargo
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_laboratorio) REFERENCES laboratorio(codigo);


--
-- TOC entry 2336 (class 2606 OID 40922)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2379 (class 2606 OID 40927)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_carrera) REFERENCES carrera(codigo);


--
-- TOC entry 2380 (class 2606 OID 40932)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_plan) REFERENCES plan(codigo);


--
-- TOC entry 2376 (class 2606 OID 40937)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nombra_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2345 (class 2606 OID 40942)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_doc) REFERENCES nombra_doc(codigo);


--
-- TOC entry 2389 (class 2606 OID 40947)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY segui_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2367 (class 2606 OID 40952)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_doc) REFERENCES segui_doc(codigo);


--
-- TOC entry 2366 (class 2606 OID 40957)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_rangos_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_horario_doc) REFERENCES horario_doc(codigo);


--
-- TOC entry 2362 (class 2606 OID 40962)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2355 (class 2606 OID 40967)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_categoria_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_doc) REFERENCES hist_nombra_doc(codigo);


--
-- TOC entry 2364 (class 2606 OID 40972)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_doc
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2356 (class 2606 OID 40977)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_doc) REFERENCES hist_segui_doc(codigo);


--
-- TOC entry 2375 (class 2606 OID 40982)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nombra_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2344 (class 2606 OID 40987)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES nombra_aux(codigo);


--
-- TOC entry 2332 (class 2606 OID 40992)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliatura
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES nombra_aux(codigo);


--
-- TOC entry 2388 (class 2606 OID 40997)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY segui_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2371 (class 2606 OID 41002)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_aux) REFERENCES segui_aux(codigo);


--
-- TOC entry 2365 (class 2606 OID 41007)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY horario_rangos_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_horario_aux) REFERENCES horario_aux(codigo);


--
-- TOC entry 2361 (class 2606 OID 41012)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_nombra_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2354 (class 2606 OID 41017)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_auxiliatura
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_nombra_aux) REFERENCES hist_nombra_aux(codigo);


--
-- TOC entry 2363 (class 2606 OID 41022)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_segui_aux
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2359 (class 2606 OID 41027)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_labo
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_segui_aux) REFERENCES hist_segui_aux(codigo);


--
-- TOC entry 2391 (class 2606 OID 41032)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tesista
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_tesis) REFERENCES tesis(codigo);


--
-- TOC entry 2384 (class 2606 OID 41037)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prestamo_tesis
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_tesis) REFERENCES tesis(codigo);


--
-- TOC entry 2334 (class 2606 OID 41042)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_adh
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2330 (class 2606 OID 41047)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY autoridad
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2328 (class 2606 OID 41052)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actividad
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2346 (class 2606 OID 41057)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_aux) REFERENCES aux(codigo);


--
-- TOC entry 2352 (class 2606 OID 41062)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_profesor) REFERENCES profesor(codigo);


--
-- TOC entry 2377 (class 2606 OID 41067)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nota
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_curso) REFERENCES curso(codigo);


--
-- TOC entry 2386 (class 2606 OID 41072)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remitente
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_estandar) REFERENCES estandarc(codigo);


--
-- TOC entry 2339 (class 2606 OID 41077)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_estandarc) REFERENCES estandarc(codigo);


--
-- TOC entry 2340 (class 2606 OID 41082)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta_dest
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_docente) REFERENCES docente(codigo);


--
-- TOC entry 2385 (class 2606 OID 41087)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY programa
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2390 (class 2606 OID 41092)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_programa) REFERENCES programa(codigo);


--
-- TOC entry 2333 (class 2606 OID 41097)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bibliografia
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_programa) REFERENCES programa(codigo);


--
-- TOC entry 2382 (class 2606 OID 41102)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prerequisito
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2392 (class 2606 OID 41107)
-- Name: $1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titulo_curso
    ADD CONSTRAINT "$1" FOREIGN KEY (fk_titulo) REFERENCES titulo_adic(codigo);


--
-- TOC entry 2337 (class 2606 OID 41112)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_aux
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo);


--
-- TOC entry 2381 (class 2606 OID 41117)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY plan_mat
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2368 (class 2606 OID 41122)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_doc) REFERENCES nombra_doc(codigo);


--
-- TOC entry 2357 (class 2606 OID 41127)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_doc) REFERENCES hist_nombra_doc(codigo);


--
-- TOC entry 2372 (class 2606 OID 41132)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_aux) REFERENCES nombra_aux(codigo);


--
-- TOC entry 2360 (class 2606 OID 41137)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_labo
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_nombra_aux) REFERENCES hist_nombra_aux(codigo);


--
-- TOC entry 2335 (class 2606 OID 41142)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_adh
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_adhonorem) REFERENCES adhonorem(codigo);


--
-- TOC entry 2347 (class 2606 OID 41147)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY certificado
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_autoridad) REFERENCES autoridad(codigo);


--
-- TOC entry 2393 (class 2606 OID 41152)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY titulo_curso
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_curso) REFERENCES curso(codigo);


--
-- TOC entry 2378 (class 2606 OID 41157)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nota
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_inscritos) REFERENCES inscritos(codigo);


--
-- TOC entry 2387 (class 2606 OID 41162)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY remitente
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_cargo) REFERENCES cargo(codigo);


--
-- TOC entry 2341 (class 2606 OID 41167)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta_dest
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_destinatario) REFERENCES destinatario(codigo);


--
-- TOC entry 2383 (class 2606 OID 41172)
-- Name: $2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prerequisito
    ADD CONSTRAINT "$2" FOREIGN KEY (fk_pre_materia) REFERENCES materia(codigo);


--
-- TOC entry 2369 (class 2606 OID 41177)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2358 (class 2606 OID 41182)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hist_materia_dicta
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2373 (class 2606 OID 41187)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_materia) REFERENCES materia(codigo);


--
-- TOC entry 2342 (class 2606 OID 41192)
-- Name: $3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carta_dest
    ADD CONSTRAINT "$3" FOREIGN KEY (fk_carta) REFERENCES carta(codigo);


--
-- TOC entry 2374 (class 2606 OID 41197)
-- Name: $4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_labo
    ADD CONSTRAINT "$4" FOREIGN KEY (fk_laboratorio) REFERENCES laboratorio(codigo);


--
-- TOC entry 2329 (class 2606 OID 41202)
-- Name: fk_adh_ext_reference_adhonorem; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY adhonorem_ext
    ADD CONSTRAINT fk_adh_ext_reference_adhonorem FOREIGN KEY (fk_adhonorem) REFERENCES adhonorem(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2331 (class 2606 OID 41207)
-- Name: fk_aux_ext_reference_auxiliar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auxiliar_ext
    ADD CONSTRAINT fk_aux_ext_reference_auxiliar FOREIGN KEY (fk_auxiliar) REFERENCES auxiliar(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2343 (class 2606 OID 41212)
-- Name: fk_cat_cur_reference_catalogo_curso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY catalogo_curso
    ADD CONSTRAINT fk_cat_cur_reference_catalogo_curso FOREIGN KEY (fk_categoria_curso) REFERENCES categoria_curso(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2353 (class 2606 OID 41217)
-- Name: fk_cat_cur_reference_catalogo_curso; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY curso
    ADD CONSTRAINT fk_cat_cur_reference_catalogo_curso FOREIGN KEY (fk_catalogo_curso) REFERENCES catalogo_curso(codigo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2370 (class 2606 OID 41222)
-- Name: fk_mat_dicta_sinonimo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materia_dicta_sinonimo
    ADD CONSTRAINT fk_mat_dicta_sinonimo FOREIGN KEY (fk_materia_dicta) REFERENCES materia_dicta(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2350 (class 2606 OID 41227)
-- Name: tiene1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT tiene1 FOREIGN KEY (fk_codigo_rol) REFERENCES cprol(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2348 (class 2606 OID 41232)
-- Name: tiene1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT tiene1 FOREIGN KEY (fk_codigo_rol) REFERENCES cprol(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2351 (class 2606 OID 41237)
-- Name: tiene2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cptareas_rol
    ADD CONSTRAINT tiene2 FOREIGN KEY (fk_codigo_tarea) REFERENCES cptarea(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2349 (class 2606 OID 41242)
-- Name: tiene2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cproles_usuario
    ADD CONSTRAINT tiene2 FOREIGN KEY (fk_codigo_usr) REFERENCES usuario(codigo) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-12-13 08:44:50 BOT

--
-- PostgreSQL database dump complete
--

