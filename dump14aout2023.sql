--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-08-14 15:21:27

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 231 (class 1255 OID 41480)
-- Name: ajout_pizza(text, real); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_pizza(text, real) RETURNS integer
    LANGUAGE plpgsql
    AS '
declare
  id integer;
  retour integer;
begin
  id=NULL;
  select into id id_pizza from pizza where nom_pizza=$1;
  IF not found
  THEN
    insert into pizza (nom_pizza,prix) values
    ($1,$2);
    retour=1;
    select into id id_pizza from pizza where nom_pizza=$1;
    IF id ISNULL
    THEN
      retour=0;
    END if;
  ELSE 
    retour=0;
  END IF;
  return retour;
end;
';


--
-- TOC entry 232 (class 1255 OID 41481)
-- Name: delete_pizza(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_pizza(integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_id_pizza alias for $1;
	declare id integer;
begin
	delete from pizza where id_pizza=f_id_pizza;
	return 1;
end';


--
-- TOC entry 229 (class 1255 OID 41469)
-- Name: isadmin(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.isadmin(text, text) RETURNS boolean
    LANGUAGE plpgsql
    AS '
declare p_login alias for $1; 
declare p_password alias for $2;
declare id integer;
declare retour boolean;

begin
  select into id id_admin from admin where login = p_login and password = p_password;
  if not found
  then
    retour = false;
  else
    retour = true;
  end if;
  return retour;
end;
';


--
-- TOC entry 233 (class 1255 OID 41484)
-- Name: modif_pizza(integer, text, real); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.modif_pizza(integer, text, real) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare f_id_pizza alias for $1;
	declare f_nom_pizza alias for $2;
	declare f_prix alias for $3;
	declare retour integer;
	declare id integer;
begin
	select into id id_pizza from pizza where id_pizza=f_id_pizza;
	IF NOT FOUND
	THEN
	  retour=0;
	ELSE
	  update pizza set nom_pizza=f_nom_pizza,prix=f_prix where id_pizza=f_id_pizza;
	  retour=1;
	END IF;
	return retour;

end;';


--
-- TOC entry 230 (class 1255 OID 41470)
-- Name: verifier_connexion(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.verifier_connexion(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '	declare f_login alias for $1;
	declare f_password alias for $2;
	declare id integer;
	declare retour integer;
begin
	select into id id_admin from admin where login=f_login and password=f_password;
	if not found
	then
	  retour=0;
	else
	  retour=1;
	end if;
	return retour;
end;
';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 227 (class 1259 OID 41472)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login text,
    password text
);


--
-- TOC entry 226 (class 1259 OID 41471)
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 226
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 223 (class 1259 OID 25186)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client character varying(50),
    prenom_client character varying(50),
    email character varying(50),
    nom_rue character varying(50),
    numero_porte integer,
    id_ville integer NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 25185)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 222
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 225 (class 1259 OID 25212)
-- Name: commande; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commande (
    id_pizza integer NOT NULL,
    id_client integer NOT NULL,
    numero_commande integer NOT NULL,
    prix real,
    livree character varying(50)
);


--
-- TOC entry 228 (class 1259 OID 41479)
-- Name: commande_is_commande_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commande_is_commande_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 228
-- Name: commande_is_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commande_is_commande_seq OWNED BY public.commande.numero_commande;


--
-- TOC entry 217 (class 1259 OID 25160)
-- Name: ingrédients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ingrédients" (
    "id_ingrédients" integer NOT NULL,
    "nom_ingrédient" character varying(50),
    provenance character varying(50)
);


--
-- TOC entry 216 (class 1259 OID 25159)
-- Name: ingrédients_id_ingrédients_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."ingrédients_id_ingrédients_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 216
-- Name: ingrédients_id_ingrédients_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."ingrédients_id_ingrédients_seq" OWNED BY public."ingrédients"."id_ingrédients";


--
-- TOC entry 215 (class 1259 OID 25153)
-- Name: pizza; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pizza (
    id_pizza integer NOT NULL,
    nom_pizza character varying(50),
    prix real
);


--
-- TOC entry 214 (class 1259 OID 25152)
-- Name: pizza_id_pizza_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pizza_id_pizza_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 214
-- Name: pizza_id_pizza_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pizza_id_pizza_seq OWNED BY public.pizza.id_pizza;


--
-- TOC entry 224 (class 1259 OID 25197)
-- Name: possède; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."possède" (
    id_pizza integer NOT NULL,
    "id_ingrédients" integer NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 25167)
-- Name: province; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.province (
    id_province integer NOT NULL,
    nom_province character varying(50)
);


--
-- TOC entry 218 (class 1259 OID 25166)
-- Name: province_id_province_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.province_id_province_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 218
-- Name: province_id_province_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.province_id_province_seq OWNED BY public.province.id_province;


--
-- TOC entry 221 (class 1259 OID 25174)
-- Name: ville; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ville (
    id_ville integer NOT NULL,
    code_postal integer,
    nom_ville character varying(50),
    id_province integer NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 25173)
-- Name: ville_id_ville_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ville_id_ville_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 220
-- Name: ville_id_ville_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ville_id_ville_seq OWNED BY public.ville.id_ville;


--
-- TOC entry 3216 (class 2604 OID 25189)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 3213 (class 2604 OID 25163)
-- Name: ingrédients id_ingrédients; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ingrédients" ALTER COLUMN "id_ingrédients" SET DEFAULT nextval('public."ingrédients_id_ingrédients_seq"'::regclass);


--
-- TOC entry 3212 (class 2604 OID 25156)
-- Name: pizza id_pizza; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizza ALTER COLUMN id_pizza SET DEFAULT nextval('public.pizza_id_pizza_seq'::regclass);


--
-- TOC entry 3214 (class 2604 OID 25170)
-- Name: province id_province; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province ALTER COLUMN id_province SET DEFAULT nextval('public.province_id_province_seq'::regclass);


--
-- TOC entry 3215 (class 2604 OID 25177)
-- Name: ville id_ville; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville ALTER COLUMN id_ville SET DEFAULT nextval('public.ville_id_ville_seq'::regclass);


--
-- TOC entry 3396 (class 0 OID 41472)
-- Dependencies: 227
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (id_admin, login, password) VALUES (1, 'admin', 'admin');


--
-- TOC entry 3392 (class 0 OID 25186)
-- Dependencies: 223
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3394 (class 0 OID 25212)
-- Dependencies: 225
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3386 (class 0 OID 25160)
-- Dependencies: 217
-- Data for Name: ingrédients; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3384 (class 0 OID 25153)
-- Dependencies: 215
-- Data for Name: pizza; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (5, 'aaaaaa', 10);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (4, 'test', 2);


--
-- TOC entry 3393 (class 0 OID 25197)
-- Dependencies: 224
-- Data for Name: possède; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3388 (class 0 OID 25167)
-- Dependencies: 219
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3390 (class 0 OID 25174)
-- Dependencies: 221
-- Data for Name: ville; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 226
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, false);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 222
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_client_seq', 1, false);


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 228
-- Name: commande_is_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commande_is_commande_seq', 1, false);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 216
-- Name: ingrédients_id_ingrédients_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."ingrédients_id_ingrédients_seq"', 1, false);


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 214
-- Name: pizza_id_pizza_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pizza_id_pizza_seq', 5, true);


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 218
-- Name: province_id_province_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.province_id_province_seq', 1, false);


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 220
-- Name: ville_id_ville_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ville_id_ville_seq', 1, false);


--
-- TOC entry 3234 (class 2606 OID 41478)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 3226 (class 2606 OID 25191)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 3230 (class 2606 OID 25218)
-- Name: commande commande_numero_commande_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_numero_commande_key UNIQUE (numero_commande);


--
-- TOC entry 3232 (class 2606 OID 25216)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id_pizza, id_client);


