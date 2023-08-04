--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-08-04 16:46:56 +07

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 17115)
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: nguyenduyhieu
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO nguyenduyhieu;

--
-- TOC entry 221 (class 1259 OID 17270)
-- Name: comments; Type: TABLE; Schema: public; Owner: nguyenduyhieu
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    content text,
    user_id bigint NOT NULL,
    post_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO nguyenduyhieu;

--
-- TOC entry 220 (class 1259 OID 17269)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: nguyenduyhieu
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO nguyenduyhieu;

--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 220
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nguyenduyhieu
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 219 (class 1259 OID 17174)
-- Name: posts; Type: TABLE; Schema: public; Owner: nguyenduyhieu
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    title character varying,
    banner character varying,
    introduction text,
    content text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.posts OWNER TO nguyenduyhieu;

--
-- TOC entry 218 (class 1259 OID 17173)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: nguyenduyhieu
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO nguyenduyhieu;

--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 218
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nguyenduyhieu
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- TOC entry 214 (class 1259 OID 16584)
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: nguyenduyhieu
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO nguyenduyhieu;

--
-- TOC entry 216 (class 1259 OID 17050)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    phone character varying(20),
    password_digest character varying,
    role character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17049)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3481 (class 2604 OID 17273)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 3480 (class 2604 OID 17177)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 3479 (class 2604 OID 17053)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3641 (class 0 OID 17115)
-- Dependencies: 217
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-07-14 13:31:11.650924	2023-07-14 13:31:11.650924
\.


--
-- TOC entry 3645 (class 0 OID 17270)
-- Dependencies: 221
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.comments (id, content, user_id, post_id, created_at, updated_at) FROM stdin;
28	chào kakibara	24	14	2023-08-03 16:52:22.18825	2023-08-03 16:52:22.18825
29	xin chào VKu	27	11	2023-08-04 08:27:02.7377	2023-08-04 08:27:02.7377
\.


--
-- TOC entry 3643 (class 0 OID 17174)
-- Dependencies: 219
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.posts (id, title, banner, introduction, content, created_at, updated_at) FROM stdin;
8	Tiêu đề 123 6577	355894175_807127320684153_5170748113053751911_n.jpg	giới thiệu td ghh	ndung 123456	2023-07-30 04:04:29.917498	2023-08-01 11:31:17.580076
13	xin chào Việt Nam 	z4437682087012_61143439c1af109059765aae5ace3e01.jpg	giới thiệu 12 	ndung 123	2023-08-02 15:17:32.654826	2023-08-02 15:17:32.654826
14	Kakibara	istockphoto-177228186-612x612.jpg	giới thiệu là thú thân thiện 	ndung 	2023-08-02 15:42:38.677275	2023-08-03 14:46:36.828108
11	chúa tể Ngoại Giao 	dep.jpg	con kakibara	Ngoại giao mãi đỉnh 	2023-08-01 11:12:26.277655	2023-08-04 09:36:29.065063
\.


--
-- TOC entry 3638 (class 0 OID 16584)
-- Dependencies: 214
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.schema_migrations (version) FROM stdin;
20230712104722
20230713051709
20230714010219
20230714022553
20230714022559
20230714022600
20230714022601
20230714094605
20230714101232
20230714112827
20230714133056
20230714133516
20230714155108
20230802022927
\.


--
-- TOC entry 3640 (class 0 OID 17050)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, username, phone, password_digest, role) FROM stdin;
18	hieu23r@gmail.com	hieu123	0358695833	$2a$12$UWCX65tRGaJxnIOaAPQADe6HZAJFbUxiC.LBS8.DvoWhJwrUVPX8G	Admin
19	h245@gmail.com	h245	0358605873	$2a$12$SSdt0XOvVtcG2TOeW0hFCu6mj1tP5cSh1qR8.INlanlS/N5Cv7DoG	Admin
20	h234@gmail.com	h234	0358606833	$2a$12$mTafeR9G4Q0DJ3jaGJ6z7.0U7xe0uvxdWswZCLJWF0qZkk56lES96	User
13	mail@gmail.com	who	01234569	$2a$12$xr/aecdSR7V74g0.R04fc..o5yVlArrX68N5B2G2AOvjYP22MtRIS	User
22	hieu2s3766@gmail.com	hieu1902@	0351605833	$2a$12$xymSvWSIvYPH5Ru586zFz.gJJv9FPf7JfL1a5hH3zQ1YjL.t/evva	User
24	hieund.2ss2it@vku.udn.vn	hieu2004@	2913586385	$2a$12$H0Z6NsX6BbgzkhPtt272De4RKtAlAXD.XSu.FFqWtMNf0QYUbdxKS	Admin
15	thuan@gmail.com	anhiusua.223490	0358605839	$2a$12$1voYW5MkvxE./KQES1Q2l.7SbBXpWtx96SJ5TfKxbKbE2Yl27hIsS	Admin
25	hieu1902@gmail.com	hieu1903@	7358605833	$2a$12$vV3SZbjeliIKi9Pcxu6YturxIPW4MxCzNWIh18oCFWyvJ6GABe3bq	Admin
23	hieund.2s2it@vku.udn.vn	hieu2202@	1913586385	$2a$12$4khBIW6XZn/DzaUai6jPfuVInKDFkAFCZqerQyrzcFyH4/57Ql0By	Admin
26	hieu237d66@gmail.com	hieu1904@	0978988896	$2a$12$PPMFxJMp7opfL5HvpUASuesT2VbdEPMNE/XVNcSVR9/RPFHXrjX42	User
27	hieu2376ww6@gmail.com	hieu1912@	0350605833	$2a$12$3cc1aeE9CPseAwpTWvpDmu/ygrQVcHF8IpszEmBh7LcCSWMhckVs2	User
28	hieu23sssss766@gmail.com	hieu2005@	0358605933	$2a$12$xfVnD3aEchbG0DWxDS5oPeShom4bji90L5Jiv40QpSL9etiqZY5AK	Admin
29	hieu19112@gmail.com	hieu19112@	0358605830	$2a$12$E6ez1UfsK2DDdm14s9dLheoQ7ovohR0WEK0.8ck0nNwT82Q8P9SZm	User
30	hieu2376ssss6@gmail.com	hieu888@	0358605813	$2a$12$zhi5/yrCsF2SHdlVjTJrdupkTITixGWZsq7IDHGLoV9HAk0aUyM.i	Admin
\.


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 220
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nguyenduyhieu
--

SELECT pg_catalog.setval('public.comments_id_seq', 31, true);


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 218
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nguyenduyhieu
--

SELECT pg_catalog.setval('public.posts_id_seq', 14, true);


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 30, true);


--
-- TOC entry 3487 (class 2606 OID 17121)
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- TOC entry 3491 (class 2606 OID 17277)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 3489 (class 2606 OID 17181)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 16590)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3485 (class 2606 OID 17057)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3492 (class 1259 OID 17289)
-- Name: index_comments_on_post_id; Type: INDEX; Schema: public; Owner: nguyenduyhieu
--

CREATE INDEX index_comments_on_post_id ON public.comments USING btree (post_id);


--
-- TOC entry 3493 (class 1259 OID 17288)
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: nguyenduyhieu
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- TOC entry 3494 (class 2606 OID 17278)
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3495 (class 2606 OID 17283)
-- Name: comments fk_rails_2fd19c0db7; Type: FK CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_2fd19c0db7 FOREIGN KEY (post_id) REFERENCES public.posts(id);


-- Completed on 2023-08-04 16:46:57 +07

--
-- PostgreSQL database dump complete
--

