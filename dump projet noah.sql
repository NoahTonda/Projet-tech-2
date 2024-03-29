PGDMP     .                    {           Projet    15.1    15.1 D    H           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            I           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            J           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            K           1262    25084    Projet    DATABASE     {   CREATE DATABASE "Projet" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE "Projet";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            L           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1255    41480    ajout_pizza(text, real)    FUNCTION     �  CREATE FUNCTION public.ajout_pizza(text, real) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
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
$_$;
 .   DROP FUNCTION public.ajout_pizza(text, real);
       public          postgres    false    4            �            1255    41481    delete_pizza(integer)    FUNCTION     �   CREATE FUNCTION public.delete_pizza(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare p_id_pizza alias for $1;
	declare id integer;
begin
	delete from pizza where id_pizza=f_id_pizza;
	return 1;
end$_$;
 ,   DROP FUNCTION public.delete_pizza(integer);
       public          postgres    false    4            �            1255    41469    isadmin(text, text)    FUNCTION     �  CREATE FUNCTION public.isadmin(text, text) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
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
$_$;
 *   DROP FUNCTION public.isadmin(text, text);
       public          postgres    false    4            �            1255    41484     modif_pizza(integer, text, real)    FUNCTION     �  CREATE FUNCTION public.modif_pizza(integer, text, real) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
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

end;$_$;
 7   DROP FUNCTION public.modif_pizza(integer, text, real);
       public          postgres    false    4            �            1255    41470    verifier_connexion(text, text)    FUNCTION     �  CREATE FUNCTION public.verifier_connexion(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$	declare f_login alias for $1;
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
$_$;
 5   DROP FUNCTION public.verifier_connexion(text, text);
       public          postgres    false    4            �            1259    41472    admin    TABLE     `   CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login text,
    password text
);
    DROP TABLE public.admin;
       public         heap    postgres    false    4            �            1259    41471    admin_id_admin_seq    SEQUENCE     {   CREATE SEQUENCE public.admin_id_admin_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.admin_id_admin_seq;
       public          postgres    false    227    4            M           0    0    admin_id_admin_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;
          public          postgres    false    226            �            1259    25186    client    TABLE       CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client character varying(50),
    prenom_client character varying(50),
    email character varying(50),
    nom_rue character varying(50),
    numero_porte integer,
    id_ville integer NOT NULL
);
    DROP TABLE public.client;
       public         heap    postgres    false    4            �            1259    25185    client_id_client_seq    SEQUENCE     �   CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.client_id_client_seq;
       public          postgres    false    223    4            N           0    0    client_id_client_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;
          public          postgres    false    222            �            1259    25212    commande    TABLE     �   CREATE TABLE public.commande (
    id_pizza integer NOT NULL,
    id_client integer NOT NULL,
    numero_commande integer NOT NULL,
    prix real,
    livree character varying(50)
);
    DROP TABLE public.commande;
       public         heap    postgres    false    4            �            1259    41479    commande_is_commande_seq    SEQUENCE     �   CREATE SEQUENCE public.commande_is_commande_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.commande_is_commande_seq;
       public          postgres    false    225    4            O           0    0    commande_is_commande_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.commande_is_commande_seq OWNED BY public.commande.numero_commande;
          public          postgres    false    228            �            1259    25160    ingrédients    TABLE     �   CREATE TABLE public."ingrédients" (
    "id_ingrédients" integer NOT NULL,
    "nom_ingrédient" character varying(50),
    provenance character varying(50)
);
 "   DROP TABLE public."ingrédients";
       public         heap    postgres    false    4            �            1259    25159     ingrédients_id_ingrédients_seq    SEQUENCE     �   CREATE SEQUENCE public."ingrédients_id_ingrédients_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."ingrédients_id_ingrédients_seq";
       public          postgres    false    217    4            P           0    0     ingrédients_id_ingrédients_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."ingrédients_id_ingrédients_seq" OWNED BY public."ingrédients"."id_ingrédients";
          public          postgres    false    216            �            1259    25153    pizza    TABLE     q   CREATE TABLE public.pizza (
    id_pizza integer NOT NULL,
    nom_pizza character varying(50),
    prix real
);
    DROP TABLE public.pizza;
       public         heap    postgres    false    4            �            1259    25152    pizza_id_pizza_seq    SEQUENCE     �   CREATE SEQUENCE public.pizza_id_pizza_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.pizza_id_pizza_seq;
       public          postgres    false    4    215            Q           0    0    pizza_id_pizza_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.pizza_id_pizza_seq OWNED BY public.pizza.id_pizza;
          public          postgres    false    214            �            1259    25197    possède    TABLE     j   CREATE TABLE public."possède" (
    id_pizza integer NOT NULL,
    "id_ingrédients" integer NOT NULL
);
    DROP TABLE public."possède";
       public         heap    postgres    false    4            �            1259    25167    province    TABLE     k   CREATE TABLE public.province (
    id_province integer NOT NULL,
    nom_province character varying(50)
);
    DROP TABLE public.province;
       public         heap    postgres    false    4            �            1259    25166    province_id_province_seq    SEQUENCE     �   CREATE SEQUENCE public.province_id_province_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.province_id_province_seq;
       public          postgres    false    219    4            R           0    0    province_id_province_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.province_id_province_seq OWNED BY public.province.id_province;
          public          postgres    false    218            �            1259    25174    ville    TABLE     �   CREATE TABLE public.ville (
    id_ville integer NOT NULL,
    code_postal integer,
    nom_ville character varying(50),
    id_province integer NOT NULL
);
    DROP TABLE public.ville;
       public         heap    postgres    false    4            �            1259    25173    ville_id_ville_seq    SEQUENCE     �   CREATE SEQUENCE public.ville_id_ville_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.ville_id_ville_seq;
       public          postgres    false    221    4            S           0    0    ville_id_ville_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.ville_id_ville_seq OWNED BY public.ville.id_ville;
          public          postgres    false    220            �           2604    25189    client id_client    DEFAULT     t   ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);
 ?   ALTER TABLE public.client ALTER COLUMN id_client DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    25163    ingrédients id_ingrédients    DEFAULT     �   ALTER TABLE ONLY public."ingrédients" ALTER COLUMN "id_ingrédients" SET DEFAULT nextval('public."ingrédients_id_ingrédients_seq"'::regclass);
 O   ALTER TABLE public."ingrédients" ALTER COLUMN "id_ingrédients" DROP DEFAULT;
       public          postgres    false    217    216    217            �           2604    25156    pizza id_pizza    DEFAULT     p   ALTER TABLE ONLY public.pizza ALTER COLUMN id_pizza SET DEFAULT nextval('public.pizza_id_pizza_seq'::regclass);
 =   ALTER TABLE public.pizza ALTER COLUMN id_pizza DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    25170    province id_province    DEFAULT     |   ALTER TABLE ONLY public.province ALTER COLUMN id_province SET DEFAULT nextval('public.province_id_province_seq'::regclass);
 C   ALTER TABLE public.province ALTER COLUMN id_province DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    25177    ville id_ville    DEFAULT     p   ALTER TABLE ONLY public.ville ALTER COLUMN id_ville SET DEFAULT nextval('public.ville_id_ville_seq'::regclass);
 =   ALTER TABLE public.ville ALTER COLUMN id_ville DROP DEFAULT;
       public          postgres    false    220    221    221            D          0    41472    admin 
   TABLE DATA           :   COPY public.admin (id_admin, login, password) FROM stdin;
    public          postgres    false    227   ~R       @          0    25186    client 
   TABLE DATA           n   COPY public.client (id_client, nom_client, prenom_client, email, nom_rue, numero_porte, id_ville) FROM stdin;
    public          postgres    false    223   �R       B          0    25212    commande 
   TABLE DATA           V   COPY public.commande (id_pizza, id_client, numero_commande, prix, livree) FROM stdin;
    public          postgres    false    225   �R       :          0    25160    ingrédients 
   TABLE DATA           Z   COPY public."ingrédients" ("id_ingrédients", "nom_ingrédient", provenance) FROM stdin;
    public          postgres    false    217   �R       8          0    25153    pizza 
   TABLE DATA           :   COPY public.pizza (id_pizza, nom_pizza, prix) FROM stdin;
    public          postgres    false    215   �R       A          0    25197    possède 
   TABLE DATA           A   COPY public."possède" (id_pizza, "id_ingrédients") FROM stdin;
    public          postgres    false    224   S       <          0    25167    province 
   TABLE DATA           =   COPY public.province (id_province, nom_province) FROM stdin;
    public          postgres    false    219   5S       >          0    25174    ville 
   TABLE DATA           N   COPY public.ville (id_ville, code_postal, nom_ville, id_province) FROM stdin;
    public          postgres    false    221   RS       T           0    0    admin_id_admin_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, false);
          public          postgres    false    226            U           0    0    client_id_client_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.client_id_client_seq', 1, false);
          public          postgres    false    222            V           0    0    commande_is_commande_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.commande_is_commande_seq', 1, false);
          public          postgres    false    228            W           0    0     ingrédients_id_ingrédients_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."ingrédients_id_ingrédients_seq"', 1, false);
          public          postgres    false    216            X           0    0    pizza_id_pizza_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.pizza_id_pizza_seq', 1, false);
          public          postgres    false    214            Y           0    0    province_id_province_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.province_id_province_seq', 1, false);
          public          postgres    false    218            Z           0    0    ville_id_ville_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.ville_id_ville_seq', 1, false);
          public          postgres    false    220            �           2606    41478    admin admin_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            postgres    false    227            �           2606    25191    client client_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            postgres    false    223            �           2606    25218 %   commande commande_numero_commande_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_numero_commande_key UNIQUE (numero_commande);
 O   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_numero_commande_key;
       public            postgres    false    225            �           2606    25216    commande commande_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id_pizza, id_client);
 @   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_pkey;
       public            postgres    false    225    225            �           2606    25165    ingrédients ingrédients_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."ingrédients"
    ADD CONSTRAINT "ingrédients_pkey" PRIMARY KEY ("id_ingrédients");
 L   ALTER TABLE ONLY public."ingrédients" DROP CONSTRAINT "ingrédients_pkey";
       public            postgres    false    217            �           2606    25158    pizza pizza_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.pizza
    ADD CONSTRAINT pizza_pkey PRIMARY KEY (id_pizza);
 :   ALTER TABLE ONLY public.pizza DROP CONSTRAINT pizza_pkey;
       public            postgres    false    215            �           2606    25201    possède possède_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public."possède"
    ADD CONSTRAINT "possède_pkey" PRIMARY KEY (id_pizza, "id_ingrédients");
 D   ALTER TABLE ONLY public."possède" DROP CONSTRAINT "possède_pkey";
       public            postgres    false    224    224            �           2606    25172    province province_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id_province);
 @   ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
       public            postgres    false    219            �           2606    25179    ville ville_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_pkey PRIMARY KEY (id_ville);
 :   ALTER TABLE ONLY public.ville DROP CONSTRAINT ville_pkey;
       public            postgres    false    221            �           2606    25192    client client_id_ville_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);
 E   ALTER TABLE ONLY public.client DROP CONSTRAINT client_id_ville_fkey;
       public          postgres    false    3224    221    223            �           2606    25224     commande commande_id_client_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);
 J   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_id_client_fkey;
       public          postgres    false    223    3226    225            �           2606    25219    commande commande_id_pizza_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_pizza_fkey FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);
 I   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_id_pizza_fkey;
       public          postgres    false    225    215    3218            �           2606    25207 &   possède possède_id_ingrédients_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."possède"
    ADD CONSTRAINT "possède_id_ingrédients_fkey" FOREIGN KEY ("id_ingrédients") REFERENCES public."ingrédients"("id_ingrédients");
 T   ALTER TABLE ONLY public."possède" DROP CONSTRAINT "possède_id_ingrédients_fkey";
       public          postgres    false    217    224    3220            �           2606    25202    possède possède_id_pizza_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."possède"
    ADD CONSTRAINT "possède_id_pizza_fkey" FOREIGN KEY (id_pizza) REFERENCES public.pizza(id_pizza);
 M   ALTER TABLE ONLY public."possède" DROP CONSTRAINT "possède_id_pizza_fkey";
       public          postgres    false    224    3218    215            �           2606    25180    ville ville_id_province_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_id_province_fkey FOREIGN KEY (id_province) REFERENCES public.province(id_province);
 F   ALTER TABLE ONLY public.ville DROP CONSTRAINT ville_id_province_fkey;
       public          postgres    false    221    3222    219            D      x�3�LL��̃�\1z\\\ 8Z      @      x������ � �      B      x������ � �      :      x������ � �      8      x������ � �      A      x������ � �      <      x������ � �      >      x������ � �     