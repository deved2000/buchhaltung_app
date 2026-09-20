--
-- PostgreSQL database dump
--

\restrict taWzagBxNExa4hHmbOWM0D0L8H5hw0ORxqPBFNu5LL8ga8ixmimOQ5hk9EH2lDi

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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
-- Name: sync_monat(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sync_monat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.monat := date_trunc('month', NEW.datum)::date;
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ausgabe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ausgabe (
    sid integer NOT NULL,
    artikel character varying(255) NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    betrag numeric(10,2) NOT NULL,
    fk_kategorie_sid integer NOT NULL,
    datum date NOT NULL,
    fk_konto_sid integer NOT NULL,
    monat date DEFAULT (date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone))::date NOT NULL,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0
);


--
-- Name: ausgaben_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ausgaben_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ausgaben_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ausgaben_sid_seq OWNED BY public.ausgabe.sid;


--
-- Name: einnahme; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.einnahme (
    sid integer NOT NULL,
    fk_quelle_sid integer NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    betrag numeric(10,2) NOT NULL,
    datum date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fk_konto_sid integer NOT NULL,
    monat date DEFAULT (date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone))::date NOT NULL,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0
);


--
-- Name: einnahmen_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.einnahmen_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: einnahmen_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.einnahmen_sid_seq OWNED BY public.einnahme.sid;


--
-- Name: kategorie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kategorie (
    sid integer NOT NULL,
    aname character varying(100) NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0,
    column8 character varying(50),
    column9 character varying(128)
);


--
-- Name: kategorie_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kategorie_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kategorie_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kategorie_sid_seq OWNED BY public.kategorie.sid;


--
-- Name: konto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.konto (
    sid integer NOT NULL,
    aname character varying(100) NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0,
    "sid,aname,beschreibung,erstellt_am,validfrom,validto,fk_records" character varying(50),
    startsaldo numeric(10,2) DEFAULT 0
);


--
-- Name: konto_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.konto_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: konto_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.konto_sid_seq OWNED BY public.konto.sid;


--
-- Name: quelle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quelle (
    sid integer NOT NULL,
    aname character varying(100) NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0
);


--
-- Name: quelle_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quelle_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quelle_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quelle_sid_seq OWNED BY public.quelle.sid;


--
-- Name: recordstate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recordstate (
    sid integer NOT NULL,
    aname character varying(100) NOT NULL,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0,
    beschreibung character varying(50)
);


--
-- Name: recordstate_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recordstate_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recordstate_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recordstate_sid_seq OWNED BY public.recordstate.sid;


--
-- Name: schuldner; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schuldner (
    sid integer NOT NULL,
    aname character varying(100) NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0
);


--
-- Name: schuldner_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schuldner_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schuldner_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schuldner_sid_seq OWNED BY public.schuldner.sid;


--
-- Name: transaktion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transaktion (
    sid integer NOT NULL,
    fk_konto_von_sid integer NOT NULL,
    fk_konto_zu_sid integer NOT NULL,
    beschreibung character varying(1000) DEFAULT NULL::character varying,
    betrag numeric(10,2) NOT NULL,
    datum date NOT NULL,
    monat date DEFAULT (date_trunc('month'::text, (CURRENT_DATE)::timestamp with time zone))::date NOT NULL,
    erstellt_am timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validfrom timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validto timestamp without time zone,
    fk_recordstate_sid integer DEFAULT 0,
    fk_schuldner_sid integer DEFAULT 1
);


--
-- Name: transaktionen_sid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transaktionen_sid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transaktionen_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transaktionen_sid_seq OWNED BY public.transaktion.sid;


--
-- Name: v_ausgaben_monat_kategorie; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_ausgaben_monat_kategorie AS
 WITH bereich AS (
         SELECT min(ausgabe.monat) AS von,
            max(ausgabe.monat) AS bis
           FROM public.ausgabe
          WHERE (ausgabe.fk_recordstate_sid = 0)
        ), monate AS (
         SELECT (g.g)::date AS monat
           FROM bereich,
            LATERAL generate_series((bereich.von)::timestamp without time zone, (bereich.bis)::timestamp without time zone, '1 mon'::interval) g(g)
        ), summen AS (
         SELECT ausgabe.monat,
            ausgabe.fk_kategorie_sid,
            sum(ausgabe.betrag) AS betrag
           FROM public.ausgabe
          WHERE (ausgabe.fk_recordstate_sid = 0)
          GROUP BY ausgabe.monat, ausgabe.fk_kategorie_sid
        )
 SELECT m.monat,
    to_char((m.monat)::timestamp with time zone, 'MM.YYYY'::text) AS monat_label,
    ka.sid AS kategorie_sid,
    ka.aname AS kategorie,
    COALESCE(s.betrag, (0)::numeric) AS betrag,
    sum(COALESCE(s.betrag, (0)::numeric)) OVER (PARTITION BY m.monat) AS monat_gesamt
   FROM ((monate m
     CROSS JOIN public.kategorie ka)
     LEFT JOIN summen s ON (((s.monat = m.monat) AND (s.fk_kategorie_sid = ka.sid))))
  WHERE (ka.fk_recordstate_sid = 0);


