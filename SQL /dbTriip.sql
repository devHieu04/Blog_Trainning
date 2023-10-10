--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-10-10 22:57:49 +07

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
-- TOC entry 3654 (class 0 OID 0)
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
-- TOC entry 3655 (class 0 OID 0)
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
    role character varying(255),
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    provider character varying,
    uid character varying
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
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3482 (class 2604 OID 17273)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 3481 (class 2604 OID 17177)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 3479 (class 2604 OID 17053)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3644 (class 0 OID 17115)
-- Dependencies: 217
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-07-14 13:31:11.650924	2023-07-14 13:31:11.650924
\.


--
-- TOC entry 3648 (class 0 OID 17270)
-- Dependencies: 221
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.comments (id, content, user_id, post_id, created_at, updated_at) FROM stdin;
41	hi Hiếu	48	13	2023-09-09 13:19:27.884069	2023-09-09 13:19:27.884069
42	kkm	48	13	2023-09-09 13:24:58.167613	2023-09-09 13:24:58.167613
43	xin chào	48	13	2023-09-09 13:31:13.045513	2023-09-09 13:31:13.045513
44	nnknknk	48	13	2023-09-09 13:38:43.166624	2023-09-09 13:38:43.166624
46	jnhhh	51	26	2023-09-11 09:04:06.819299	2023-09-11 09:04:06.819299
47		51	26	2023-09-11 09:04:17.24002	2023-09-11 09:04:17.24002
52	làm dev nhàn không em đéo nhàn lắm	45	13	2023-09-11 09:50:39.250633	2023-09-11 09:50:46.096753
55	đẹp chai quá anh iu eoiw	45	11	2023-09-11 09:53:27.750182	2023-09-11 09:53:27.750182
57	djhjdh	53	11	2023-09-20 03:13:21.53962	2023-09-20 03:13:21.53962
59	nkdnk	53	13	2023-09-20 03:42:47.361878	2023-09-20 03:42:47.361878
60	ncmnmnc	53	14	2023-09-20 03:42:52.813704	2023-09-20 03:42:52.813704
61	ok gud	53	26	2023-09-23 01:33:58.391442	2023-09-23 01:33:58.391442
62	hi bro	53	26	2023-09-23 01:35:03.896112	2023-09-23 01:35:03.896112
63	kkk	55	26	2023-09-30 10:32:37.287516	2023-09-30 10:32:37.287516
64	jkkdkjkdjd	55	13	2023-09-30 10:34:23.39623	2023-09-30 10:34:23.39623
65	kmdkfmkdf	55	26	2023-09-30 11:15:02.151436	2023-09-30 11:15:02.151436
66	hnhjnhnuhu	56	26	2023-09-30 11:16:17.187119	2023-09-30 11:16:17.187119
67	mmkdmdkd	55	26	2023-10-02 14:02:09.130653	2023-10-02 14:02:09.130653
68	nkdnkdkd\n	55	26	2023-10-02 16:47:42.560538	2023-10-02 16:47:42.560538
70	hdhd	59	26	2023-10-04 03:37:38.228054	2023-10-04 03:37:38.228054
71	hi	55	13	2023-10-08 06:45:43.008791	2023-10-08 06:45:43.008791
72	njnjj	56	29	2023-10-08 06:48:13.006219	2023-10-08 06:48:13.006219
73	bjb	56	29	2023-10-08 06:48:16.174299	2023-10-08 06:48:16.174299
29	xin chào VKu	27	11	2023-08-04 08:27:02.7377	2023-08-04 08:27:02.7377
32	kkk	22	11	2023-08-28 11:22:25.767052	2023-08-28 11:22:25.767052
37	haiii babaaba\n	35	11	2023-08-29 03:16:54.023714	2023-08-29 04:35:25.075603
\.


--
-- TOC entry 3646 (class 0 OID 17174)
-- Dependencies: 219
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: nguyenduyhieu
--

