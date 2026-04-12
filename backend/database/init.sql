--
-- PostgreSQL database dump
--

\restrict c3EROQgtKyfAKRq9PfLH7SsvBWMbqVWMN6nqkll9YGtSwYJyue1DfOIqafKE1hU

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.account (
    id integer NOT NULL,
    ammount numeric(12,2),
    client_id integer
);


--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    surname character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    phone_number character varying(20),
    date_creation timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- Name: transaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transaction (
    id integer,
    origin integer,
    destination integer,
    account_id integer
);


--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.account (id, ammount, client_id) FROM stdin;
1	1250.50	1001
2	0.00	1002
3	543.20	1003
4	12000.00	1004
5	87.15	1005
6	999.99	1006
7	250.00	1007
8	-45.30	1008
9	3000.00	1009
10	150.75	1010
11	780.00	1011
12	0.00	1012
13	4321.10	1013
14	65.00	1014
15	910.40	1015
16	120.00	1016
17	5600.00	1017
18	33.33	1018
19	100000.00	1019
20	250.25	1020
21	400.00	1021
22	0.00	1022
23	9999.99	1023
24	15.00	1024
25	305.60	1025
26	760.10	1026
27	88.88	1027
28	4500.00	1028
29	0.00	1029
30	123.45	1030
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, name, surname, email, password_hash, phone_number, date_creation) FROM stdin;
1001	Carlos	García	carlos.garcia@email.com	$2b$10$hash1	600123123	2024-01-01 00:00:00
1002	Ana	López	ana.lopez@email.com	$2b$10$hash2	\N	2024-01-02 00:00:00
1003	David	Ruiz	david.ruiz@email.com	$2b$10$hash3	611222333	2024-01-03 00:00:00
1004	Laura	Martín	laura.martin@email.com	$2b$10$hash4	622333444	2024-01-04 00:00:00
1005	Pedro	Sánchez	pedro.sanchez@email.com	$2b$10$hash5	\N	2024-01-05 00:00:00
1006	Marta	Gómez	marta.gomez@email.com	$2b$10$hash6	633444555	2024-01-06 00:00:00
1007	Javier	Fernández	javier.fernandez@email.com	$2b$10$hash7	644555666	2024-01-07 00:00:00
1008	Lucía	Torres	lucia.torres@email.com	$2b$10$hash8	\N	2024-01-08 00:00:00
1009	Diego	Ramos	diego.ramos@email.com	$2b$10$hash9	655666777	2024-01-09 00:00:00
1010	Elena	Navarro	elena.navarro@email.com	$2b$10$hash10	666777888	2024-01-10 00:00:00
1011	Manuel	Castro	manuel.castro@email.com	$2b$10$hash11	\N	2024-01-11 00:00:00
1012	Sofía	Ortega	sofia.ortega@email.com	$2b$10$hash12	677888999	2024-01-12 00:00:00
1013	Alberto	Delgado	alberto.delgado@email.com	$2b$10$hash13	688999000	2024-01-13 00:00:00
1014	Paula	Moreno	paula.moreno@email.com	$2b$10$hash14	\N	2024-01-14 00:00:00
1015	Adrián	Jiménez	adrian.jimenez@email.com	$2b$10$hash15	699111222	2024-01-15 00:00:00
1016	Claudia	Herrera	claudia.herrera@email.com	$2b$10$hash16	610222333	2024-01-16 00:00:00
1017	Sergio	Vega	sergio.vega@email.com	$2b$10$hash17	\N	2024-01-17 00:00:00
1018	Patricia	Molina	patricia.molina@email.com	$2b$10$hash18	620333444	2024-01-18 00:00:00
1019	Roberto	Silva	roberto.silva@email.com	$2b$10$hash19	630444555	2024-01-19 00:00:00
1020	Isabel	Rojas	isabel.rojas@email.com	$2b$10$hash20	\N	2024-01-20 00:00:00
1021	Daniel	Carrasco	daniel.carrasco@email.com	$2b$10$hash21	640555666	2024-01-21 00:00:00
1022	Verónica	Reyes	veronica.reyes@email.com	$2b$10$hash22	650666777	2024-01-22 00:00:00
1023	Iván	Medina	ivan.medina@email.com	$2b$10$hash23	\N	2024-01-23 00:00:00
1024	Carmen	Blanco	carmen.blanco@email.com	$2b$10$hash24	660777888	2024-01-24 00:00:00
1025	Raúl	Suárez	raul.suarez@email.com	$2b$10$hash25	670888999	2024-01-25 00:00:00
1026	Nuria	Romero	nuria.romero@email.com	$2b$10$hash26	\N	2024-01-26 00:00:00
1027	Óscar	Guerrero	oscar.guerrero@email.com	$2b$10$hash27	680999000	2024-01-27 00:00:00
1028	Beatriz	Flores	beatriz.flores@email.com	$2b$10$hash28	690111222	2024-01-28 00:00:00
1029	Francisco	Méndez	francisco.mendez@email.com	$2b$10$hash29	\N	2024-01-29 00:00:00
1030	Andrea	Campos	andrea.campos@email.com	$2b$10$hash30	600222333	2024-01-30 00:00:00
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transaction (id, origin, destination, account_id) FROM stdin;
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.account_id_seq', 1, false);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_seq', 1, false);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: client client_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_email_key UNIQUE (email);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: account account_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: transaction fk_accountid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT fk_accountid FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- PostgreSQL database dump complete
--

\unrestrict c3EROQgtKyfAKRq9PfLH7SsvBWMbqVWMN6nqkll9YGtSwYJyue1DfOIqafKE1hU

