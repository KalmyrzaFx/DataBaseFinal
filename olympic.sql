PGDMP         7            
    y            olympic    14.0    14.0 D    H           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            I           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            J           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            K           1262    16456    olympic    DATABASE     d   CREATE DATABASE olympic WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE olympic;
                postgres    false                        2615    2200    olimpic    SCHEMA        CREATE SCHEMA olimpic;
    DROP SCHEMA olimpic;
                postgres    false            L           0    0    SCHEMA olimpic    COMMENT     7   COMMENT ON SCHEMA olimpic IS 'Olimpic games database';
                   postgres    false    3            �            1255    16838 $   get_gender_number(character varying)    FUNCTION     (  CREATE FUNCTION olimpic.get_gender_number(gender_name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
   gender_number integer;
begin
   select count(*) 
   into gender_number
   from olimpic.athletes
   where gender = gender_name;
   
   return gender_number;
end;
$$;
 H   DROP FUNCTION olimpic.get_gender_number(gender_name character varying);
       olimpic          postgres    false    3            �            1255    16844    insert_ind(character varying)    FUNCTION     �   CREATE FUNCTION olimpic.insert_ind(country_in character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
begin 
insert into olimpic.countries(country_name)
values(country_in);
return 'inserted';
end;
$$;
 @   DROP FUNCTION olimpic.insert_ind(country_in character varying);
       olimpic          postgres    false    3            �            1255    16837    totalathletes()    FUNCTION     �   CREATE FUNCTION olimpic.totalathletes() RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
   total integer;
begin
   select count(*) 
   into total
   from olimpic.athletes;
   
   return total;
end;
$$;
 '   DROP FUNCTION olimpic.totalathletes();
       olimpic          postgres    false    3            �            1259    16790    athletes    TABLE     2  CREATE TABLE olimpic.athletes (
    athlete_id bigint NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    gender character varying(10) NOT NULL,
    date_of_birth date NOT NULL,
    category_id integer,
    country_id integer,
    medal_id integer
);
    DROP TABLE olimpic.athletes;
       olimpic         heap    postgres    false    3            �            1259    16783 	   countries    TABLE     t   CREATE TABLE olimpic.countries (
    country_id bigint NOT NULL,
    country_name character varying(50) NOT NULL
);
    DROP TABLE olimpic.countries;
       olimpic         heap    postgres    false    3            �            1259    16816    athlete_country    VIEW       CREATE VIEW olimpic.athlete_country AS
 SELECT athletes.athlete_id,
    (((athletes.first_name)::text || ' '::text) || (athletes.last_name)::text) AS name,
    countries.country_name
   FROM (olimpic.athletes
     JOIN olimpic.countries USING (country_id));
 #   DROP VIEW olimpic.athlete_country;
       olimpic          postgres    false    221    221    221    221    219    219    3            �            1259    16749    medals    TABLE     m   CREATE TABLE olimpic.medals (
    medal_id bigint NOT NULL,
    medal_type character varying(10) NOT NULL
);
    DROP TABLE olimpic.medals;
       olimpic         heap    postgres    false    3            �            1259    16833    athlete_individual    VIEW       CREATE VIEW olimpic.athlete_individual AS
 SELECT athletes.athlete_id,
    (((athletes.first_name)::text || ' '::text) || (athletes.last_name)::text) AS name,
    athletes.date_of_birth,
    medals.medal_type
   FROM (olimpic.athletes
     JOIN olimpic.medals USING (medal_id));
 &   DROP VIEW olimpic.athlete_individual;
       olimpic          postgres    false    217    217    221    221    221    221    221    3            �            1259    16789    athletes_athlete_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.athletes_athlete_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE olimpic.athletes_athlete_id_seq;
       olimpic          postgres    false    221    3            M           0    0    athletes_athlete_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE olimpic.athletes_athlete_id_seq OWNED BY olimpic.athletes.athlete_id;
          olimpic          postgres    false    220            �            1259    16732 
   categories    TABLE     �   CREATE TABLE olimpic.categories (
    category_id bigint NOT NULL,
    title character varying(50) NOT NULL,
    gender character varying(7) NOT NULL,
    sport_id integer,
    game_id integer
);
    DROP TABLE olimpic.categories;
       olimpic         heap    postgres    false    3            �            1259    16825    athletes_medal    VIEW     .  CREATE VIEW olimpic.athletes_medal AS
 SELECT athletes.athlete_id,
    athletes.first_name,
    athletes.last_name,
    athletes.gender,
    categories.title,
    medals.medal_type
   FROM ((olimpic.athletes
     JOIN olimpic.categories USING (category_id))
     JOIN olimpic.medals USING (medal_id));
 "   DROP VIEW olimpic.athletes_medal;
       olimpic          postgres    false    221    221    215    215    217    217    221    221    221    221    3            �            1259    16731    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE olimpic.categories_category_id_seq;
       olimpic          postgres    false    215    3            N           0    0    categories_category_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE olimpic.categories_category_id_seq OWNED BY olimpic.categories.category_id;
          olimpic          postgres    false    214            �            1259    16782    countries_country_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.countries_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE olimpic.countries_country_id_seq;
       olimpic          postgres    false    3    219            O           0    0    countries_country_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE olimpic.countries_country_id_seq OWNED BY olimpic.countries.country_id;
          olimpic          postgres    false    218            �            1259    16707    games    TABLE     �   CREATE TABLE olimpic.games (
    game_id bigint NOT NULL,
    country character varying(30) NOT NULL,
    game_year integer NOT NULL,
    city character varying(30) NOT NULL
);
    DROP TABLE olimpic.games;
       olimpic         heap    postgres    false    3            �            1259    16714    sports    TABLE     i   CREATE TABLE olimpic.sports (
    sport_id bigint NOT NULL,
    sport_name character varying NOT NULL
);
    DROP TABLE olimpic.sports;
       olimpic         heap    postgres    false    3            �            1259    16829    event_sport_categories    VIEW     ;  CREATE VIEW olimpic.event_sport_categories AS
 SELECT categories.category_id,
    categories.title,
    categories.gender,
    sports.sport_name,
    games.country,
    games.game_year,
    games.city
   FROM ((olimpic.categories
     JOIN olimpic.sports USING (sport_id))
     JOIN olimpic.games USING (game_id));
 *   DROP VIEW olimpic.event_sport_categories;
       olimpic          postgres    false    215    211    211    211    211    213    213    215    215    215    215    3            �            1259    16666    example_id_seq    SEQUENCE     x   CREATE SEQUENCE olimpic.example_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE olimpic.example_id_seq;
       olimpic          postgres    false    3            �            1259    16706    games_game_id_seq    SEQUENCE     {   CREATE SEQUENCE olimpic.games_game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE olimpic.games_game_id_seq;
       olimpic          postgres    false    3    211            P           0    0    games_game_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE olimpic.games_game_id_seq OWNED BY olimpic.games.game_id;
          olimpic          postgres    false    210            �            1259    16748    medals_medal_id_seq    SEQUENCE     }   CREATE SEQUENCE olimpic.medals_medal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE olimpic.medals_medal_id_seq;
       olimpic          postgres    false    217    3            Q           0    0    medals_medal_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE olimpic.medals_medal_id_seq OWNED BY olimpic.medals.medal_id;
          olimpic          postgres    false    216            �            1259    16821    sport_categories    VIEW     �   CREATE VIEW olimpic.sport_categories AS
 SELECT categories.category_id,
    categories.title,
    categories.gender,
    sports.sport_name
   FROM (olimpic.categories
     JOIN olimpic.sports USING (sport_id));
 $   DROP VIEW olimpic.sport_categories;
       olimpic          postgres    false    213    213    215    215    215    215    3            �            1259    16713    sports_sport_id_seq    SEQUENCE     }   CREATE SEQUENCE olimpic.sports_sport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE olimpic.sports_sport_id_seq;
       olimpic          postgres    false    213    3            R           0    0    sports_sport_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE olimpic.sports_sport_id_seq OWNED BY olimpic.sports.sport_id;
          olimpic          postgres    false    212            �           2604    16793    athletes athlete_id    DEFAULT     |   ALTER TABLE ONLY olimpic.athletes ALTER COLUMN athlete_id SET DEFAULT nextval('olimpic.athletes_athlete_id_seq'::regclass);
 C   ALTER TABLE olimpic.athletes ALTER COLUMN athlete_id DROP DEFAULT;
       olimpic          postgres    false    220    221    221            �           2604    16735    categories category_id    DEFAULT     �   ALTER TABLE ONLY olimpic.categories ALTER COLUMN category_id SET DEFAULT nextval('olimpic.categories_category_id_seq'::regclass);
 F   ALTER TABLE olimpic.categories ALTER COLUMN category_id DROP DEFAULT;
       olimpic          postgres    false    215    214    215            �           2604    16786    countries country_id    DEFAULT     ~   ALTER TABLE ONLY olimpic.countries ALTER COLUMN country_id SET DEFAULT nextval('olimpic.countries_country_id_seq'::regclass);
 D   ALTER TABLE olimpic.countries ALTER COLUMN country_id DROP DEFAULT;
       olimpic          postgres    false    219    218    219            �           2604    16710    games game_id    DEFAULT     p   ALTER TABLE ONLY olimpic.games ALTER COLUMN game_id SET DEFAULT nextval('olimpic.games_game_id_seq'::regclass);
 =   ALTER TABLE olimpic.games ALTER COLUMN game_id DROP DEFAULT;
       olimpic          postgres    false    211    210    211            �           2604    16752    medals medal_id    DEFAULT     t   ALTER TABLE ONLY olimpic.medals ALTER COLUMN medal_id SET DEFAULT nextval('olimpic.medals_medal_id_seq'::regclass);
 ?   ALTER TABLE olimpic.medals ALTER COLUMN medal_id DROP DEFAULT;
       olimpic          postgres    false    216    217    217            �           2604    16717    sports sport_id    DEFAULT     t   ALTER TABLE ONLY olimpic.sports ALTER COLUMN sport_id SET DEFAULT nextval('olimpic.sports_sport_id_seq'::regclass);
 ?   ALTER TABLE olimpic.sports ALTER COLUMN sport_id DROP DEFAULT;
       olimpic          postgres    false    213    212    213            E          0    16790    athletes 
   TABLE DATA           �   COPY olimpic.athletes (athlete_id, first_name, last_name, gender, date_of_birth, category_id, country_id, medal_id) FROM stdin;
    olimpic          postgres    false    221   �Q       ?          0    16732 
   categories 
   TABLE DATA           T   COPY olimpic.categories (category_id, title, gender, sport_id, game_id) FROM stdin;
    olimpic          postgres    false    215   2U       C          0    16783 	   countries 
   TABLE DATA           >   COPY olimpic.countries (country_id, country_name) FROM stdin;
    olimpic          postgres    false    219   �U       ;          0    16707    games 
   TABLE DATA           C   COPY olimpic.games (game_id, country, game_year, city) FROM stdin;
    olimpic          postgres    false    211   V       A          0    16749    medals 
   TABLE DATA           7   COPY olimpic.medals (medal_id, medal_type) FROM stdin;
    olimpic          postgres    false    217   jV       =          0    16714    sports 
   TABLE DATA           7   COPY olimpic.sports (sport_id, sport_name) FROM stdin;
    olimpic          postgres    false    213   �V       S           0    0    athletes_athlete_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('olimpic.athletes_athlete_id_seq', 40, true);
          olimpic          postgres    false    220            T           0    0    categories_category_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('olimpic.categories_category_id_seq', 8, true);
          olimpic          postgres    false    214            U           0    0    countries_country_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('olimpic.countries_country_id_seq', 12, true);
          olimpic          postgres    false    218            V           0    0    example_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('olimpic.example_id_seq', 1, false);
          olimpic          postgres    false    209            W           0    0    games_game_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('olimpic.games_game_id_seq', 2, true);
          olimpic          postgres    false    210            X           0    0    medals_medal_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('olimpic.medals_medal_id_seq', 4, true);
          olimpic          postgres    false    216            Y           0    0    sports_sport_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('olimpic.sports_sport_id_seq', 4, true);
          olimpic          postgres    false    212            �           2606    16795    athletes athletes_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_pkey PRIMARY KEY (athlete_id);
 A   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_pkey;
       olimpic            postgres    false    221            �           2606    16737    categories categories_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY olimpic.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 E   ALTER TABLE ONLY olimpic.categories DROP CONSTRAINT categories_pkey;
       olimpic            postgres    false    215            �           2606    16788    countries countries_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY olimpic.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);
 C   ALTER TABLE ONLY olimpic.countries DROP CONSTRAINT countries_pkey;
       olimpic            postgres    false    219            �           2606    16712    games games_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY olimpic.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);
 ;   ALTER TABLE ONLY olimpic.games DROP CONSTRAINT games_pkey;
       olimpic            postgres    false    211            �           2606    16754    medals medals_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY olimpic.medals
    ADD CONSTRAINT medals_pkey PRIMARY KEY (medal_id);
 =   ALTER TABLE ONLY olimpic.medals DROP CONSTRAINT medals_pkey;
       olimpic            postgres    false    217            �           2606    16721    sports sports_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY olimpic.sports
    ADD CONSTRAINT sports_pkey PRIMARY KEY (sport_id);
 =   ALTER TABLE ONLY olimpic.sports DROP CONSTRAINT sports_pkey;
       olimpic            postgres    false    213            �           1259    16845    athletes_name    INDEX     I   CREATE INDEX athletes_name ON olimpic.athletes USING btree (first_name);
 "   DROP INDEX olimpic.athletes_name;
       olimpic            postgres    false    221            �           1259    16848    category_idx    INDEX     E   CREATE INDEX category_idx ON olimpic.categories USING btree (title);
 !   DROP INDEX olimpic.category_idx;
       olimpic            postgres    false    215            �           1259    16846    country_idx    INDEX     J   CREATE INDEX country_idx ON olimpic.countries USING btree (country_name);
     DROP INDEX olimpic.country_idx;
       olimpic            postgres    false    219            �           1259    16847    game_idx    INDEX     >   CREATE INDEX game_idx ON olimpic.games USING btree (country);
    DROP INDEX olimpic.game_idx;
       olimpic            postgres    false    211            �           1259    16849 	   medal_idx    INDEX     C   CREATE INDEX medal_idx ON olimpic.medals USING btree (medal_type);
    DROP INDEX olimpic.medal_idx;
       olimpic            postgres    false    217            �           2606    16796 "   athletes athletes_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_category_id_fkey FOREIGN KEY (category_id) REFERENCES olimpic.categories(category_id);
 M   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_category_id_fkey;
       olimpic          postgres    false    3225    221    215            �           2606    16801 !   athletes athletes_country_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_country_id_fkey FOREIGN KEY (country_id) REFERENCES olimpic.countries(country_id);
 L   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_country_id_fkey;
       olimpic          postgres    false    219    221    3231            �           2606    16806    athletes athletes_medal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_medal_id_fkey FOREIGN KEY (medal_id) REFERENCES olimpic.medals(medal_id);
 J   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_medal_id_fkey;
       olimpic          postgres    false    221    3229    217            �           2606    16743 "   categories categories_game_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.categories
    ADD CONSTRAINT categories_game_id_fkey FOREIGN KEY (game_id) REFERENCES olimpic.games(game_id);
 M   ALTER TABLE ONLY olimpic.categories DROP CONSTRAINT categories_game_id_fkey;
       olimpic          postgres    false    3221    215    211            �           2606    16738 #   categories categories_sport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.categories
    ADD CONSTRAINT categories_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES olimpic.sports(sport_id);
 N   ALTER TABLE ONLY olimpic.categories DROP CONSTRAINT categories_sport_id_fkey;
       olimpic          postgres    false    215    213    3223            E   H  x�]T]s�6|>�v~�Ѷj;NԦvf��X��Q@�q�_�=H��g���v�����͚��s!�=����6O�2�+ʩ�"�i��t���m��:͊�Ȁ�)O
