--
-- TOC entry 586 (class 1247 OID 99442)
-- Name: enum_media_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_media_type AS ENUM (
    'image',
    'video',
    'audio'
);


ALTER TYPE public.enum_media_type OWNER TO postgres;

--
-- TOC entry 583 (class 1247 OID 99422)
-- Name: enum_report_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_report_status AS ENUM (
    'CANCELLED',
    'PROCESSING',
    'DISPATCHED',
    'UNASSIGNED',
    'CLOSED',
    'POSSIBLE_DUP',
    'COMPLETED',
    'DUPLICATE',
    'TIMED_OUT'
);


ALTER TYPE public.enum_report_status OWNER TO postgres;

--
-- TOC entry 580 (class 1247 OID 99413)
-- Name: enum_user_active_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_user_active_status AS ENUM (
    'ACTIVE',
    'SUSPENDEDED',
    'BLOCKED',
    'INVALID',
    'DISABLED'
);


ALTER TYPE public.enum_user_active_status OWNER TO postgres;

SET default_tablespace = '';

--
-- TOC entry 201 (class 1259 OID 99567)
-- Name: ABANDONED_REPORTS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ABANDONED_REPORTS (
    REPORTER_LAT double precision NOT NULL,
    REPORTER_LONG double precision NOT NULL,
    RESPONDER_LAT double precision NOT NULL,
    RESPONDER_LONG double precision NOT NULL,
    REMARKS character varying NOT NULL,
    DATE_CREATED date NOT NULL,
    REPORT_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL,
    REASON_ID bigint NOT NULL
);


ALTER TABLE public.ABANDONED_REPORTS OWNER TO postgres;

--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN ABANDONED_REPORTS.REMARKS; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.ABANDONED_REPORTS.REMARKS IS 'Free text describing why report was abandoned';


--
-- TOC entry 194 (class 1259 OID 99533)
-- Name: ACTIVE_CASES; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ACTIVE_CASES (
    REPORTER_LAT double precision NOT NULL,
    REPORTER_LONG double precision NOT NULL,
    RESPONDER_LAT double precision NOT NULL,
    RESPONDER_LONG double precision NOT NULL,
    REPORTER_LAST_UPDATED timestamp with time zone NOT NULL,
    RESPONDER_LAST_UPDATED timestamp with time zone NOT NULL,
    REPORT_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL
);


ALTER TABLE public.ACTIVE_CASES OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 99536)
-- Name: ACTIVE_RESPONSE_UNIT_LOCATIONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ACTIVE_RESPONSE_UNIT_LOCATIONS (
    LATITUDE double precision NOT NULL,
    LONGTITUDE double precision NOT NULL,
    DATE_CREATED timestamp with time zone NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL
);


ALTER TABLE public.ACTIVE_RESPONSE_UNIT_LOCATIONS OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 99597)
-- Name: ADMINISTRATORS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ADMINISTRATORS (
    ADMINISTATOR_ID bigint NOT NULL,
    FIRST_NAME character varying NOT NULL,
    LAST_NAME character varying NOT NULL,
    EMAIL_ADDRESS character varying NOT NULL,
    FB_ID character varying NOT NULL,
    DATE_CREATED timestamp with time zone DEFAULT now() NOT NULL,
    CREATED_BY bigint NOT NULL,
    ACTIVE_STATUS public.enum_user_active_status DEFAULT 'ACTIVE'::public.enum_user_active_status NOT NULL,
    LAST_ACTIVE timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ADMINISTRATORS OWNER TO postgres;

--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN ADMINISTRATORS.FB_ID; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.ADMINISTRATORS.FB_ID IS 'firebase UID';


--
-- TOC entry 206 (class 1259 OID 99595)
-- Name: ADMINISTRATORS_ADMINISTATOR_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ADMINISTRATORS_ADMINISTATOR_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ADMINISTRATORS_ADMINISTATOR_ID_seq OWNER TO postgres;

--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 206
-- Name: ADMINISTRATORS_ADMINISTATOR_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ADMINISTRATORS_ADMINISTATOR_ID_seq OWNED BY public.ADMINISTRATORS.ADMINISTATOR_ID;


--
-- TOC entry 212 (class 1259 OID 106529)
-- Name: DB_VERSION; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.DB_VERSION (
    VERSION numeric NOT NULL,
    ID smallint NOT NULL
);


ALTER TABLE public.DB_VERSION OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 107819)
-- Name: DB_VERSION_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.DB_VERSION_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.DB_VERSION_ID_seq OWNER TO postgres;

--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 213
-- Name: DB_VERSION_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.DB_VERSION_ID_seq OWNED BY public.DB_VERSION.ID;


--
-- TOC entry 211 (class 1259 OID 106507)
-- Name: FB_USERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.FB_USERS (
    USER_ID bigint NOT NULL,
    LAST_NAME character varying NOT NULL,
    FIRST_NAME character varying NOT NULL,
    EMAIL_ADDRESS character varying NOT NULL,
    DATE_CREATED time with time zone DEFAULT now() NOT NULL,
    ACTIVE_STATUS public.enum_user_active_status DEFAULT 'ACTIVE'::public.enum_user_active_status NOT NULL,
    FB_ID character varying NOT NULL
);


ALTER TABLE public.FB_USERS OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 106505)
-- Name: FB_USERS_USER_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.FB_USERS_USER_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.FB_USERS_USER_ID_seq OWNER TO postgres;

--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 210
-- Name: FB_USERS_USER_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.FB_USERS_USER_ID_seq OWNED BY public.FB_USERS.USER_ID;