--
-- TOC entry 3220 (class 2606 OID 25165)
-- Name: ingrédients ingrédients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ingrédients"
    ADD CONSTRAINT "ingrédients_pkey" PRIMARY KEY ("id_ingrédients");


--
-- TOC entry 3218 (class 2606 OID 25158)
-- Name: pizza pizza_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizza
    ADD CONSTRAINT pizza_pkey PRIMARY KEY (id_pizza);


--
-- TOC entry 3228 (class 2606 OID 25201)
-- Name: possède possède_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."possède"
    ADD CONSTRAINT "possède_pkey" PRIMARY KEY (id_pizza, "id_ingrédients");


--
-- TOC entry 3222 (class 2606 OID 25172)
-- Name: province province_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id_province);


--
-- TOC entry 3224 (class 2606 OID 25179)
-- Name: ville ville_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_pkey PRIMARY KEY (id_ville);


--
-- TOC entry 3236 (class 2606 OID 25192)
-- Name: client client_id_ville_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);


--
-- TOC entry 3239 (class 2606 OID 25224)
-- Name: commande commande_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 3240 (class 2606 OID 25219)
-- Name: commande commande_id_pizza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_pizza_fkey FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);


--
-- TOC entry 3237 (class 2606 OID 25207)
-- Name: possède possède_id_ingrédients_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."possède"
    ADD CONSTRAINT "possède_id_ingrédients_fkey" FOREIGN KEY ("id_ingrédients") REFERENCES public."ingrédients"("id_ingrédients");


--
-- TOC entry 3238 (class 2606 OID 25202)
-- Name: possède possède_id_pizza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."possède"
    ADD CONSTRAINT "possède_id_pizza_fkey" FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);


--
-- TOC entry 3235 (class 2606 OID 25180)
-- Name: ville ville_id_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_id_province_fkey FOREIGN KEY (id_province) REFERENCES public.province(id_province);


-- Completed on 2023-08-14 15:21:27

--
-- PostgreSQL database dump complete
--