��x��^�{_��4kҼNe���>�ٿi���0.����JQI��8�mY��z^���L	]I
c;zd?�0��ݸg�B��M� �M0���ߋ�?��|��+l��$E[��A�+3��Y��[ (P9m�4�ZW�]��\���ڰ�<���zw��,�*���%m$�����zI)��]E�؍��y��1��*�*" _Ӄ��Y��cp�N�YPU2��{�|�e�g?���4Osl�����Q²<�D��/��wt˖{sX��ݟ����633�چ%�{m�|�j��"B-��I�h㼣;g�+{��!�S۠�Y�X���p��Hy�Iu�[@���l��vAUш��n^ң���Y�k]8ɮ�y~�gt�߉��.L���4",�k�Ȃ{�:`t�5�[��G�������E�еB��W���y��K���!�A��<��A�����|x���8���2Aq��d��eBt���pԅ�"@%��ك�nO����čB�秗瑇Wƿ�jXI�jY	`}4lŴ��-����ДJ.;)�����O���%�RR�*��HY�_����1�������|��IgM7V��~�c�eIe�)Y��z2�#������/,�+yN���8T�f觫c������[��f���e�YO�E�+3�4팣��W�P�8��E�=!`����_�P<�e��2��ș��Ý.����*ʯ��W��2�֪���ߒ$��      ?   f   x�3�t,J�H-���M�I�4�4�2������9r!��l.�$b�if��Q��2��*@"�!�I9�
%�yy���F@qTq�#N#�=... 1J)8      C   f   x��1�@�z�0�E@)�D4FCg37Y�f�O�� ϡ�WLq[�ŋ{�3�S�es\�l�X��[��Oo��Gac��+�F����t)��cG���      ;   <   x�3��J,H��4202��Ϯ��2�t*J�����qe�+��*x%�f�s��qqq ��B      A   -   x�3�t��I�2���)K-�2�t*�ϫJ�2����K����� ��	�      =   :   x�3�t,J�H-��2�IL�IU(I���,�2�.�����K�2�/J-.��c���� � 0     