--
-- TOC entry 198 (class 1259 OID 99547)
-- Name: REASONS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.REASONS (
    REASON_ID bigint NOT NULL,
    REASON character varying NOT NULL
);


ALTER TABLE public.REASONS OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 99545)
-- Name: REASONS_REASON_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.REASONS_REASON_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.REASONS_REASON_ID_seq OWNER TO postgres;

--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 197
-- Name: REASONS_REASON_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.REASONS_REASON_ID_seq OWNED BY public.REASONS.REASON_ID;


--
-- TOC entry 182 (class 1259 OID 99451)
-- Name: REPORTERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.REPORTERS (
    REPORTER_ID bigint NOT NULL,
    FIRST_NAME character varying NOT NULL,
    LAST_NAME character varying NOT NULL,
    PHONE_NUMBER character varying NOT NULL,
    FB_ID character varying NOT NULL,
    LAST_ACTIVE timestamp with time zone DEFAULT now() NOT NULL,
    ACTIVE_STATUS public.enum_user_active_status DEFAULT 'ACTIVE'::public.enum_user_active_status NOT NULL
);


ALTER TABLE public.REPORTERS OWNER TO postgres;

--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN REPORTERS.FB_ID; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTERS.FB_ID IS 'firebase UID';


--
-- TOC entry 181 (class 1259 OID 99449)
-- Name: REPORTERS_REPORTER_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.REPORTERS_REPORTER_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.REPORTERS_REPORTER_ID_seq OWNER TO postgres;

--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 181
-- Name: REPORTERS_REPORTER_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.REPORTERS_REPORTER_ID_seq OWNED BY public.REPORTERS.REPORTER_ID;


--
-- TOC entry 184 (class 1259 OID 99466)
-- Name: REPORTS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.REPORTS (
    REPORT_ID bigint NOT NULL,
    CONTACT_NUMBER character varying NOT NULL,
    DATE_CREATED timestamp with time zone NOT NULL,
    DESCRIPTION character varying NOT NULL,
    LATITUDE double precision NOT NULL,
    LONGTITUDE double precision NOT NULL,
    GEO_CITY character varying NOT NULL,
    GEO_COUNTRY character varying NOT NULL,
    GEO_STATE character varying NOT NULL,
    GEO_ADDRESS character varying NOT NULL,
    CITY character varying NOT NULL,
    ADDRESS character varying NOT NULL,
    STATE character varying NOT NULL,
    COUNTRY character varying NOT NULL,
    IS_INJURED character(1) NOT NULL,
    IS_VICTIM character(1) NOT NULL,
    IS_OTHERS_INJURED character(1) NOT NULL,
    NUM_VICTIMS integer NOT NULL,
    NUM_VEHICLES integer NOT NULL,
    REPORT_STATUS public.enum_report_status NOT NULL,
    PARENT_ID bigint,
    VEHICLES_DESC json,
    REPORTER_ID bigint NOT NULL,
    REMARKS character varying
);


ALTER TABLE public.REPORTS OWNER TO postgres;

--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.CONTACT_NUMBER; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.CONTACT_NUMBER IS 'Contact number at time of report';


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.DESCRIPTION; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.DESCRIPTION IS 'Free text description';


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.GEO_CITY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.GEO_CITY IS 'City from lat/long';


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.GEO_COUNTRY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.GEO_COUNTRY IS 'Country from lat/long';


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.GEO_STATE; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.GEO_STATE IS 'State from lat/long';


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.GEO_ADDRESS; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.GEO_ADDRESS IS 'Address from lat/long';


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.CITY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.CITY IS 'Entered city';


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.ADDRESS; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.ADDRESS IS 'Entered address';


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.STATE; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.STATE IS 'Entered state';


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.COUNTRY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.COUNTRY IS 'Entered country';


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.IS_INJURED; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.IS_INJURED IS 'Is reporter injured';


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.IS_VICTIM; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.IS_VICTIM IS 'Is reporter involved in accident';


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.IS_OTHERS_INJURED; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.IS_OTHERS_INJURED IS 'Are there other persons injured';


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.NUM_VICTIMS; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.NUM_VICTIMS IS 'Number of victims involved';


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.NUM_VEHICLES; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.NUM_VEHICLES IS 'Number of vehicles involved';


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.PARENT_ID; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.PARENT_ID IS 'If report is duplicate then the original reportID';


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.VEHICLES_DESC; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.VEHICLES_DESC IS 'description of vehicles in JSON format';


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN REPORTS.REMARKS; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.REPORTS.REMARKS IS 'Adhoc remarks';


--
-- TOC entry 183 (class 1259 OID 99464)
-- Name: REPORTS_REPORT_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.REPORTS_REPORT_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.REPORTS_REPORT_ID_seq OWNER TO postgres;

--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 183
-- Name: REPORTS_REPORT_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.REPORTS_REPORT_ID_seq OWNED BY public.REPORTS.REPORT_ID;


--
-- TOC entry 200 (class 1259 OID 99558)
-- Name: REPORT_MEDIA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.REPORT_MEDIA (
    REPORT_MEDIA_ID bigint NOT NULL,
    MEDIA_URL character varying NOT NULL,
    MEDIA_TYPE public.enum_media_type NOT NULL,
    DATE_CREATED date NOT NULL,
    REPORT_ID bigint NOT NULL,
    REQUESTED_BY bigint NOT NULL
);


ALTER TABLE public.REPORT_MEDIA OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 99556)
-- Name: REPORT_MEDIA_REPORT_MEDIA_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.REPORT_MEDIA_REPORT_MEDIA_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.REPORT_MEDIA_REPORT_MEDIA_ID_seq OWNER TO postgres;

