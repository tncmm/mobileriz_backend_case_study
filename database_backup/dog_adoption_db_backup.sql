PGDMP      
                |            dog_adoption    15.7    16.3 '    #           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            $           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            %           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            &           1262    16622    dog_adoption    DATABASE     �   CREATE DATABASE dog_adoption WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Turkish_T�rkiye.1252';
    DROP DATABASE dog_adoption;
                postgres    false            �            1259    16624    breeds    TABLE     a   CREATE TABLE public.breeds (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);
    DROP TABLE public.breeds;
       public         heap    postgres    false            �            1259    16623    breeds_id_seq    SEQUENCE     �   CREATE SEQUENCE public.breeds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.breeds_id_seq;
       public          postgres    false    215            '           0    0    breeds_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.breeds_id_seq OWNED BY public.breeds.id;
          public          postgres    false    214            �            1259    16633    dogs    TABLE     �   CREATE TABLE public.dogs (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    breedid integer,
    age integer,
    gender character varying(10),
    size character varying(20),
    description text
);
    DROP TABLE public.dogs;
       public         heap    postgres    false            �            1259    16632    dogs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.dogs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.dogs_id_seq;
       public          postgres    false    217            (           0    0    dogs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.dogs_id_seq OWNED BY public.dogs.id;
          public          postgres    false    216            �            1259    16660 	   favorites    TABLE     b   CREATE TABLE public.favorites (
    id integer NOT NULL,
    userid integer,
    dogid integer
);
    DROP TABLE public.favorites;
       public         heap    postgres    false            �            1259    16659    favorites_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.favorites_id_seq;
       public          postgres    false    221            )           0    0    favorites_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;
          public          postgres    false    220            �            1259    16647    users    TABLE       CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(256) NOT NULL,
    email character varying(100) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16646    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    219            *           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    218            t           2604    16627 	   breeds id    DEFAULT     f   ALTER TABLE ONLY public.breeds ALTER COLUMN id SET DEFAULT nextval('public.breeds_id_seq'::regclass);
 8   ALTER TABLE public.breeds ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            u           2604    16636    dogs id    DEFAULT     b   ALTER TABLE ONLY public.dogs ALTER COLUMN id SET DEFAULT nextval('public.dogs_id_seq'::regclass);
 6   ALTER TABLE public.dogs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            w           2604    16663    favorites id    DEFAULT     l   ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);
 ;   ALTER TABLE public.favorites ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            v           2604    16650    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219                      0    16624    breeds 
   TABLE DATA           *   COPY public.breeds (id, name) FROM stdin;
    public          postgres    false    215   �)                 0    16633    dogs 
   TABLE DATA           Q   COPY public.dogs (id, name, breedid, age, gender, size, description) FROM stdin;
    public          postgres    false    217   U*                  0    16660 	   favorites 
   TABLE DATA           6   COPY public.favorites (id, userid, dogid) FROM stdin;
    public          postgres    false    221   3+                 0    16647    users 
   TABLE DATA           Z   COPY public.users (id, username, password_hash, email, first_name, last_name) FROM stdin;
    public          postgres    false    219   u+       +           0    0    breeds_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.breeds_id_seq', 5, true);
          public          postgres    false    214            ,           0    0    dogs_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.dogs_id_seq', 5, true);
          public          postgres    false    216            -           0    0    favorites_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.favorites_id_seq', 9, true);
          public          postgres    false    220            .           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public          postgres    false    218            y           2606    16631    breeds breeds_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.breeds
    ADD CONSTRAINT breeds_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.breeds DROP CONSTRAINT breeds_name_key;
       public            postgres    false    215            {           2606    16629    breeds breeds_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.breeds
    ADD CONSTRAINT breeds_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.breeds DROP CONSTRAINT breeds_pkey;
       public            postgres    false    215            }           2606    16640    dogs dogs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.dogs
    ADD CONSTRAINT dogs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.dogs DROP CONSTRAINT dogs_pkey;
       public            postgres    false    217            �           2606    16665    favorites favorites_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.favorites DROP CONSTRAINT favorites_pkey;
       public            postgres    false    221            �           2606    16667 $   favorites favorites_userid_dogid_key 
   CONSTRAINT     h   ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_userid_dogid_key UNIQUE (userid, dogid);
 N   ALTER TABLE ONLY public.favorites DROP CONSTRAINT favorites_userid_dogid_key;
       public            postgres    false    221    221                       2606    16658    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    219            �           2606    16654    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    219            �           2606    16656    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    219            �           2606    16641    dogs dogs_breedid_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.dogs
    ADD CONSTRAINT dogs_breedid_fkey FOREIGN KEY (breedid) REFERENCES public.breeds(id);
 @   ALTER TABLE ONLY public.dogs DROP CONSTRAINT dogs_breedid_fkey;
       public          postgres    false    215    217    3195            �           2606    16673    favorites favorites_dogid_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_dogid_fkey FOREIGN KEY (dogid) REFERENCES public.dogs(id);
 H   ALTER TABLE ONLY public.favorites DROP CONSTRAINT favorites_dogid_fkey;
       public          postgres    false    221    217    3197            �           2606    16668    favorites favorites_userid_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);
 I   ALTER TABLE ONLY public.favorites DROP CONSTRAINT favorites_userid_fkey;
       public          postgres    false    3201    219    221               Q   x�3��IL*JL�/RJ-)�L-K-�2�tO-�M�S�H-�H-J�2�t��II�CRd��T������e�锚�������� l/�         �   x�M�Mj�0�ףS���6�B��f=ۂ�&R�o��������>��Е����]�3�)��9�������!�;P�����ƲS1�����r���ܑ��U"�z����-�y�&<J̉|�% �w�	u'jb��_�!֕n��T&�JǬɷU$�ٝ���	��e�ލ��\_;�Bu�-x��7��7L-]�          2   x�ɹ  �XW366O/�_J6�P(I[L�m�N�<l[�\�y���           x�e��N�AF��<��Y����T���H Q0htᦪ��p��A��\��`���N������^�tk����6��y��q��>�������?s�P)�[�X<J��E�j5��2�1Ԥ!�,ylSu����M�#�&��WK��q19�kI�bܲq�S��|S*(�{�4-�n��e}���!��K߲����y}�x�|�5���k����[<��s\��I^�I�%��2I.�Co�G��N ��F`�D��R��B�7�P��J�2�@�b�^UM�j*�P@������%�K�Ѧ�̯!���^�����m=�3u�:�Ԙ��*jmA�{�<z��S���J�VF~�P�,�\x�')h��"�6
^ѬUEQc�.�h��Ҥ��M���S�/��>���on����=����W��>���\�>�{�au6�ܐ�t<Xb	бq���c�S��U��ah�A������BFq$ti�����j�!�A�E�0�>�Ň��y�0L�O9wNrv����s�{�$�׭�l�����     