--
-- Name: v_bewegungen; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_bewegungen AS
 SELECT a.sid AS source_sid,
    'ausgabe'::text AS source_typ,
    a.betrag,
    a.fk_konto_sid AS konto_von_sid,
    NULL::integer AS konto_zu_sid,
    a.datum,
    a.monat
   FROM public.ausgabe a
  WHERE (a.fk_recordstate_sid = 0)
UNION ALL
 SELECT e.sid AS source_sid,
    'einnahme'::text AS source_typ,
    e.betrag,
    NULL::integer AS konto_von_sid,
    e.fk_konto_sid AS konto_zu_sid,
    e.datum,
    e.monat
   FROM public.einnahme e
  WHERE (e.fk_recordstate_sid = 0)
UNION ALL
 SELECT t.sid AS source_sid,
    'transaktion'::text AS source_typ,
    t.betrag,
    t.fk_konto_von_sid AS konto_von_sid,
    t.fk_konto_zu_sid AS konto_zu_sid,
    t.datum,
    t.monat
   FROM public.transaktion t
  WHERE (t.fk_recordstate_sid = 0);


--
-- Name: v_monatssalden; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_monatssalden AS
 WITH alle_monate AS (
         SELECT DISTINCT v_bewegungen.monat
           FROM public.v_bewegungen
        ), alle_konten AS (
         SELECT k.sid AS konto_sid,
            k.aname AS konto_name,
            k.startsaldo,
            m.monat
           FROM (public.konto k
             CROSS JOIN alle_monate m)
          WHERE (k.fk_recordstate_sid = 0)
        ), bewegungen_pro_konto AS (
         SELECT v_bewegungen.monat,
            v_bewegungen.konto_von_sid AS konto_sid,
            (- v_bewegungen.betrag) AS betrag
           FROM public.v_bewegungen
          WHERE (v_bewegungen.konto_von_sid IS NOT NULL)
        UNION ALL
         SELECT v_bewegungen.monat,
            v_bewegungen.konto_zu_sid AS konto_sid,
            v_bewegungen.betrag
           FROM public.v_bewegungen
          WHERE (v_bewegungen.konto_zu_sid IS NOT NULL)
        ), kumuliert AS (
         SELECT ak.konto_sid,
            ak.konto_name,
            ak.monat,
            (ak.startsaldo + COALESCE(sum(b.betrag) FILTER (WHERE (b.monat <= ak.monat)), (0)::numeric)) AS saldo_ende,
            (ak.startsaldo + COALESCE(sum(b.betrag) FILTER (WHERE (b.monat < ak.monat)), (0)::numeric)) AS saldo_anfang
           FROM (alle_konten ak
             LEFT JOIN bewegungen_pro_konto b ON ((b.konto_sid = ak.konto_sid)))
          GROUP BY ak.konto_sid, ak.konto_name, ak.startsaldo, ak.monat
        )
 SELECT konto_sid,
    konto_name,
    monat,
    to_char((monat)::timestamp with time zone, 'FMMonth YYYY'::text) AS monat_label,
    (saldo_anfang)::numeric(10,2) AS saldo_anfang,
    (saldo_ende)::numeric(10,2) AS saldo_ende
   FROM kumuliert
  ORDER BY konto_name, monat;


--
-- Name: ausgabe sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ausgabe ALTER COLUMN sid SET DEFAULT nextval('public.ausgaben_sid_seq'::regclass);


--
-- Name: einnahme sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.einnahme ALTER COLUMN sid SET DEFAULT nextval('public.einnahmen_sid_seq'::regclass);


--
-- Name: kategorie sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kategorie ALTER COLUMN sid SET DEFAULT nextval('public.kategorie_sid_seq'::regclass);


