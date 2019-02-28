--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: drink_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.drink_type AS ENUM (
    'Пиво и сидр',
    'Водка и настойки',
    'Ром',
    'Текила',
    'Виски',
    'Биттеры',
    'Вино',
    'Бренди и коньяк',
    'Коктейли',
    'Безалкогольные'
);


ALTER TYPE public.drink_type OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components (
    component_id integer NOT NULL,
    title character varying(50) NOT NULL,
    alcohol double precision
);


ALTER TABLE public.components OWNER TO postgres;

--
-- Name: components_drinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components_drinks (
    component_id integer NOT NULL,
    drink_id integer NOT NULL,
    quantity double precision
);


ALTER TABLE public.components_drinks OWNER TO postgres;

--
-- Name: components_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.components_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_id_seq OWNER TO postgres;

--
-- Name: components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.components_id_seq OWNED BY public.components.component_id;


--
-- Name: discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discounts (
    place_id integer NOT NULL,
    drink_type public.drink_type NOT NULL,
    amount double precision NOT NULL,
    description character varying(256),
    weekday integer DEFAULT 0 NOT NULL,
    time_start integer,
    time_end integer
);


ALTER TABLE public.discounts OWNER TO postgres;

--
-- Name: drinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drinks (
    drink_id integer NOT NULL,
    title character varying(50) NOT NULL,
    rating double precision,
    volume double precision,
    alcohol double precision,
    average_price double precision,
    drink_type public.drink_type
);


ALTER TABLE public.drinks OWNER TO postgres;

--
-- Name: drinks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drinks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drinks_id_seq OWNER TO postgres;

--
-- Name: drinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drinks_id_seq OWNED BY public.drinks.drink_id;


--
-- Name: places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.places (
    place_id integer NOT NULL,
    title character varying(50) NOT NULL,
    address character varying(100),
    rating double precision,
    average_bill double precision
);


ALTER TABLE public.places OWNER TO postgres;

--
-- Name: places_drinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.places_drinks (
    place_id integer NOT NULL,
    drink_id integer NOT NULL
);


ALTER TABLE public.places_drinks OWNER TO postgres;

--
-- Name: places_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.places_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.places_id_seq OWNER TO postgres;

--
-- Name: places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.places_id_seq OWNED BY public.places.place_id;


--
-- Name: places_snacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.places_snacks (
    place_id integer NOT NULL,
    snack_id integer NOT NULL
);


ALTER TABLE public.places_snacks OWNER TO postgres;

--
-- Name: snacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snacks (
    snack_id integer NOT NULL,
    title character varying(50) NOT NULL,
    rating double precision,
    volume double precision,
    average_price double precision
);


ALTER TABLE public.snacks OWNER TO postgres;

--
-- Name: snacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.snacks_id_seq OWNER TO postgres;

--
-- Name: snacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snacks_id_seq OWNED BY public.snacks.snack_id;


--
-- Name: components component_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components ALTER COLUMN component_id SET DEFAULT nextval('public.components_id_seq'::regclass);


--
-- Name: drinks drink_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drinks ALTER COLUMN drink_id SET DEFAULT nextval('public.drinks_id_seq'::regclass);


--
-- Name: places place_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places ALTER COLUMN place_id SET DEFAULT nextval('public.places_id_seq'::regclass);


--
-- Name: snacks snack_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snacks ALTER COLUMN snack_id SET DEFAULT nextval('public.snacks_id_seq'::regclass);


--
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.components (component_id, title, alcohol) FROM stdin;
1	Водка	40
\.


--
-- Data for Name: components_drinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.components_drinks (component_id, drink_id, quantity) FROM stdin;
\.


--
-- Data for Name: discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discounts (place_id, drink_type, amount, description, weekday, time_start, time_end) FROM stdin;
\.


--
-- Data for Name: drinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drinks (drink_id, title, rating, volume, alcohol, average_price, drink_type) FROM stdin;
\.


--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.places (place_id, title, address, rating, average_bill) FROM stdin;
\.


--
-- Data for Name: places_drinks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.places_drinks (place_id, drink_id) FROM stdin;
\.


--
-- Data for Name: places_snacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.places_snacks (place_id, snack_id) FROM stdin;
\.


--
-- Data for Name: snacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snacks (snack_id, title, rating, volume, average_price) FROM stdin;
\.


--
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.components_id_seq', 2, true);


--
-- Name: drinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drinks_id_seq', 1, false);


--
-- Name: places_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.places_id_seq', 1, false);


--
-- Name: snacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snacks_id_seq', 1, false);


--
-- Name: components_drinks components_drinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_drinks
    ADD CONSTRAINT components_drinks_pkey PRIMARY KEY (component_id, drink_id);


--
-- Name: components components_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pk PRIMARY KEY (component_id);


--
-- Name: discounts discounts_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pk PRIMARY KEY (place_id, drink_type, amount);


--
-- Name: drinks drinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drinks
    ADD CONSTRAINT drinks_pkey PRIMARY KEY (drink_id);


--
-- Name: places_drinks places_drinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places_drinks
    ADD CONSTRAINT places_drinks_pkey PRIMARY KEY (place_id, drink_id);


--
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (place_id);


--
-- Name: places_snacks places_snacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places_snacks
    ADD CONSTRAINT places_snacks_pkey PRIMARY KEY (place_id, snack_id);


--
-- Name: snacks snacks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snacks
    ADD CONSTRAINT snacks_pk PRIMARY KEY (snack_id);


--
-- Name: components_drinks components_drinks_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_drinks
    ADD CONSTRAINT components_drinks_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(component_id) ON UPDATE CASCADE;


--
-- Name: components_drinks components_drinks_drink_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components_drinks
    ADD CONSTRAINT components_drinks_drink_id_fkey FOREIGN KEY (drink_id) REFERENCES public.drinks(drink_id) ON UPDATE CASCADE;


--
-- Name: discounts discounts_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.places(place_id);


--
-- Name: places_drinks places_drinks_drink_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places_drinks
    ADD CONSTRAINT places_drinks_drink_id_fkey FOREIGN KEY (drink_id) REFERENCES public.drinks(drink_id);


--
-- Name: places_drinks places_drinks_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places_drinks
    ADD CONSTRAINT places_drinks_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.places(place_id);


--
-- Name: places_snacks places_snacks_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places_snacks
    ADD CONSTRAINT places_snacks_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.places(place_id);


--
-- Name: places_snacks places_snacks_snack_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places_snacks
    ADD CONSTRAINT places_snacks_snack_id_fkey FOREIGN KEY (snack_id) REFERENCES public.snacks(snack_id);


--
-- PostgreSQL database dump complete
--