COPY public.posts (id, title, banner, introduction, content, created_at, updated_at) FROM stdin;
26	d ndjnkfjd	istockphoto-177228186-612x612.jpg	 hcjhjdhjcdhjc	s ccbdbc	2023-09-11 00:54:16.701249	2023-09-20 17:27:22.958674
13	xin chào Việt Nam mình là dev Hiếu 	avtgit.jpg	22IT089	VKU k22	2023-08-02 15:17:32.654826	2023-09-10 02:08:18.21399
14	Kakibara	dep.jpg	giới thiệu là thú thân thiện 	ndung 	2023-08-02 15:42:38.677275	2023-09-11 08:58:05.381972
27	Giải tích 1 	355221812_1417157109123325_7437182156216550942_n.jpg	thầy Thịnh	không nhớ học gì	2023-09-11 09:57:12.541671	2023-09-11 09:58:54.655723
29	hdihid	377122056_1087058879371066_1148954161170298210_n__1_.jpg	dmkmdk	dkmkdm	2023-09-20 03:41:08.454149	2023-09-20 03:41:08.454149
11	chúa tể Ngoại Giao 	z4696796272327_29d00510af2aae31d8676a2db1768f6d.jpg	con kakibara	Ngoại giao mãi đỉnh 	2023-08-01 11:12:26.277655	2023-09-20 03:41:49.477134
\.


--
-- TOC entry 3641 (class 0 OID 16584)
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
20230908011207
20230925202421
20230929150327
20230930094324
\.


