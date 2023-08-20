--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-08-20 16:25:37

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
-- TOC entry 5 (class 2615 OID 24576)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 231 (class 1255 OID 24577)
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
-- TOC entry 232 (class 1255 OID 24578)
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
-- TOC entry 233 (class 1255 OID 24579)
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
-- TOC entry 236 (class 1255 OID 24995)
-- Name: isclient(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.isclient(text, text) RETURNS boolean
    LANGUAGE plpgsql
    AS '
	declare f_login alias for $1;
	declare f_password alias for $2;
	declare id integer;
	declare retour integer;
begin
	select into id id_client from client where email=f_login and password=f_password;
	if not found
	then
	  retour=0;
	else
	  retour=1;
	end if;
	return retour;
end;
';


--
-- TOC entry 234 (class 1255 OID 24580)
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
-- TOC entry 235 (class 1255 OID 24581)
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
-- TOC entry 214 (class 1259 OID 24582)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login text,
    password text
);


--
-- TOC entry 215 (class 1259 OID 24587)
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 215
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 216 (class 1259 OID 24588)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client character varying(50),
    prenom_client character varying(50),
    email character varying(50),
    nom_rue character varying(50),
    numero_porte integer,
    id_ville integer NOT NULL,
    password character varying(50) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 24591)
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
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 217
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 228 (class 1259 OID 25017)
-- Name: commande; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commande (
    id_commande integer NOT NULL,
    prix_total real,
    livree character varying(50),
    id_client integer NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 25042)
-- Name: commande_id_commande_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commande_id_commande_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 230
-- Name: commande_id_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;


--
-- TOC entry 229 (class 1259 OID 25027)
-- Name: detail; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detail (
    id_pizza integer NOT NULL,
    id_commande integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 24596)
-- Name: ingredient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ingredient (
    id_ingredient integer NOT NULL,
    nom_ingredient character varying(50)
);


--
-- TOC entry 219 (class 1259 OID 24599)
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
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 219
-- Name: ingrédients_id_ingrédients_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."ingrédients_id_ingrédients_seq" OWNED BY public.ingredient.id_ingredient;


--
-- TOC entry 220 (class 1259 OID 24600)
-- Name: pizza; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pizza (
    id_pizza integer NOT NULL,
    nom_pizza character varying(50),
    prix real
);


--
-- TOC entry 221 (class 1259 OID 24603)
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
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 221
-- Name: pizza_id_pizza_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pizza_id_pizza_seq OWNED BY public.pizza.id_pizza;


--
-- TOC entry 226 (class 1259 OID 24970)
-- Name: possede; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.possede (
    id_pizza integer NOT NULL,
    id_ingredient integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 24989)
-- Name: pizzaid_ingredient; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.pizzaid_ingredient AS
 SELECT p.id_pizza,
    p.id_ingredient,
    i.nom_ingredient
   FROM (public.possede p
     JOIN public.ingredient i ON ((i.id_ingredient = p.id_ingredient)));


--
-- TOC entry 222 (class 1259 OID 24607)
-- Name: province; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.province (
    id_province integer NOT NULL,
    nom_province character varying(50)
);


--
-- TOC entry 223 (class 1259 OID 24610)
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
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 223
-- Name: province_id_province_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.province_id_province_seq OWNED BY public.province.id_province;


--
-- TOC entry 224 (class 1259 OID 24611)
-- Name: ville; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ville (
    id_ville integer NOT NULL,
    code_postal integer,
    nom_ville character varying(50),
    id_province integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 24614)
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
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 225
-- Name: ville_id_ville_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ville_id_ville_seq OWNED BY public.ville.id_ville;


--
-- TOC entry 3221 (class 2604 OID 24615)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 3226 (class 2604 OID 25043)
-- Name: commande id_commande; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande ALTER COLUMN id_commande SET DEFAULT nextval('public.commande_id_commande_seq'::regclass);


--
-- TOC entry 3222 (class 2604 OID 24616)
-- Name: ingredient id_ingredient; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredient ALTER COLUMN id_ingredient SET DEFAULT nextval('public."ingrédients_id_ingrédients_seq"'::regclass);


