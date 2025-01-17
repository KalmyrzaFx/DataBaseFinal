PGDMP         :                y            Olympic    14.1    14.1 M    U           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            V           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            W           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            X           1262    24577    Olympic    DATABASE     m   CREATE DATABASE "Olympic" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE "Olympic";
                postgres    false                        2615    24578    olimpic    SCHEMA        CREATE SCHEMA olimpic;
    DROP SCHEMA olimpic;
                postgres    false            Y           0    0    SCHEMA olimpic    COMMENT     7   COMMENT ON SCHEMA olimpic IS 'Olimpic games database';
                   postgres    false    4            �            1255    24579 $   get_gender_number(character varying)    FUNCTION     (  CREATE FUNCTION olimpic.get_gender_number(gender_name character varying) RETURNS integer
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
       olimpic          postgres    false    4            �            1255    24580    insert_ind(character varying)    FUNCTION     �   CREATE FUNCTION olimpic.insert_ind(country_in character varying) RETURNS character varying
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
       olimpic          postgres    false    4            �            1255    24692    log_last_name_changes()    FUNCTION     x  CREATE FUNCTION olimpic.log_last_name_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.last_name <> OLD.last_name THEN
		 INSERT INTO olimpic.update_athletes(athlete_id,
											 last_name,
											 first_name,
											 changed_on)
		 VALUES(
				OLD.athlete_id,
				OLD.last_name,
				NEW.last_name,
				now());
	END IF;

	RETURN NEW;
END;
$$;
 /   DROP FUNCTION olimpic.log_last_name_changes();
       olimpic          postgres    false    4            �            1255    24581    totalathletes()    FUNCTION     �   CREATE FUNCTION olimpic.totalathletes() RETURNS integer
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
       olimpic          postgres    false    4            �            1259    24582    athletes    TABLE     2  CREATE TABLE olimpic.athletes (
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
       olimpic         heap    postgres    false    4            �            1259    24585 	   countries    TABLE     t   CREATE TABLE olimpic.countries (
    country_id bigint NOT NULL,
    country_name character varying(50) NOT NULL
);
    DROP TABLE olimpic.countries;
       olimpic         heap    postgres    false    4            �            1259    24588    athlete_country    VIEW       CREATE VIEW olimpic.athlete_country AS
 SELECT athletes.athlete_id,
    (((athletes.first_name)::text || ' '::text) || (athletes.last_name)::text) AS name,
    countries.country_name
   FROM (olimpic.athletes
     JOIN olimpic.countries USING (country_id));
 #   DROP VIEW olimpic.athlete_country;
       olimpic          postgres    false    210    210    210    210    211    211    4            �            1259    24592    medals    TABLE     m   CREATE TABLE olimpic.medals (
    medal_id bigint NOT NULL,
    medal_type character varying(10) NOT NULL
);
    DROP TABLE olimpic.medals;
       olimpic         heap    postgres    false    4            �            1259    24595    athlete_individual    VIEW       CREATE VIEW olimpic.athlete_individual AS
 SELECT athletes.athlete_id,
    (((athletes.first_name)::text || ' '::text) || (athletes.last_name)::text) AS name,
    athletes.date_of_birth,
    medals.medal_type
   FROM (olimpic.athletes
     JOIN olimpic.medals USING (medal_id));
 &   DROP VIEW olimpic.athlete_individual;
       olimpic          postgres    false    213    213    210    210    210    210    210    4            �            1259    24599    athletes_athlete_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.athletes_athlete_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE olimpic.athletes_athlete_id_seq;
       olimpic          postgres    false    210    4            Z           0    0    athletes_athlete_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE olimpic.athletes_athlete_id_seq OWNED BY olimpic.athletes.athlete_id;
          olimpic          postgres    false    215            �            1259    24600 
   categories    TABLE     �   CREATE TABLE olimpic.categories (
    category_id bigint NOT NULL,
    title character varying(50) NOT NULL,
    gender character varying(7) NOT NULL,
    sport_id integer,
    game_id integer
);
    DROP TABLE olimpic.categories;
       olimpic         heap    postgres    false    4            �            1259    24603    athletes_medal    VIEW     .  CREATE VIEW olimpic.athletes_medal AS
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
       olimpic          postgres    false    210    216    216    213    213    210    210    210    210    210    4            �            1259    24607    categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE olimpic.categories_category_id_seq;
       olimpic          postgres    false    4    216            [           0    0    categories_category_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE olimpic.categories_category_id_seq OWNED BY olimpic.categories.category_id;
          olimpic          postgres    false    218            �            1259    24608    countries_country_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.countries_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE olimpic.countries_country_id_seq;
       olimpic          postgres    false    211    4            \           0    0    countries_country_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE olimpic.countries_country_id_seq OWNED BY olimpic.countries.country_id;
          olimpic          postgres    false    219            �            1259    24609    games    TABLE     �   CREATE TABLE olimpic.games (
    game_id bigint NOT NULL,
    country character varying(30) NOT NULL,
    game_year integer NOT NULL,
    city character varying(30) NOT NULL
);
    DROP TABLE olimpic.games;
       olimpic         heap    postgres    false    4            �            1259    24612    sports    TABLE     i   CREATE TABLE olimpic.sports (
    sport_id bigint NOT NULL,
    sport_name character varying NOT NULL
);
    DROP TABLE olimpic.sports;
       olimpic         heap    postgres    false    4            �            1259    24617    event_sport_categories    VIEW     ;  CREATE VIEW olimpic.event_sport_categories AS
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
       olimpic          postgres    false    221    220    220    216    216    216    216    216    220    220    221    4            �            1259    24621    example_id_seq    SEQUENCE     x   CREATE SEQUENCE olimpic.example_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE olimpic.example_id_seq;
       olimpic          postgres    false    4            �            1259    24622    games_game_id_seq    SEQUENCE     {   CREATE SEQUENCE olimpic.games_game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE olimpic.games_game_id_seq;
       olimpic          postgres    false    220    4            ]           0    0    games_game_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE olimpic.games_game_id_seq OWNED BY olimpic.games.game_id;
          olimpic          postgres    false    224            �            1259    24623    medals_medal_id_seq    SEQUENCE     }   CREATE SEQUENCE olimpic.medals_medal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE olimpic.medals_medal_id_seq;
       olimpic          postgres    false    213    4            ^           0    0    medals_medal_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE olimpic.medals_medal_id_seq OWNED BY olimpic.medals.medal_id;
          olimpic          postgres    false    225            �            1259    24624    sport_categories    VIEW     �   CREATE VIEW olimpic.sport_categories AS
 SELECT categories.category_id,
    categories.title,
    categories.gender,
    sports.sport_name
   FROM (olimpic.categories
     JOIN olimpic.sports USING (sport_id));
 $   DROP VIEW olimpic.sport_categories;
       olimpic          postgres    false    221    221    216    216    216    216    4            �            1259    24628    sports_sport_id_seq    SEQUENCE     }   CREATE SEQUENCE olimpic.sports_sport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE olimpic.sports_sport_id_seq;
       olimpic          postgres    false    221    4            _           0    0    sports_sport_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE olimpic.sports_sport_id_seq OWNED BY olimpic.sports.sport_id;
          olimpic          postgres    false    227            �            1259    24686    update_athletes    TABLE     �   CREATE TABLE olimpic.update_athletes (
    id bigint NOT NULL,
    athlete_id integer NOT NULL,
    last_name character varying(50) NOT NULL,
    new_name character varying(50) NOT NULL,
    changed_on timestamp(6) without time zone NOT NULL
);
 $   DROP TABLE olimpic.update_athletes;
       olimpic         heap    postgres    false    4            �            1259    24685    update_athletes_id_seq    SEQUENCE     �   CREATE SEQUENCE olimpic.update_athletes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE olimpic.update_athletes_id_seq;
       olimpic          postgres    false    4    229            `           0    0    update_athletes_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE olimpic.update_athletes_id_seq OWNED BY olimpic.update_athletes.id;
          olimpic          postgres    false    228            �           2604    24629    athletes athlete_id    DEFAULT     |   ALTER TABLE ONLY olimpic.athletes ALTER COLUMN athlete_id SET DEFAULT nextval('olimpic.athletes_athlete_id_seq'::regclass);
 C   ALTER TABLE olimpic.athletes ALTER COLUMN athlete_id DROP DEFAULT;
       olimpic          postgres    false    215    210            �           2604    24630    categories category_id    DEFAULT     �   ALTER TABLE ONLY olimpic.categories ALTER COLUMN category_id SET DEFAULT nextval('olimpic.categories_category_id_seq'::regclass);
 F   ALTER TABLE olimpic.categories ALTER COLUMN category_id DROP DEFAULT;
       olimpic          postgres    false    218    216            �           2604    24631    countries country_id    DEFAULT     ~   ALTER TABLE ONLY olimpic.countries ALTER COLUMN country_id SET DEFAULT nextval('olimpic.countries_country_id_seq'::regclass);
 D   ALTER TABLE olimpic.countries ALTER COLUMN country_id DROP DEFAULT;
       olimpic          postgres    false    219    211            �           2604    24632    games game_id    DEFAULT     p   ALTER TABLE ONLY olimpic.games ALTER COLUMN game_id SET DEFAULT nextval('olimpic.games_game_id_seq'::regclass);
 =   ALTER TABLE olimpic.games ALTER COLUMN game_id DROP DEFAULT;
       olimpic          postgres    false    224    220            �           2604    24633    medals medal_id    DEFAULT     t   ALTER TABLE ONLY olimpic.medals ALTER COLUMN medal_id SET DEFAULT nextval('olimpic.medals_medal_id_seq'::regclass);
 ?   ALTER TABLE olimpic.medals ALTER COLUMN medal_id DROP DEFAULT;
       olimpic          postgres    false    225    213            �           2604    24634    sports sport_id    DEFAULT     t   ALTER TABLE ONLY olimpic.sports ALTER COLUMN sport_id SET DEFAULT nextval('olimpic.sports_sport_id_seq'::regclass);
 ?   ALTER TABLE olimpic.sports ALTER COLUMN sport_id DROP DEFAULT;
       olimpic          postgres    false    227    221            �           2604    24689    update_athletes id    DEFAULT     z   ALTER TABLE ONLY olimpic.update_athletes ALTER COLUMN id SET DEFAULT nextval('olimpic.update_athletes_id_seq'::regclass);
 B   ALTER TABLE olimpic.update_athletes ALTER COLUMN id DROP DEFAULT;
       olimpic          postgres    false    228    229    229            D          0    24582    athletes 
   TABLE DATA           �   COPY olimpic.athletes (athlete_id, first_name, last_name, gender, date_of_birth, category_id, country_id, medal_id) FROM stdin;
    olimpic          postgres    false    210   �]       H          0    24600 
   categories 
   TABLE DATA           T   COPY olimpic.categories (category_id, title, gender, sport_id, game_id) FROM stdin;
    olimpic          postgres    false    216   a       E          0    24585 	   countries 
   TABLE DATA           >   COPY olimpic.countries (country_id, country_name) FROM stdin;
    olimpic          postgres    false    211   �a       K          0    24609    games 
   TABLE DATA           C   COPY olimpic.games (game_id, country, game_year, city) FROM stdin;
    olimpic          postgres    false    220   b       F          0    24592    medals 
   TABLE DATA           7   COPY olimpic.medals (medal_id, medal_type) FROM stdin;
    olimpic          postgres    false    213   Qb       L          0    24612    sports 
   TABLE DATA           7   COPY olimpic.sports (sport_id, sport_name) FROM stdin;
    olimpic          postgres    false    221   �b       R          0    24686    update_athletes 
   TABLE DATA           [   COPY olimpic.update_athletes (id, athlete_id, last_name, new_name, changed_on) FROM stdin;
    olimpic          postgres    false    229   �b       a           0    0    athletes_athlete_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('olimpic.athletes_athlete_id_seq', 40, true);
          olimpic          postgres    false    215            b           0    0    categories_category_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('olimpic.categories_category_id_seq', 8, true);
          olimpic          postgres    false    218            c           0    0    countries_country_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('olimpic.countries_country_id_seq', 12, true);
          olimpic          postgres    false    219            d           0    0    example_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('olimpic.example_id_seq', 1, false);
          olimpic          postgres    false    223            e           0    0    games_game_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('olimpic.games_game_id_seq', 2, true);
          olimpic          postgres    false    224            f           0    0    medals_medal_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('olimpic.medals_medal_id_seq', 4, true);
          olimpic          postgres    false    225            g           0    0    sports_sport_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('olimpic.sports_sport_id_seq', 4, true);
          olimpic          postgres    false    227            h           0    0    update_athletes_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('olimpic.update_athletes_id_seq', 2, true);
          olimpic          postgres    false    228            �           2606    24636    athletes athletes_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_pkey PRIMARY KEY (athlete_id);
 A   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_pkey;
       olimpic            postgres    false    210            �           2606    24638    categories categories_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY olimpic.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);
 E   ALTER TABLE ONLY olimpic.categories DROP CONSTRAINT categories_pkey;
       olimpic            postgres    false    216            �           2606    24640    countries countries_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY olimpic.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);
 C   ALTER TABLE ONLY olimpic.countries DROP CONSTRAINT countries_pkey;
       olimpic            postgres    false    211            �           2606    24642    games games_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY olimpic.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);
 ;   ALTER TABLE ONLY olimpic.games DROP CONSTRAINT games_pkey;
       olimpic            postgres    false    220            �           2606    24644    medals medals_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY olimpic.medals
    ADD CONSTRAINT medals_pkey PRIMARY KEY (medal_id);
 =   ALTER TABLE ONLY olimpic.medals DROP CONSTRAINT medals_pkey;
       olimpic            postgres    false    213            �           2606    24646    sports sports_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY olimpic.sports
    ADD CONSTRAINT sports_pkey PRIMARY KEY (sport_id);
 =   ALTER TABLE ONLY olimpic.sports DROP CONSTRAINT sports_pkey;
       olimpic            postgres    false    221            �           2606    24691 $   update_athletes update_athletes_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY olimpic.update_athletes
    ADD CONSTRAINT update_athletes_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY olimpic.update_athletes DROP CONSTRAINT update_athletes_pkey;
       olimpic            postgres    false    229            �           1259    24647    athletes_name    INDEX     I   CREATE INDEX athletes_name ON olimpic.athletes USING btree (first_name);
 "   DROP INDEX olimpic.athletes_name;
       olimpic            postgres    false    210            �           1259    24648    category_idx    INDEX     E   CREATE INDEX category_idx ON olimpic.categories USING btree (title);
 !   DROP INDEX olimpic.category_idx;
       olimpic            postgres    false    216            �           1259    24649    country_idx    INDEX     J   CREATE INDEX country_idx ON olimpic.countries USING btree (country_name);
     DROP INDEX olimpic.country_idx;
       olimpic            postgres    false    211            �           1259    24650    game_idx    INDEX     >   CREATE INDEX game_idx ON olimpic.games USING btree (country);
    DROP INDEX olimpic.game_idx;
       olimpic            postgres    false    220            �           1259    24651 	   medal_idx    INDEX     C   CREATE INDEX medal_idx ON olimpic.medals USING btree (medal_type);
    DROP INDEX olimpic.medal_idx;
       olimpic            postgres    false    213            �           2620    24694    athletes name_changes    TRIGGER     }   CREATE TRIGGER name_changes BEFORE UPDATE ON olimpic.athletes FOR EACH ROW EXECUTE FUNCTION olimpic.log_last_name_changes();
 /   DROP TRIGGER name_changes ON olimpic.athletes;
       olimpic          postgres    false    210    233            �           2606    24652 "   athletes athletes_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_category_id_fkey FOREIGN KEY (category_id) REFERENCES olimpic.categories(category_id);
 M   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_category_id_fkey;
       olimpic          postgres    false    210    216    3237            �           2606    24657 !   athletes athletes_country_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_country_id_fkey FOREIGN KEY (country_id) REFERENCES olimpic.countries(country_id);
 L   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_country_id_fkey;
       olimpic          postgres    false    210    3231    211            �           2606    24662    athletes athletes_medal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.athletes
    ADD CONSTRAINT athletes_medal_id_fkey FOREIGN KEY (medal_id) REFERENCES olimpic.medals(medal_id);
 J   ALTER TABLE ONLY olimpic.athletes DROP CONSTRAINT athletes_medal_id_fkey;
       olimpic          postgres    false    3235    210    213            �           2606    24667 "   categories categories_game_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.categories
    ADD CONSTRAINT categories_game_id_fkey FOREIGN KEY (game_id) REFERENCES olimpic.games(game_id);
 M   ALTER TABLE ONLY olimpic.categories DROP CONSTRAINT categories_game_id_fkey;
       olimpic          postgres    false    220    3241    216            �           2606    24672 #   categories categories_sport_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY olimpic.categories
    ADD CONSTRAINT categories_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES olimpic.sports(sport_id);
 N   ALTER TABLE ONLY olimpic.categories DROP CONSTRAINT categories_sport_id_fkey;
       olimpic          postgres    false    216    3243    221            D   G  x�]T�r�6<��)|m+��^%{�r�ge�( �u�_�H+R)WI�{�{z�i�3tg\o\G�|4=�j�*��4�HSE:��fx�~�{���c�+ҬNu��H%5}f�7��aXpu�fE��S�4�8�=m�tf^`M�fJ�
R��#�a����=��M�	l����^������7^a�8�"���ؚ`_�h�a�+CP xdJ�&L��u���Ti	��R��i���L�=�ݡ������4�������>��]R���h�AJ^���'vc9�U�eD�@�2��� ӳ|��;x;y�eA@T�������ݰ�"R�jl����W;N���x���q	^�o�w�0bY��n��N&���`?y��$�Cg����X�OR�AD
A��hョ;����j!�S۠���X����"���"��<7�� ;�����*�A�]]У����X�k]E�%�R������&���0U�R��DW��3�6���3H�������`�&x�7�����]��H���>k�$�͋�L��7>��W�'UtR$(4�N�.\�:�P��00�������C�!xMO~6�B����UK�V%+,�g�NL[���+�M)岓���,}2ݴ�1�_b*$������%�1Y7"#<?���c>���>_a}�Yэ3��o��a�eIE�)Y��jz��#����h�/,�+yN?ǹxT��嶺c��듛�;��7��e�YO�A�+2�<���W��W�P�8��E��=����~yC�$�⋤�"o��w��V��Ҫ(�Z��~X����'Z��6u���U:��$y���_�$��E�`      H   f   x�3�t,J�H-���M�I�4�4�2������9r!��l.�$b�if��Q��2��*@"�!�I9�
%�yy���F@qTq�#N#�=... 1J)8      E   f   x��1�@�z�0�E@)�D4FCg37Y�f�O�� ϡ�WLq[�ŋ{�3�S�es\�l�X��[��Oo��Gac��+�F����t)��cG���      K   <   x�3��J,H��4202��Ϯ��2�t*J�����qe�+��*x%�f�s��qqq ��B      F   -   x�3�t��I�2���)K-�2�t*�ϫJ�2����K����� ��	�      L   :   x�3�t,J�H-��2�IL�IU(I���,�2�.�����K�2�/J-.��c���� � 0      R   P   x�3�4�O-N�/)��ʯL�4202�54�5�P04�22�2��344103�2����h*-��-�,�-,L�b���� ��<     