--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 199
-- Name: REPORT_MEDIA_REPORT_MEDIA_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.REPORT_MEDIA_REPORT_MEDIA_ID_seq OWNED BY public.REPORT_MEDIA.REPORT_MEDIA_ID;


--
-- TOC entry 186 (class 1259 OID 99483)
-- Name: REPORT_TAGS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.REPORT_TAGS (
    REPORT_ID bigint NOT NULL,
    TAG_ID bigint NOT NULL
);


ALTER TABLE public.REPORT_TAGS OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 99488)
-- Name: RESPONDERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONDERS (
    RESPONDER_ID bigint NOT NULL,
    FIRST_NAME character varying NOT NULL,
    LAST_NAME character varying NOT NULL,
    PHONE_NUMBER character varying NOT NULL,
    EMAIL_ADDRESS character varying NOT NULL,
    DATE_CREATED timestamp with time zone DEFAULT now() NOT NULL,
    FB_ID character varying NOT NULL,
    ADDED_BY bigint NOT NULL,
    ACTIVE_STATUS public.enum_user_active_status DEFAULT 'ACTIVE'::public.enum_user_active_status NOT NULL,
    LAST_ACTIVE timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.RESPONDERS OWNER TO postgres;

--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN RESPONDERS.FB_ID; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONDERS.FB_ID IS 'firebase UID';


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN RESPONDERS.ADDED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONDERS.ADDED_BY IS 'Administrator who added responder';


--
-- TOC entry 187 (class 1259 OID 99486)
-- Name: RESPONDERS_RESPONDER_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.RESPONDERS_RESPONDER_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.RESPONDERS_RESPONDER_ID_seq OWNER TO postgres;

--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 187
-- Name: RESPONDERS_RESPONDER_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.RESPONDERS_RESPONDER_ID_seq OWNED BY public.RESPONDERS.RESPONDER_ID;


--
-- TOC entry 189 (class 1259 OID 99502)
-- Name: RESPONDER_ASSIGNED_UNITS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONDER_ASSIGNED_UNITS (
    RESPONDER_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL,
    DATE_ASSIGNED timestamp with time zone DEFAULT now() NOT NULL,
    ASSIGNED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONDER_ASSIGNED_UNITS OWNER TO postgres;

--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN RESPONDER_ASSIGNED_UNITS.ASSIGNED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONDER_ASSIGNED_UNITS.ASSIGNED_BY IS 'Administrator who added responder';


--
-- TOC entry 190 (class 1259 OID 99510)
-- Name: RESPONDER_UNIT_HISTORY; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONDER_UNIT_HISTORY (
    RESPONDER_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL,
    DATE_ASSIGNED timestamp with time zone NOT NULL,
    DATE_REMOVED timestamp with time zone DEFAULT now() NOT NULL,
    ASSIGNED_BY bigint NOT NULL,
    REMOVED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONDER_UNIT_HISTORY OWNER TO postgres;

--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN RESPONDER_UNIT_HISTORY.ASSIGNED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONDER_UNIT_HISTORY.ASSIGNED_BY IS 'Administrator who added responder';


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN RESPONDER_UNIT_HISTORY.REMOVED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONDER_UNIT_HISTORY.REMOVED_BY IS 'Administrator who removed responder';


--
-- TOC entry 203 (class 1259 OID 99575)
-- Name: RESPONSE_GROUPS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_GROUPS (
    RESPONSE_GROUP_ID bigint NOT NULL,
    GROUP_DESCRIPTION character varying NOT NULL,
    GROUP_ADDRESS character varying NOT NULL,
    GROUP_STATE character varying NOT NULL,
    GROUP_COUNTRY character varying NOT NULL,
    GROUP_LAT double precision,
    GROUP_LONG double precision,
    DATE_CREATED timestamp with time zone DEFAULT now() NOT NULL,
    CREATED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONSE_GROUPS OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 99573)
-- Name: RESPONSE_GROUPS_RESPONSE_GROUP_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.RESPONSE_GROUPS_RESPONSE_GROUP_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.RESPONSE_GROUPS_RESPONSE_GROUP_ID_seq OWNER TO postgres;

--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 202
-- Name: RESPONSE_GROUPS_RESPONSE_GROUP_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.RESPONSE_GROUPS_RESPONSE_GROUP_ID_seq OWNED BY public.RESPONSE_GROUPS.RESPONSE_GROUP_ID;


--
-- TOC entry 205 (class 1259 OID 99591)
-- Name: RESPONSE_GROUP_ADMINS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_GROUP_ADMINS (
    RESPONSE_GROUP_ID bigint NOT NULL,
    ADMINISTATOR_ID bigint NOT NULL,
    DATE_CREATED timestamp with time zone DEFAULT now() NOT NULL,
    ASSIGNED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONSE_GROUP_ADMINS OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 99585)
-- Name: RESPONSE_GROUP_UNITS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_GROUP_UNITS (
    RESPONSE_GROUP_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL,
    DATE_CREATED timestamp with time zone DEFAULT now() NOT NULL,
    CREATED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONSE_GROUP_UNITS OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 99539)
-- Name: RESPONSE_LOG; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_LOG (
    ARRIVAL_TIME timestamp with time zone NOT NULL,
    CONTACT_TIME timestamp with time zone NOT NULL,
    FACILITY_USED character varying NOT NULL,
    SUMMARY character varying NOT NULL,
    RESPONSE_STATUS character(1) NOT NULL,
    REPORT_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL
);


ALTER TABLE public.RESPONSE_LOG OWNER TO postgres;

--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN RESPONSE_LOG.ARRIVAL_TIME; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_LOG.ARRIVAL_TIME IS 'Time arrived at location';


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN RESPONSE_LOG.CONTACT_TIME; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_LOG.CONTACT_TIME IS 'Time reporter was actually seen';


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN RESPONSE_LOG.FACILITY_USED; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_LOG.FACILITY_USED IS 'Health facility that attended to case';


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN RESPONSE_LOG.SUMMARY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_LOG.SUMMARY IS 'Case summary';


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 196
-- Name: COLUMN RESPONSE_LOG.RESPONSE_STATUS; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_LOG.RESPONSE_STATUS IS 'Active, Completed, Closed';


--
-- TOC entry 191 (class 1259 OID 99514)
-- Name: RESPONSE_UNITS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_UNITS (
    RESPONSE_UNIT_ID bigint NOT NULL,
    LAST_KNOWN_LAT double precision NOT NULL,
    LAST_KNOWN_LONG double precision NOT NULL,
    CURRENT_STATUS character varying NOT NULL,
    LAST_UPDATED timestamp with time zone NOT NULL,
    DATE_CREATED timestamp with time zone DEFAULT now() NOT NULL,
    CREATED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONSE_UNITS OWNER TO postgres;

--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN RESPONSE_UNITS.LAST_KNOWN_LAT; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNITS.LAST_KNOWN_LAT IS 'Last known coordinates';


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN RESPONSE_UNITS.LAST_KNOWN_LONG; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNITS.LAST_KNOWN_LONG IS 'Last known coordinates';


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN RESPONSE_UNITS.LAST_UPDATED; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNITS.LAST_UPDATED IS 'Last time location was updated';


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN RESPONSE_UNITS.CREATED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNITS.CREATED_BY IS 'Administrator who created response unit';


--
-- TOC entry 192 (class 1259 OID 99523)
-- Name: RESPONSE_UNIT_LEADERS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_UNIT_LEADERS (
    DATE_ASSIGNED date DEFAULT now() NOT NULL,
    RESPONDER_ID bigint NOT NULL,
    RESPONSE_UNIT_ID bigint NOT NULL,
    ASSIGNED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONSE_UNIT_LEADERS OWNER TO postgres;

--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN RESPONSE_UNIT_LEADERS.ASSIGNED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNIT_LEADERS.ASSIGNED_BY IS 'Administrator who assigned leader';


--
-- TOC entry 193 (class 1259 OID 99529)
-- Name: RESPONSE_UNIT_LEADERS_HISTORY; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.RESPONSE_UNIT_LEADERS_HISTORY (
    RESPONSE_UNIT_ID bigint NOT NULL,
    RESPONDER_ID bigint NOT NULL,
    DATE_ASSIGNED timestamp with time zone NOT NULL,
    DATE_REMOVED timestamp with time zone DEFAULT now() NOT NULL,
    ASSIGNED_BY bigint NOT NULL,
    REMOVED_BY bigint NOT NULL
);


ALTER TABLE public.RESPONSE_UNIT_LEADERS_HISTORY OWNER TO postgres;

--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN RESPONSE_UNIT_LEADERS_HISTORY.ASSIGNED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNIT_LEADERS_HISTORY.ASSIGNED_BY IS 'Administrator who assigned responder';


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN RESPONSE_UNIT_LEADERS_HISTORY.REMOVED_BY; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.RESPONSE_UNIT_LEADERS_HISTORY.REMOVED_BY IS 'Administrator who removed responder';


--
-- TOC entry 209 (class 1259 OID 99615)
-- Name: SUPER_ADMINS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.SUPER_ADMINS (
    ADMIN_ID bigint NOT NULL,
    FIRST_NAME character varying NOT NULL,
    LAST_NAME character varying NOT NULL,
    EMAIL_ADDRESS character varying NOT NULL,
    FB_ID character varying NOT NULL,
    ACTIVE_STATUS public.enum_user_active_status DEFAULT 'ACTIVE'::public.enum_user_active_status NOT NULL,
    LAST_ACTIVE timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.SUPER_ADMINS OWNER TO postgres;

--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN SUPER_ADMINS.FB_ID; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.SUPER_ADMINS.FB_ID IS 'firebase UID';


--
-- TOC entry 208 (class 1259 OID 99613)
-- Name: SUPER_ADMINS_ADMIN_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.SUPER_ADMINS_ADMIN_ID_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.SUPER_ADMINS_ADMIN_ID_seq OWNER TO postgres;

--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 208
-- Name: SUPER_ADMINS_ADMIN_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.SUPER_ADMINS_ADMIN_ID_seq OWNED BY public.SUPER_ADMINS.ADMIN_ID;


--
-- TOC entry 185 (class 1259 OID 99475)
-- Name: TAGS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.TAGS (
    TAG_ID bigint NOT NULL,
    TAG_NAME character varying NOT NULL
);


ALTER TABLE public.TAGS OWNER TO postgres;

--
-- TOC entry 2129 (class 2604 OID 99600)
-- Name: ADMINISTRATORS ADMINISTATOR_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ADMINISTRATORS ALTER COLUMN ADMINISTATOR_ID SET DEFAULT nextval('public.ADMINISTRATORS_ADMINISTATOR_ID_seq'::regclass);


--
-- TOC entry 2139 (class 2604 OID 107821)
-- Name: DB_VERSION ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.DB_VERSION ALTER COLUMN ID SET DEFAULT nextval('public.DB_VERSION_ID_seq'::regclass);


--
-- TOC entry 2136 (class 2604 OID 106510)
-- Name: FB_USERS USER_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.FB_USERS ALTER COLUMN USER_ID SET DEFAULT nextval('public.FB_USERS_USER_ID_seq'::regclass);


--
-- TOC entry 2123 (class 2604 OID 99550)
-- Name: REASONS REASON_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REASONS ALTER COLUMN REASON_ID SET DEFAULT nextval('public.REASONS_REASON_ID_seq'::regclass);


--
-- TOC entry 2110 (class 2604 OID 99454)
-- Name: REPORTERS REPORTER_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORTERS ALTER COLUMN REPORTER_ID SET DEFAULT nextval('public.REPORTERS_REPORTER_ID_seq'::regclass);


--
-- TOC entry 2113 (class 2604 OID 99469)
-- Name: REPORTS REPORT_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORTS ALTER COLUMN REPORT_ID SET DEFAULT nextval('public.REPORTS_REPORT_ID_seq'::regclass);


--
-- TOC entry 2124 (class 2604 OID 99561)
-- Name: REPORT_MEDIA REPORT_MEDIA_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORT_MEDIA ALTER COLUMN REPORT_MEDIA_ID SET DEFAULT nextval('public.REPORT_MEDIA_REPORT_MEDIA_ID_seq'::regclass);


--
-- TOC entry 2114 (class 2604 OID 99491)
-- Name: RESPONDERS RESPONDER_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDERS ALTER COLUMN RESPONDER_ID SET DEFAULT nextval('public.RESPONDERS_RESPONDER_ID_seq'::regclass);


--
-- TOC entry 2125 (class 2604 OID 99578)
-- Name: RESPONSE_GROUPS RESPONSE_GROUP_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUPS ALTER COLUMN RESPONSE_GROUP_ID SET DEFAULT nextval('public.RESPONSE_GROUPS_RESPONSE_GROUP_ID_seq'::regclass);


--
-- TOC entry 2133 (class 2604 OID 99618)
-- Name: SUPER_ADMINS ADMIN_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.SUPER_ADMINS ALTER COLUMN ADMIN_ID SET DEFAULT nextval('public.SUPER_ADMINS_ADMIN_ID_seq'::regclass);


--
-- TOC entry 2172 (class 2606 OID 99610)
-- Name: ADMINISTRATORS ADMINISTRATORS_EMAIL_ADDRESS_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ADMINISTRATORS
    ADD CONSTRAINT ADMINISTRATORS_EMAIL_ADDRESS_key UNIQUE (EMAIL_ADDRESS);


--
-- TOC entry 2174 (class 2606 OID 99612)
-- Name: ADMINISTRATORS ADMINISTRATORS_FB_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ADMINISTRATORS
    ADD CONSTRAINT ADMINISTRATORS_FB_ID_key UNIQUE (FB_ID);


--
-- TOC entry 2176 (class 2606 OID 99608)
-- Name: ADMINISTRATORS ADMINISTRATORS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ADMINISTRATORS
    ADD CONSTRAINT ADMINISTRATORS_pkey PRIMARY KEY (ADMINISTATOR_ID);


--
-- TOC entry 2190 (class 2606 OID 107829)
-- Name: DB_VERSION DB_VERSION_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.DB_VERSION
    ADD CONSTRAINT DB_VERSION_pkey PRIMARY KEY (ID);


--
-- TOC entry 2184 (class 2606 OID 106522)
-- Name: FB_USERS FB_USERS_EMAIL_ADDRESS_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.FB_USERS
    ADD CONSTRAINT FB_USERS_EMAIL_ADDRESS_key UNIQUE (EMAIL_ADDRESS);


--
-- TOC entry 2186 (class 2606 OID 106520)
-- Name: FB_USERS FB_USERS_FB_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.FB_USERS
    ADD CONSTRAINT FB_USERS_FB_ID_key UNIQUE (FB_ID);


--
-- TOC entry 2188 (class 2606 OID 106516)
-- Name: FB_USERS FB_USERS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.FB_USERS
    ADD CONSTRAINT FB_USERS_pkey PRIMARY KEY (USER_ID);


--
-- TOC entry 2164 (class 2606 OID 99555)
-- Name: REASONS REASONS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REASONS
    ADD CONSTRAINT REASONS_pkey PRIMARY KEY (REASON_ID);


--
-- TOC entry 2141 (class 2606 OID 99463)
-- Name: REPORTERS REPORTERS_FB_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORTERS
    ADD CONSTRAINT REPORTERS_FB_ID_key UNIQUE (FB_ID);


--
-- TOC entry 2143 (class 2606 OID 99461)
-- Name: REPORTERS REPORTERS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORTERS
    ADD CONSTRAINT REPORTERS_pkey PRIMARY KEY (REPORTER_ID);


--
-- TOC entry 2145 (class 2606 OID 99474)
-- Name: REPORTS REPORTS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORTS
    ADD CONSTRAINT REPORTS_pkey PRIMARY KEY (REPORT_ID);


--
-- TOC entry 2166 (class 2606 OID 99566)
-- Name: REPORT_MEDIA REPORT_MEDIA_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORT_MEDIA
    ADD CONSTRAINT REPORT_MEDIA_pkey PRIMARY KEY (REPORT_MEDIA_ID);


--
-- TOC entry 2149 (class 2606 OID 99501)
-- Name: RESPONDERS RESPONDERS_FB_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDERS
    ADD CONSTRAINT RESPONDERS_FB_ID_key UNIQUE (FB_ID);


--
-- TOC entry 2151 (class 2606 OID 99499)
-- Name: RESPONDERS RESPONDERS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDERS
    ADD CONSTRAINT RESPONDERS_pkey PRIMARY KEY (RESPONDER_ID);


--
-- TOC entry 2153 (class 2606 OID 99509)
-- Name: RESPONDER_ASSIGNED_UNITS RESPONDER_ASSIGNED_UNITS_RESPONDER_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_ASSIGNED_UNITS
    ADD CONSTRAINT RESPONDER_ASSIGNED_UNITS_RESPONDER_ID_key UNIQUE (RESPONDER_ID);


--
-- TOC entry 2155 (class 2606 OID 99507)
-- Name: RESPONDER_ASSIGNED_UNITS RESPONDER_ASSIGNED_UNITS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_ASSIGNED_UNITS
    ADD CONSTRAINT RESPONDER_ASSIGNED_UNITS_pkey PRIMARY KEY (RESPONSE_UNIT_ID, RESPONDER_ID);


--
-- TOC entry 2168 (class 2606 OID 99584)
-- Name: RESPONSE_GROUPS RESPONSE_GROUPS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUPS
    ADD CONSTRAINT RESPONSE_GROUPS_pkey PRIMARY KEY (RESPONSE_GROUP_ID);


--
-- TOC entry 2170 (class 2606 OID 99590)
-- Name: RESPONSE_GROUP_UNITS RESPONSE_GROUP_UNITS_RESPONSE_UNIT_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_UNITS
    ADD CONSTRAINT RESPONSE_GROUP_UNITS_RESPONSE_UNIT_ID_key UNIQUE (RESPONSE_UNIT_ID);


--
-- TOC entry 2157 (class 2606 OID 99522)
-- Name: RESPONSE_UNITS RESPONSE_UNITS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNITS
    ADD CONSTRAINT RESPONSE_UNITS_pkey PRIMARY KEY (RESPONSE_UNIT_ID);


--
-- TOC entry 2161 (class 2606 OID 99528)
-- Name: RESPONSE_UNIT_LEADERS RESPONSE_UNIT_LEADERS_RESPONSE_UNIT_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_RESPONSE_UNIT_ID_key UNIQUE (RESPONSE_UNIT_ID);


--
-- TOC entry 2178 (class 2606 OID 99627)
-- Name: SUPER_ADMINS SUPER_ADMINS_EMAIL_ADDRESS_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.SUPER_ADMINS
    ADD CONSTRAINT SUPER_ADMINS_EMAIL_ADDRESS_key UNIQUE (EMAIL_ADDRESS);


--
-- TOC entry 2180 (class 2606 OID 99629)
-- Name: SUPER_ADMINS SUPER_ADMINS_FB_ID_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.SUPER_ADMINS
    ADD CONSTRAINT SUPER_ADMINS_FB_ID_key UNIQUE (FB_ID);


--
-- TOC entry 2182 (class 2606 OID 99625)
-- Name: SUPER_ADMINS SUPER_ADMINS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.SUPER_ADMINS
    ADD CONSTRAINT SUPER_ADMINS_pkey PRIMARY KEY (ADMIN_ID);


--
-- TOC entry 2147 (class 2606 OID 99482)
-- Name: TAGS TAGS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.TAGS
    ADD CONSTRAINT TAGS_pkey PRIMARY KEY (TAG_ID);


--
-- TOC entry 2162 (class 1259 OID 99812)
-- Name: ACTIVE_CASES_RESPONSE_UNIT_ID_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ACTIVE_CASES_RESPONSE_UNIT_ID_idx ON public.ACTIVE_CASES USING btree (RESPONSE_UNIT_ID);


--
-- TOC entry 2158 (class 1259 OID 99810)
-- Name: RESPONSE_UNIT_LEADERS_RESPONDER_ID_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX RESPONSE_UNIT_LEADERS_RESPONDER_ID_idx ON public.RESPONSE_UNIT_LEADERS USING btree (RESPONDER_ID);


--
-- TOC entry 2159 (class 1259 OID 99811)
-- Name: RESPONSE_UNIT_LEADERS_RESPONSE_UNIT_ID_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX RESPONSE_UNIT_LEADERS_RESPONSE_UNIT_ID_idx ON public.RESPONSE_UNIT_LEADERS USING btree (RESPONSE_UNIT_ID);


--
-- TOC entry 2218 (class 2606 OID 99765)
-- Name: ABANDONED_REPORTS ABANDONED_REPORTS_REASON_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ABANDONED_REPORTS
    ADD CONSTRAINT ABANDONED_REPORTS_REASON_ID_fkey FOREIGN KEY (REASON_ID) REFERENCES public.REASONS(REASON_ID);


--
-- TOC entry 2216 (class 2606 OID 99755)
-- Name: ABANDONED_REPORTS ABANDONED_REPORTS_REPORT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ABANDONED_REPORTS
    ADD CONSTRAINT ABANDONED_REPORTS_REPORT_ID_fkey FOREIGN KEY (REPORT_ID) REFERENCES public.REPORTS(REPORT_ID);


--
-- TOC entry 2217 (class 2606 OID 99760)
-- Name: ABANDONED_REPORTS ABANDONED_REPORTS_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ABANDONED_REPORTS
    ADD CONSTRAINT ABANDONED_REPORTS_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2209 (class 2606 OID 99720)
-- Name: ACTIVE_CASES ACTIVE_CASES_REPORT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ACTIVE_CASES
    ADD CONSTRAINT ACTIVE_CASES_REPORT_ID_fkey FOREIGN KEY (REPORT_ID) REFERENCES public.REPORTS(REPORT_ID);


--
-- TOC entry 2210 (class 2606 OID 99725)
-- Name: ACTIVE_CASES ACTIVE_CASES_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ACTIVE_CASES
    ADD CONSTRAINT ACTIVE_CASES_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2211 (class 2606 OID 99730)
-- Name: ACTIVE_RESPONSE_UNIT_LOCATIONS ACTIVE_RESPONSE_UNIT_LOCATIONS_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ACTIVE_RESPONSE_UNIT_LOCATIONS
    ADD CONSTRAINT ACTIVE_RESPONSE_UNIT_LOCATIONS_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2226 (class 2606 OID 99805)
-- Name: ADMINISTRATORS ADMINISTRATORS_CREATED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ADMINISTRATORS
    ADD CONSTRAINT ADMINISTRATORS_CREATED_BY_fkey FOREIGN KEY (CREATED_BY) REFERENCES public.SUPER_ADMINS(ADMIN_ID);


--
-- TOC entry 2191 (class 2606 OID 99630)
-- Name: REPORTS REPORTS_REPORTER_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORTS
    ADD CONSTRAINT REPORTS_REPORTER_ID_fkey FOREIGN KEY (REPORTER_ID) REFERENCES public.REPORTERS(REPORTER_ID);


--
-- TOC entry 2214 (class 2606 OID 99745)
-- Name: REPORT_MEDIA REPORT_MEDIA_REPORT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORT_MEDIA
    ADD CONSTRAINT REPORT_MEDIA_REPORT_ID_fkey FOREIGN KEY (REPORT_ID) REFERENCES public.REPORTS(REPORT_ID);


--
-- TOC entry 2215 (class 2606 OID 99750)
-- Name: REPORT_MEDIA REPORT_MEDIA_REQUESTED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORT_MEDIA
    ADD CONSTRAINT REPORT_MEDIA_REQUESTED_BY_fkey FOREIGN KEY (REQUESTED_BY) REFERENCES public.RESPONDERS(RESPONDER_ID);


--
-- TOC entry 2192 (class 2606 OID 99635)
-- Name: REPORT_TAGS REPORT_TAGS_REPORT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORT_TAGS
    ADD CONSTRAINT REPORT_TAGS_REPORT_ID_fkey FOREIGN KEY (REPORT_ID) REFERENCES public.REPORTS(REPORT_ID);


--
-- TOC entry 2193 (class 2606 OID 99640)
-- Name: REPORT_TAGS REPORT_TAGS_TAG_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.REPORT_TAGS
    ADD CONSTRAINT REPORT_TAGS_TAG_ID_fkey FOREIGN KEY (TAG_ID) REFERENCES public.TAGS(TAG_ID);


--
-- TOC entry 2194 (class 2606 OID 99645)
-- Name: RESPONDERS RESPONDERS_ADDED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDERS
    ADD CONSTRAINT RESPONDERS_ADDED_BY_fkey FOREIGN KEY (ADDED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2197 (class 2606 OID 99660)
-- Name: RESPONDER_ASSIGNED_UNITS RESPONDER_ASSIGNED_UNITS_ASSIGNED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_ASSIGNED_UNITS
    ADD CONSTRAINT RESPONDER_ASSIGNED_UNITS_ASSIGNED_BY_fkey FOREIGN KEY (ASSIGNED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2195 (class 2606 OID 99650)
-- Name: RESPONDER_ASSIGNED_UNITS RESPONDER_ASSIGNED_UNITS_RESPONDER_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_ASSIGNED_UNITS
    ADD CONSTRAINT RESPONDER_ASSIGNED_UNITS_RESPONDER_ID_fkey FOREIGN KEY (RESPONDER_ID) REFERENCES public.RESPONDERS(RESPONDER_ID);


--
-- TOC entry 2196 (class 2606 OID 99655)
-- Name: RESPONDER_ASSIGNED_UNITS RESPONDER_ASSIGNED_UNITS_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_ASSIGNED_UNITS
    ADD CONSTRAINT RESPONDER_ASSIGNED_UNITS_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2200 (class 2606 OID 99675)
-- Name: RESPONDER_UNIT_HISTORY RESPONDER_UNIT_HISTORY_ASSIGNED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_UNIT_HISTORY
    ADD CONSTRAINT RESPONDER_UNIT_HISTORY_ASSIGNED_BY_fkey FOREIGN KEY (ASSIGNED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2201 (class 2606 OID 99680)
-- Name: RESPONDER_UNIT_HISTORY RESPONDER_UNIT_HISTORY_REMOVED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_UNIT_HISTORY
    ADD CONSTRAINT RESPONDER_UNIT_HISTORY_REMOVED_BY_fkey FOREIGN KEY (REMOVED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2198 (class 2606 OID 99665)
-- Name: RESPONDER_UNIT_HISTORY RESPONDER_UNIT_HISTORY_RESPONDER_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_UNIT_HISTORY
    ADD CONSTRAINT RESPONDER_UNIT_HISTORY_RESPONDER_ID_fkey FOREIGN KEY (RESPONDER_ID) REFERENCES public.RESPONDERS(RESPONDER_ID);


--
-- TOC entry 2199 (class 2606 OID 99670)
-- Name: RESPONDER_UNIT_HISTORY RESPONDER_UNIT_HISTORY_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONDER_UNIT_HISTORY
    ADD CONSTRAINT RESPONDER_UNIT_HISTORY_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2219 (class 2606 OID 99770)
-- Name: RESPONSE_GROUPS RESPONSE_GROUPS_CREATED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUPS
    ADD CONSTRAINT RESPONSE_GROUPS_CREATED_BY_fkey FOREIGN KEY (CREATED_BY) REFERENCES public.SUPER_ADMINS(ADMIN_ID);


--
-- TOC entry 2224 (class 2606 OID 99795)
-- Name: RESPONSE_GROUP_ADMINS RESPONSE_GROUP_ADMINS_ADMINISTATOR_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_ADMINS
    ADD CONSTRAINT RESPONSE_GROUP_ADMINS_ADMINISTATOR_ID_fkey FOREIGN KEY (ADMINISTATOR_ID) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2225 (class 2606 OID 99800)
-- Name: RESPONSE_GROUP_ADMINS RESPONSE_GROUP_ADMINS_ASSIGNED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_ADMINS
    ADD CONSTRAINT RESPONSE_GROUP_ADMINS_ASSIGNED_BY_fkey FOREIGN KEY (ASSIGNED_BY) REFERENCES public.SUPER_ADMINS(ADMIN_ID);


--
-- TOC entry 2223 (class 2606 OID 99790)
-- Name: RESPONSE_GROUP_ADMINS RESPONSE_GROUP_ADMINS_RESPONSE_GROUP_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_ADMINS
    ADD CONSTRAINT RESPONSE_GROUP_ADMINS_RESPONSE_GROUP_ID_fkey FOREIGN KEY (RESPONSE_GROUP_ID) REFERENCES public.RESPONSE_GROUPS(RESPONSE_GROUP_ID);


--
-- TOC entry 2222 (class 2606 OID 99785)
-- Name: RESPONSE_GROUP_UNITS RESPONSE_GROUP_UNITS_CREATED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_UNITS
    ADD CONSTRAINT RESPONSE_GROUP_UNITS_CREATED_BY_fkey FOREIGN KEY (CREATED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2220 (class 2606 OID 99775)
-- Name: RESPONSE_GROUP_UNITS RESPONSE_GROUP_UNITS_RESPONSE_GROUP_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_UNITS
    ADD CONSTRAINT RESPONSE_GROUP_UNITS_RESPONSE_GROUP_ID_fkey FOREIGN KEY (RESPONSE_GROUP_ID) REFERENCES public.RESPONSE_GROUPS(RESPONSE_GROUP_ID);


--
-- TOC entry 2221 (class 2606 OID 99780)
-- Name: RESPONSE_GROUP_UNITS RESPONSE_GROUP_UNITS_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_GROUP_UNITS
    ADD CONSTRAINT RESPONSE_GROUP_UNITS_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2212 (class 2606 OID 99735)
-- Name: RESPONSE_LOG RESPONSE_LOG_REPORT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_LOG
    ADD CONSTRAINT RESPONSE_LOG_REPORT_ID_fkey FOREIGN KEY (REPORT_ID) REFERENCES public.REPORTS(REPORT_ID);


--
-- TOC entry 2213 (class 2606 OID 99740)
-- Name: RESPONSE_LOG RESPONSE_LOG_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_LOG
    ADD CONSTRAINT RESPONSE_LOG_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2202 (class 2606 OID 99685)
-- Name: RESPONSE_UNITS RESPONSE_UNITS_CREATED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNITS
    ADD CONSTRAINT RESPONSE_UNITS_CREATED_BY_fkey FOREIGN KEY (CREATED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2203 (class 2606 OID 99690)
-- Name: RESPONSE_UNIT_LEADERS RESPONSE_UNIT_LEADERS_ASSIGNED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_ASSIGNED_BY_fkey FOREIGN KEY (ASSIGNED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2207 (class 2606 OID 99710)
-- Name: RESPONSE_UNIT_LEADERS_HISTORY RESPONSE_UNIT_LEADERS_HISTORY_ASSIGNED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS_HISTORY
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_HISTORY_ASSIGNED_BY_fkey FOREIGN KEY (ASSIGNED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2208 (class 2606 OID 99715)
-- Name: RESPONSE_UNIT_LEADERS_HISTORY RESPONSE_UNIT_LEADERS_HISTORY_REMOVED_BY_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS_HISTORY
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_HISTORY_REMOVED_BY_fkey FOREIGN KEY (REMOVED_BY) REFERENCES public.ADMINISTRATORS(ADMINISTATOR_ID);


--
-- TOC entry 2206 (class 2606 OID 99705)
-- Name: RESPONSE_UNIT_LEADERS_HISTORY RESPONSE_UNIT_LEADERS_HISTORY_RESPONDER_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS_HISTORY
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_HISTORY_RESPONDER_ID_fkey FOREIGN KEY (RESPONDER_ID) REFERENCES public.RESPONDERS(RESPONDER_ID);


--
-- TOC entry 2205 (class 2606 OID 99700)
-- Name: RESPONSE_UNIT_LEADERS_HISTORY RESPONSE_UNIT_LEADERS_HISTORY_RESPONSE_UNIT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS_HISTORY
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_HISTORY_RESPONSE_UNIT_ID_fkey FOREIGN KEY (RESPONSE_UNIT_ID) REFERENCES public.RESPONSE_UNITS(RESPONSE_UNIT_ID);


--
-- TOC entry 2204 (class 2606 OID 99695)
-- Name: RESPONSE_UNIT_LEADERS RESPONSE_UNIT_LEADERS_RESPONDER_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.RESPONSE_UNIT_LEADERS
    ADD CONSTRAINT RESPONSE_UNIT_LEADERS_RESPONDER_ID_fkey FOREIGN KEY (RESPONDER_ID, RESPONSE_UNIT_ID) REFERENCES public.RESPONDER_ASSIGNED_UNITS(RESPONDER_ID, RESPONSE_UNIT_ID);


--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2020-05-29 10:47:19

--
-- PostgreSQL database dump complete
--