--
-- TOC entry 3643 (class 0 OID 17050)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, username, phone, password_digest, role, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, provider, uid) FROM stdin;
47	hieu12345678h@hh.com	hieu12345678h@hh.com	03586058330	\N	Admin	$2a$12$YiKnfqznMLyyN4hGsjTD3uY4RosskZEM5zEoSOUEg5LvwuEL5An4y	\N	\N	\N	\N	\N
59	clblaptrinh.it@gmail.com	clblaptrinh.it@gmail.com	8321096888	\N	User	$2a$12$cNqjrL6CwkDYBKMFNdxfDuUbRdKHuo09/BabyegB4sN9oWWm0JQZ2	\N	\N	\N	google	106792606258445212891
23	hieund.2s2it@vku.udn.vn	hieu2202@	1913586385	$2a$12$4khBIW6XZn/DzaUai6jPfuVInKDFkAFCZqerQyrzcFyH4/57Ql0By	Admin		\N	\N	\N	\N	\N
27	hieu2376ww6@gmail.com	hieu1912@	0350605833	$2a$12$3cc1aeE9CPseAwpTWvpDmu/ygrQVcHF8IpszEmBh7LcCSWMhckVs2	User		\N	\N	\N	\N	\N
28	hieu23sssss766@gmail.com	hieu2005@	0358605933	$2a$12$xfVnD3aEchbG0DWxDS5oPeShom4bji90L5Jiv40QpSL9etiqZY5AK	Admin		\N	\N	\N	\N	\N
29	hieu19112@gmail.com	hieu19112@	0358605830	$2a$12$E6ez1UfsK2DDdm14s9dLheoQ7ovohR0WEK0.8ck0nNwT82Q8P9SZm	User		\N	\N	\N	\N	\N
31	hieu2376ssss890006@gmail.com	hieu19002@	0978989890	$2a$12$xn99uPR1HM7Rq2kdlO0J/e3P0VcZ24P87.ukIim2RBlaPhGWiyx2q	Admin		\N	\N	\N	\N	\N
32	addddddm@gmail.com	hieu190290009@	0978909896	$2a$12$4AIdqLSkK3IzElHO557/POL7.WhiF0Z7CZuaj4TP9466o95kQgSC6	User		\N	\N	\N	\N	\N
33	hieu1922@gmail.com	hieu1922@	0358605831	$2a$12$8w44quwQGdm3yW8vRT.TwuewfHDd1FmY.f5zFnuL3SsLsxZzvs.iC	Admin		\N	\N	\N	\N	\N
34	123@gmail.com	hieu1922@123	090511901	$2a$12$nP/ZqVnIhXk3gUs29MQm9eGHZ/xG2wDPSHbqS6JtfiokMeP1DFaau	Admin		\N	\N	\N	\N	\N
60	nguyenduyhieu.20bhhhbh0520042022@gmail.com	jjbj	035788605833	\N	User	$2a$12$fcwDQ5AVUDyGG43AY4Y2uOtff19O7fykxHe2EWpka2ALjC.nYa026	\N	\N	\N	\N	\N
35	hieu233766@gmail.com	hieu1922@1	0358615833	$2a$12$Vj5yqZtnwscerWisNWGPHuu8zwYqDd15ys4Ne3EndR9gZ1h/KkLz.	User		\N	\N	\N	\N	\N
36	hieu13766@gmail.com	hieu1922@12	0358605133	$2a$12$ADdwmVv3HH3sZDBkhBLATOzE9HKFPPwkWQGhlRJ0OYVidw8qc6zWy	Admin		\N	\N	\N	\N	\N
51	hieu1234567890@gmail.com	hieu1234567890	035860583312	\N	User	$2a$12$Zi4MRtEQ1WNlq3.Bh5rYdOyw90qQaF8emEpMl/amQhhIysDXh.inq	\N	\N	\N	\N	\N
37	hieu2376ssssssssssssz6@gmail.com	hieu19022@	90909090909090	$2a$12$WypV5TOv4iFBXXVmPuzrxeo/ZKdBIcWMjKxKfZjzOa7v6YqzayZLO	Admin		\N	\N	\N	\N	\N
38	nguyensduyhieu.200520042022@gmail.com	hieu190022@	0898305739	\N	Admin	$2a$12$wKKfPsikR1oeze3Wyvs5UeHmt.Ypd8ivcI11oGQ4XIpk9DHmacGXi	\N	\N	\N	\N	\N
39	nguyensduyhieu.200520042022@gmail.coms	nguyensduyhieu.200520042022@gmail.coms	0358605831	\N	User	$2a$12$1dpzXbevxcRAjUW68Z7eqOQDL176rnN1ffXLBzLXgzB/I2DoDhqKO	\N	\N	\N	\N	\N
40	hieu2376126@gmail.com	hieu19022@1	03586058312	\N	Admin	$2a$12$nlgMtGuNLZqr/PoYN7LQOeb1.ls0GWqOGyr01LTC6NqUyT8xtFU7y	\N	\N	\N	\N	\N
41	hieu23761236@gmail.com	123456Hieu@	035860583122	\N	Admin	$2a$12$7FOhn8qpZAbVyiiGbFd3IenbQaTvVAOEwQmCxHrnkyAUwXhG1lPK6	\N	\N	\N	\N	\N
42	hieu237612346@gmail.com	123456Hieu@1	035860583122	\N	Admin	$2a$12$JCjx7Ks.iox9JxxMU75qRes9ZIOtGdQwE266mKusNkuo1PCWXazTu	\N	\N	\N	\N	\N
43	hieu223766@gmail.com	hieu19022@12	035860583128	\N	Admin	$2a$12$vtCzLq0BQuG02dBy1zGasukly5pwl4btRytdwZjEq0qO.9YHIsSg2	\N	\N	\N	\N	\N
22	hieu2s3766@gmail.com	hieu1902@56789	0351605833	$2a$12$xymSvWSIvYPH5Ru586zFz.gJJv9FPf7JfL1a5hH3zQ1YjL.t/evva	User		\N	\N	\N	\N	\N
45	hieu12345678@h.com	hieu12345678@h	0058605833	\N	User	$2a$12$/716cZ/Icfc7IIXAGLm4fuJz/Pks4qcg6GK6Il6HEip/7m34/wJIW	\N	\N	\N	\N	\N
52	hieu12345678h909090@gmail.com	hieu12345678@h909090.com	03586052345833	\N	Admin	$2a$12$I7LLuInSu7nh4Y.u2uqwNO4A4WckK6V3Yf0rzyRhM0rGSr2tHBd9C	\N	\N	\N	\N	\N
48	hieu2376896@gmail.com	hieu2376896@gmail.com	0358615833	\N	Admin	$2a$12$WVeJFO9sdvjS8jH2Y.x1deKa8ySFbxGsRfuVWVVDecy96UTtMfmyS	\N	\N	\N	\N	\N
44	hieu12345678@gmail.com	hieu12345678@gmail.com	0358605836	\N	Admin	$2a$12$pNRXLPHf52c6.1xZERpXW.bnWX37YUAAbgkR/pAucFZUVhWxZdSVG	\N	\N	\N	\N	\N
53	hieu80909@gmail.com	hieu80909@gmail.com	03586785833	\N	User	$2a$12$M23/YEEtfmf8EHD52yUEJe1u49xxo18ZBiccgxnRlHHs6PIqdF9Ea	\N	\N	\N	\N	\N
54	hieu809098989@gmail.com	hieu809098989@gmail.com	7899900865432	\N	Admin	$2a$12$5Nc7ua5qaX8m4RI7RTREueJ/UxewR4OkWkLEryt2F9kX5eDrkZv4W	\N	\N	\N	\N	\N
55	hieu23766@gmail.com	hieu23766@gmail.com	8810730309	\N	User	$2a$12$jbrzc2zQWAoT3XibgXHRWelVKm6d8Q9zdtb1xNe31yu1U3w3MReM2	\N	\N	\N	google	103519523073410419644
56	nguyenduyhieu.200520042022@gmail.com	nguyenduyhieu.200520042022@gmail.com	7860403550	\N	User	$2a$12$owSOCgVGzjGfxh0pP2Z74ucXF4GvMX394IpMx8P3QDxjVh25YQWE2	\N	\N	\N	google	108322616307394377834
57	kieuntd.23el@vku.udn.vn	kieuntd.23el@vku.udn.vn	3529939919	\N	User	$2a$12$bYuE71akLJvLe24ETnqSZ.At.E99xq0FZf8ttDQ6KH/akybsE/Cke	\N	\N	\N	google	117742109575809438474
\.


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 220
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nguyenduyhieu
--