--
-- Name: konto sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.konto ALTER COLUMN sid SET DEFAULT nextval('public.konto_sid_seq'::regclass);


--
-- Name: quelle sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quelle ALTER COLUMN sid SET DEFAULT nextval('public.quelle_sid_seq'::regclass);


--
-- Name: recordstate sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recordstate ALTER COLUMN sid SET DEFAULT nextval('public.recordstate_sid_seq'::regclass);


--
-- Name: schuldner sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schuldner ALTER COLUMN sid SET DEFAULT nextval('public.schuldner_sid_seq'::regclass);


--
-- Name: transaktion sid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaktion ALTER COLUMN sid SET DEFAULT nextval('public.transaktionen_sid_seq'::regclass);


--
-- Name: ausgabe ausgaben_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ausgabe
    ADD CONSTRAINT ausgaben_pkey PRIMARY KEY (sid);


--
-- Name: einnahme einnahmen_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.einnahme
    ADD CONSTRAINT einnahmen_pkey PRIMARY KEY (sid);


--
-- Name: kategorie kategorie_aname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kategorie
    ADD CONSTRAINT kategorie_aname_key UNIQUE (aname);


--
-- Name: kategorie kategorie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kategorie
    ADD CONSTRAINT kategorie_pkey PRIMARY KEY (sid);


--
-- Name: konto konto_aname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.konto
    ADD CONSTRAINT konto_aname_key UNIQUE (aname);


--
-- Name: konto konto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.konto
    ADD CONSTRAINT konto_pkey PRIMARY KEY (sid);


--
-- Name: quelle quelle_aname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quelle
    ADD CONSTRAINT quelle_aname_key UNIQUE (aname);


--
-- Name: quelle quelle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quelle
    ADD CONSTRAINT quelle_pkey PRIMARY KEY (sid);


--
-- Name: recordstate recordstate_aname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recordstate
    ADD CONSTRAINT recordstate_aname_key UNIQUE (aname);


--
-- Name: recordstate recordstate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recordstate
    ADD CONSTRAINT recordstate_pkey PRIMARY KEY (sid);


--
-- Name: schuldner schuldner_aname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schuldner
    ADD CONSTRAINT schuldner_aname_key UNIQUE (aname);


--
-- Name: schuldner schuldner_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schuldner
    ADD CONSTRAINT schuldner_pkey PRIMARY KEY (sid);


--
-- Name: transaktion transaktionen_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transaktion
    ADD CONSTRAINT transaktionen_pkey PRIMARY KEY (sid);


--
-- Name: ausgabe trg_sync_monat_ausgabe; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_sync_monat_ausgabe BEFORE INSERT OR UPDATE ON public.ausgabe FOR EACH ROW EXECUTE FUNCTION public.sync_monat();


--
-- Name: einnahme trg_sync_monat_einnahme; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_sync_monat_einnahme BEFORE INSERT OR UPDATE ON public.einnahme FOR EACH ROW EXECUTE FUNCTION public.sync_monat();


--
-- Name: transaktion trg_sync_monat_transaktion; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_sync_monat_transaktion BEFORE INSERT OR UPDATE ON public.transaktion FOR EACH ROW EXECUTE FUNCTION public.sync_monat();


--
-- PostgreSQL database dump complete
--

\unrestrict taWzagBxNExa4hHmbOWM0D0L8H5hw0ORxqPBFNu5LL8ga8ixmimOQ5hk9EH2lDi

--
-- PostgreSQL database dump
--

\restrict mQKWPl0WFxTJFtjZCPfmMkcFq6fwmzPHMF1n33x7qeXeJC1G2p14l76KY2OMDJS

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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
-- Data for Name: recordstate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recordstate (sid, aname, erstellt_am, validfrom, validto, fk_recordstate_sid, beschreibung) FROM stdin;
0	gültig	2026-02-13 23:00:20.392279	2026-02-13 23:00:20.392279	\N	0	
1	ungültig	2026-02-13 23:00:20.392279	2026-02-13 23:00:20.392279	\N	0	
2	gelöscht	2026-02-13 23:00:20.392279	2026-02-13 23:00:20.392279	\N	0	
\.


--
-- Name: recordstate_sid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recordstate_sid_seq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict mQKWPl0WFxTJFtjZCPfmMkcFq6fwmzPHMF1n33x7qeXeJC1G2p14l76KY2OMDJS