--
-- TOC entry 3223 (class 2604 OID 24617)
-- Name: pizza id_pizza; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizza ALTER COLUMN id_pizza SET DEFAULT nextval('public.pizza_id_pizza_seq'::regclass);


--
-- TOC entry 3224 (class 2604 OID 24618)
-- Name: province id_province; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province ALTER COLUMN id_province SET DEFAULT nextval('public.province_id_province_seq'::regclass);


--
-- TOC entry 3225 (class 2604 OID 24619)
-- Name: ville id_ville; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville ALTER COLUMN id_ville SET DEFAULT nextval('public.ville_id_ville_seq'::regclass);


--
-- TOC entry 3395 (class 0 OID 24582)
-- Dependencies: 214
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (id_admin, login, password) VALUES (1, 'admin', 'admin');


--
-- TOC entry 3397 (class 0 OID 24588)
-- Dependencies: 216
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client (id_client, nom_client, prenom_client, email, nom_rue, numero_porte, id_ville, password) VALUES (9, 'Tonda', 'Noah', 'noahtonda@hotmail.com', 'Wache', 3, 23, 'wxcvbn03');
INSERT INTO public.client (id_client, nom_client, prenom_client, email, nom_rue, numero_porte, id_ville, password) VALUES (10, 'Tonda', 'Noah', 'noahtonda@gmail.com', 'rue de Bouvy', 50, 24, 'wxcvbn03');
INSERT INTO public.client (id_client, nom_client, prenom_client, email, nom_rue, numero_porte, id_ville, password) VALUES (11, 'Tonda', 'Terence', 'terencetonda@hotmail.com', 'Wache', 3, 23, '123');


--
-- TOC entry 3408 (class 0 OID 25017)
-- Dependencies: 228
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.commande (id_commande, prix_total, livree, id_client) VALUES (4, 33, 'oui', 9);
INSERT INTO public.commande (id_commande, prix_total, livree, id_client) VALUES (9, 23.5, 'non', 9);


--
-- TOC entry 3409 (class 0 OID 25027)
-- Dependencies: 229
-- Data for Name: detail; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.detail (id_pizza, id_commande) VALUES (67, 4);
INSERT INTO public.detail (id_pizza, id_commande) VALUES (68, 4);
INSERT INTO public.detail (id_pizza, id_commande) VALUES (69, 4);
INSERT INTO public.detail (id_pizza, id_commande) VALUES (66, 4);
INSERT INTO public.detail (id_pizza, id_commande) VALUES (70, 9);
INSERT INTO public.detail (id_pizza, id_commande) VALUES (67, 9);
INSERT INTO public.detail (id_pizza, id_commande) VALUES (66, 9);


--
-- TOC entry 3399 (class 0 OID 24596)
-- Dependencies: 218
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (8, 'Anchois');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (12, 'Tomate');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (13, 'Basilic');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (14, 'Buffala');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (15, 'Bolognese');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (16, 'Taleggio');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (17, 'Gorgonzola');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (18, 'Parmesan');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (22, 'Salami');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (23, 'Artichauts');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (24, 'Origan');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (6, 'Champignon');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (2, 'Mozzarella');
INSERT INTO public.ingredient (id_ingredient, nom_ingredient) VALUES (3, 'Jambon');


--
-- TOC entry 3401 (class 0 OID 24600)
-- Dependencies: 220
-- Data for Name: pizza; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (66, 'Margherita', 7);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (67, 'Prosciutto', 8);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (68, '4 Fromages', 9);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (69, '4 Saisons', 9);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (70, 'Bolognese', 8.5);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (71, 'Calzone', 8.5);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (72, 'Capricciosa', 8);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (73, 'Napoli', 8);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (74, 'Carciofina', 9);
INSERT INTO public.pizza (id_pizza, nom_pizza, prix) VALUES (75, 'Bufala', 10.5);