SELECT pg_catalog.setval('public.comments_id_seq', 73, true);


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 218
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nguyenduyhieu
--

SELECT pg_catalog.setval('public.posts_id_seq', 29, true);


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 60, true);


--
-- TOC entry 3490 (class 2606 OID 17121)
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- TOC entry 3494 (class 2606 OID 17277)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 3492 (class 2606 OID 17181)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 3484 (class 2606 OID 16590)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3488 (class 2606 OID 17057)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3495 (class 1259 OID 17289)
-- Name: index_comments_on_post_id; Type: INDEX; Schema: public; Owner: nguyenduyhieu
--

CREATE INDEX index_comments_on_post_id ON public.comments USING btree (post_id);


--
-- TOC entry 3496 (class 1259 OID 17288)
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: nguyenduyhieu
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- TOC entry 3485 (class 1259 OID 17373)
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- TOC entry 3486 (class 1259 OID 17374)
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- TOC entry 3497 (class 2606 OID 17278)
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3498 (class 2606 OID 17283)
-- Name: comments fk_rails_2fd19c0db7; Type: FK CONSTRAINT; Schema: public; Owner: nguyenduyhieu
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_2fd19c0db7 FOREIGN KEY (post_id) REFERENCES public.posts(id);


-- Completed on 2023-10-10 22:57:49 +07

--
-- PostgreSQL database dump complete
--