--
-- TOC entry 3407 (class 0 OID 24970)
-- Dependencies: 226
-- Data for Name: possede; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (66, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (66, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (66, 13);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (67, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (67, 3);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (67, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (68, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (68, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (68, 16);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (68, 17);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (68, 18);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (69, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (69, 3);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (69, 6);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (69, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (69, 22);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (69, 23);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (70, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (70, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (70, 15);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (71, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (71, 3);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (71, 6);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (71, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (71, 22);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (72, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (72, 3);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (72, 6);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (72, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (73, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (73, 8);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (73, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (73, 24);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (74, 2);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (74, 3);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (74, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (74, 23);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (74, 24);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (75, 12);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (75, 13);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (75, 14);
INSERT INTO public.possede (id_pizza, id_ingredient) VALUES (75, 18);


--
-- TOC entry 3403 (class 0 OID 24607)
-- Dependencies: 222
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.province (id_province, nom_province) VALUES (1, 'Namur
');
INSERT INTO public.province (id_province, nom_province) VALUES (4, 'Hainaut');


--
-- TOC entry 3405 (class 0 OID 24611)
-- Dependencies: 224
-- Data for Name: ville; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.ville (id_ville, code_postal, nom_ville, id_province) VALUES (16, 5000, 'Namur', 1);
INSERT INTO public.ville (id_ville, code_postal, nom_ville, id_province) VALUES (23, 7110, 'Houdeng-goegnies', 4);
INSERT INTO public.ville (id_ville, code_postal, nom_ville, id_province) VALUES (24, 7100, 'La Louvière', 4);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 215
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, false);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 217
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_client_seq', 11, true);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 230
-- Name: commande_id_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commande_id_commande_seq', 11, true);


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 219
-- Name: ingrédients_id_ingrédients_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."ingrédients_id_ingrédients_seq"', 35, true);


--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 221
-- Name: pizza_id_pizza_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pizza_id_pizza_seq', 75, true);


--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 223
-- Name: province_id_province_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.province_id_province_seq', 4, true);


--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 225
-- Name: ville_id_ville_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ville_id_ville_seq', 24, true);


--
-- TOC entry 3228 (class 2606 OID 24621)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 3230 (class 2606 OID 24623)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 3242 (class 2606 OID 25021)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id_commande);


--
-- TOC entry 3244 (class 2606 OID 25031)
-- Name: detail detail_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT detail_pkey PRIMARY KEY (id_pizza, id_commande);


--
-- TOC entry 3232 (class 2606 OID 24629)
-- Name: ingredient ingrédients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT "ingrédients_pkey" PRIMARY KEY (id_ingredient);


--
-- TOC entry 3234 (class 2606 OID 24631)
-- Name: pizza pizza_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pizza
    ADD CONSTRAINT pizza_pkey PRIMARY KEY (id_pizza);


--
-- TOC entry 3240 (class 2606 OID 24974)
-- Name: possede possede_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possede
    ADD CONSTRAINT possede_pkey PRIMARY KEY (id_pizza, id_ingredient);


--
-- TOC entry 3236 (class 2606 OID 24635)
-- Name: province province_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id_province);


--
-- TOC entry 3238 (class 2606 OID 24637)
-- Name: ville ville_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_pkey PRIMARY KEY (id_ville);


--
-- TOC entry 3245 (class 2606 OID 24638)
-- Name: client client_id_ville_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);


--
-- TOC entry 3249 (class 2606 OID 25022)
-- Name: commande commande_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 3250 (class 2606 OID 25037)
-- Name: detail detail_id_commande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT detail_id_commande_fkey FOREIGN KEY (id_commande) REFERENCES public.commande(id_commande);


--
-- TOC entry 3251 (class 2606 OID 25032)
-- Name: detail detail_id_pizza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT detail_id_pizza_fkey FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);


--
-- TOC entry 3247 (class 2606 OID 24980)
-- Name: possede possede_id_ingredient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possede
    ADD CONSTRAINT possede_id_ingredient_fkey FOREIGN KEY (id_ingredient) REFERENCES public.ingredient(id_ingredient);


--
-- TOC entry 3248 (class 2606 OID 24975)
-- Name: possede possede_id_pizza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possede
    ADD CONSTRAINT possede_id_pizza_fkey FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);


--
-- TOC entry 3246 (class 2606 OID 24663)
-- Name: ville ville_id_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_id_province_fkey FOREIGN KEY (id_province) REFERENCES public.province(id_province);


-- Completed on 2023-08-20 16:25:37

--
-- PostgreSQL database dump complete
--

