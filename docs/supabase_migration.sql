-- Playo Complete Database Migration Script
-- This script creates all tables based on the Dart models with proper relationships, indexes, and RLS policies

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- =============================================
-- CORE TABLES
-- =============================================

-- Locations table (referenced by many other tables)
CREATE TABLE public.locations (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    name character varying NOT NULL,
    display_name character varying,
    description text,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL,
    address text,
    city character varying,
    state character varying,
    country character varying,
    zip_code character varying,
    type character varying CHECK (type IN ('country', 'state', 'city', 'area', 'landmark', 'venue', 'custom')),
    parent_location_id uuid,
    is_active boolean DEFAULT true,
    popularity_score integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT locations_pkey PRIMARY KEY (id),
    CONSTRAINT locations_parent_location_id_fkey FOREIGN KEY (parent_location_id) REFERENCES public.locations(id)
);

-- Users table (main user data)
CREATE TABLE public.users (
    id uuid NOT NULL,
    email character varying NOT NULL UNIQUE,
    phone character varying,
    full_name character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    profile_picture_url character varying,
    role character varying DEFAULT 'player' CHECK (role IN ('unknown', 'player', 'trainer', 'admin', 'venue_owner')),
    auth_provider character varying DEFAULT 'email' CHECK (auth_provider IN ('unknown', 'email', 'google', 'apple')),
    subscription_status character varying DEFAULT 'free' CHECK (subscription_status IN ('unknown', 'free', 'premium', 'pro')),
    bio text,
    date_of_birth date,
    gender character varying,
    city character varying,
    state character varying,
    country character varying,
    latitude numeric,
    longitude numeric,
    location_id uuid,
    preferred_sports text[] DEFAULT '{}',
    subscription_expires_at timestamp with time zone,
    is_active boolean DEFAULT true,
    is_email_verified boolean DEFAULT false,
    is_phone_verified boolean DEFAULT false,
    is_profile_completed boolean DEFAULT false,
    fcm_token character varying,
    last_active_at timestamp with time zone,
    is_online boolean DEFAULT false,
    emergency_contact character varying,
    is_premium boolean DEFAULT false,
    skill_levels jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE,
    CONSTRAINT users_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id)
);

-- User profiles (additional auth data)
CREATE TABLE public.user_profiles (
    id uuid NOT NULL,
    phone character varying,
    is_verified boolean DEFAULT false,
    auth_provider character varying,
    last_login timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_profiles_pkey PRIMARY KEY (id),
    CONSTRAINT user_profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE
);

-- User preferences
CREATE TABLE public.user_preferences (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    notifications_enabled boolean DEFAULT true,
    game_invites_enabled boolean DEFAULT true,
    promotional_emails_enabled boolean DEFAULT true,
    location_sharing_enabled boolean DEFAULT true,
    theme_mode character varying DEFAULT 'system' CHECK (theme_mode IN ('light', 'dark', 'system')),
    language character varying DEFAULT 'en',
    distance_unit character varying DEFAULT 'km' CHECK (distance_unit IN ('km', 'miles')),
    time_format character varying DEFAULT '24h' CHECK (time_format IN ('12h', '24h')),
    search_radius numeric DEFAULT 10.0,
    default_skill_level character varying DEFAULT 'intermediate',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_preferences_pkey PRIMARY KEY (id),
    CONSTRAINT user_preferences_user_id_key UNIQUE (user_id),
    CONSTRAINT user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- Saved locations for users
CREATE TABLE public.saved_locations (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    name character varying NOT NULL,
    description text,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL,
    address text,
    type character varying DEFAULT 'custom' CHECK (type IN ('home', 'work', 'gym', 'club', 'favorite', 'custom')),
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT saved_locations_pkey PRIMARY KEY (id),
    CONSTRAINT saved_locations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- Sports table
CREATE TABLE public.sports (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    name character varying NOT NULL UNIQUE,
    description text,
    icon_url character varying,
    image_url character varying,
    category character varying DEFAULT 'individual' CHECK (category IN ('unknown', 'racket', 'ball', 'water', 'individual', 'team', 'combat', 'adventure', 'fitness')),
    aliases text[] DEFAULT '{}',
    skill_levels text[] DEFAULT '{}',
    game_types text[] DEFAULT '{}',
    positions text[] DEFAULT '{}',
    min_players integer,
    max_players integer,
    typical_duration_minutes integer,
    equipment_required text[] DEFAULT '{}',
    rules text[] DEFAULT '{}',
    is_active boolean DEFAULT true,
    popularity_score integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT sports_pkey PRIMARY KEY (id)
);

-- Sport skill levels
CREATE TABLE public.sport_skill_levels (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    sport_id uuid NOT NULL,
    level character varying NOT NULL,
    display_name character varying NOT NULL,
    description text,
    order_index integer,
    characteristics text[] DEFAULT '{}',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT sport_skill_levels_pkey PRIMARY KEY (id),
    CONSTRAINT sport_skill_levels_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id) ON DELETE CASCADE
);

-- =============================================
-- VENUE RELATED TABLES
-- =============================================

-- Venues table
CREATE TABLE public.venues (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    name character varying NOT NULL,
    description text,
    owner_id uuid NOT NULL,
    address text NOT NULL,
    city character varying,
    state character varying,
    country character varying,
    zip_code character varying,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL,
    location_id uuid,
    phone character varying,
    email character varying,
    website character varying,
    contact_phone character varying,
    contact_email character varying,
    images text[] DEFAULT '{}',
    primary_image character varying,
    sport_ids text[] DEFAULT '{}',
    amenities text[] DEFAULT '{}',
    facilities text[] DEFAULT '{}',
    equipment text[] DEFAULT '{}',
    rules text[] DEFAULT '{}',
    opening_time time without time zone,
    closing_time time without time zone,
    opening_hours character varying,
    closing_hours character varying,
    non_operating_days text[] DEFAULT '{}',
    type character varying CHECK (type IN ('unknown', 'outdoor', 'indoor', 'mixed', 'club', 'academy', 'public', 'private')),
    rating numeric DEFAULT 0.0,
    total_reviews integer DEFAULT 0,
    total_bookings integer DEFAULT 0,
    price_per_hour numeric,
    is_active boolean DEFAULT true,
    is_verified boolean DEFAULT false,
    allows_online_booking boolean DEFAULT true,
    requires_approval boolean DEFAULT false,
    cancellation_hours numeric,
    tags text[] DEFAULT '{}',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT venues_pkey PRIMARY KEY (id),
    CONSTRAINT venues_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id),
    CONSTRAINT venues_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id)
);

-- Courts/Fields within venues
CREATE TABLE public.courts (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    venue_id uuid NOT NULL,
    name character varying NOT NULL,
    description text,
    sport_id uuid NOT NULL,
    type character varying DEFAULT 'standard' CHECK (type IN ('unknown', 'standard', 'premium', 'tournament', 'training')),
    surface character varying,
    features text[] DEFAULT '{}',
    equipment text[] DEFAULT '{}',
    is_active boolean DEFAULT true,
    is_bookable boolean DEFAULT true,
    hourly_rate numeric,
    currency character varying DEFAULT 'INR',
    images text[] DEFAULT '{}',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT courts_pkey PRIMARY KEY (id),
    CONSTRAINT courts_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id) ON DELETE CASCADE,
    CONSTRAINT courts_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id)
);

-- Venue sports junction table
CREATE TABLE public.venue_sports (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    venue_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    price_per_hour numeric,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT venue_sports_pkey PRIMARY KEY (id),
    CONSTRAINT venue_sports_venue_id_sport_id_key UNIQUE (venue_id, sport_id),
    CONSTRAINT venue_sports_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id) ON DELETE CASCADE,
    CONSTRAINT venue_sports_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id) ON DELETE CASCADE
);

-- Venue bookings
CREATE TABLE public.venue_bookings (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    venue_id uuid NOT NULL,
    court_id uuid,
    user_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    status character varying DEFAULT 'pending' CHECK (status IN ('unknown', 'pending', 'confirmed', 'paid', 'checked_in', 'completed', 'cancelled', 'refunded', 'no_show')),
    type character varying CHECK (type IN ('unknown', 'hourly', 'daily', 'event', 'tournament', 'membership')),
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    total_amount numeric NOT NULL,
    currency character varying DEFAULT 'INR',
    purpose character varying,
    notes text,
    special_requests text,
    participant_ids text[] DEFAULT '{}',
    expected_participants integer,
    equipment_requested text[] DEFAULT '{}',
    payment_id character varying,
    is_paid boolean DEFAULT false,
    paid_at timestamp with time zone,
    confirmed_at timestamp with time zone,
    cancelled_at timestamp with time zone,
    cancellation_reason text,
    cancellation_fee numeric,
    refund_amount numeric,
    venue_response text,
    checked_in_at timestamp with time zone,
    checked_out_at timestamp with time zone,
    user_rating numeric,
    user_feedback text,
    venue_rating numeric,
    venue_feedback text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT venue_bookings_pkey PRIMARY KEY (id),
    CONSTRAINT venue_bookings_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id),
    CONSTRAINT venue_bookings_court_id_fkey FOREIGN KEY (court_id) REFERENCES public.courts(id),
    CONSTRAINT venue_bookings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
    CONSTRAINT venue_bookings_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id)
);

-- Venue reviews
CREATE TABLE public.venue_reviews (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    venue_id uuid NOT NULL,
    reviewer_id uuid NOT NULL,
    booking_id uuid,
    rating numeric NOT NULL CHECK (rating >= 1.0 AND rating <= 5.0),
    comment text,
    tags text[] DEFAULT '{}',
    images text[] DEFAULT '{}',
    is_anonymous boolean DEFAULT false,
    is_public boolean DEFAULT true,
    is_reported boolean DEFAULT false,
    venue_response text,
    responded_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT venue_reviews_pkey PRIMARY KEY (id),
    CONSTRAINT venue_reviews_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id) ON DELETE CASCADE,
    CONSTRAINT venue_reviews_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(id),
    CONSTRAINT venue_reviews_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.venue_bookings(id)
);

-- =============================================
-- GAME RELATED TABLES
-- =============================================

-- Games table
CREATE TABLE public.games (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    organizer_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    title character varying NOT NULL,
    description text,
    game_type character varying NOT NULL,
    skill_level character varying NOT NULL,
    status character varying DEFAULT 'draft' CHECK (status IN ('unknown', 'draft', 'published', 'full', 'in_progress', 'completed', 'cancelled')),
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    venue_id uuid,
    venue_name character varying,
    venue_address character varying,
    latitude numeric,
    longitude numeric,
    capacity integer NOT NULL,
    current_players integer DEFAULT 0,
    max_players integer NOT NULL,
    entry_fee numeric,
    price_per_player numeric,
    currency character varying DEFAULT 'INR',
    rules text[] DEFAULT '{}',
    equipment_provided text[] DEFAULT '{}',
    equipment_required text[] DEFAULT '{}',
    is_public boolean DEFAULT true,
    is_private boolean DEFAULT false,
    allow_waitlist boolean DEFAULT false,
    requires_approval boolean DEFAULT false,
    contact_info character varying,
    tags text[] DEFAULT '{}',
    notes text,
    rating integer,
    view_count integer DEFAULT 0,
    scheduled_date date NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT games_pkey PRIMARY KEY (id),
    CONSTRAINT games_organizer_id_fkey FOREIGN KEY (organizer_id) REFERENCES public.users(id),
    CONSTRAINT games_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id),
    CONSTRAINT games_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id)
);

-- Game players (junction table)
CREATE TABLE public.game_players (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    game_id uuid NOT NULL,
    player_id uuid NOT NULL,
    joined_at timestamp with time zone DEFAULT now(),
    status character varying DEFAULT 'joined' CHECK (status IN ('joined', 'left', 'kicked', 'waitlisted')),
    CONSTRAINT game_players_pkey PRIMARY KEY (id),
    CONSTRAINT game_players_game_id_player_id_key UNIQUE (game_id, player_id),
    CONSTRAINT game_players_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id) ON DELETE CASCADE,
    CONSTRAINT game_players_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.users(id)
);

-- Game participations (detailed participation data)
CREATE TABLE public.game_participations (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    game_id uuid NOT NULL,
    user_id uuid NOT NULL,
    status character varying DEFAULT 'requested' CHECK (status IN ('unknown', 'requested', 'confirmed', 'waitlisted', 'declined', 'cancelled', 'attended', 'no_show')),
    joined_at timestamp with time zone NOT NULL,
    position character varying,
    partner_user_id uuid,
    notes text,
    rating_given numeric,
    feedback text,
    is_organizer boolean DEFAULT false,
    is_paid boolean DEFAULT false,
    paid_at timestamp with time zone,
    left_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT game_participations_pkey PRIMARY KEY (id),
    CONSTRAINT game_participations_game_id_user_id_key UNIQUE (game_id, user_id),
    CONSTRAINT game_participations_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id) ON DELETE CASCADE,
    CONSTRAINT game_participations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id),
    CONSTRAINT game_participations_partner_user_id_fkey FOREIGN KEY (partner_user_id) REFERENCES public.users(id)
);

-- Game invites
CREATE TABLE public.game_invites (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    game_id uuid NOT NULL,
    inviter_id uuid NOT NULL,
    invitee_id uuid NOT NULL,
    status character varying DEFAULT 'pending' CHECK (status IN ('unknown', 'pending', 'accepted', 'declined', 'expired', 'cancelled')),
    message text,
    sent_at timestamp with time zone,
    responded_at timestamp with time zone,
    expires_at timestamp with time zone,
    response text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT game_invites_pkey PRIMARY KEY (id),
    CONSTRAINT game_invites_game_id_invitee_id_key UNIQUE (game_id, invitee_id),
    CONSTRAINT game_invites_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id) ON DELETE CASCADE,
    CONSTRAINT game_invites_inviter_id_fkey FOREIGN KEY (inviter_id) REFERENCES public.users(id),
    CONSTRAINT game_invites_invitee_id_fkey FOREIGN KEY (invitee_id) REFERENCES public.users(id)
);

-- =============================================
-- TRAINER RELATED TABLES
-- =============================================

-- Trainers table
CREATE TABLE public.trainers (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    business_name character varying NOT NULL,
    tagline character varying,
    bio text,
    sport_ids text[] DEFAULT '{}',
    specializations text[] DEFAULT '{}',
    certifications text[] DEFAULT '{}',
    qualifications text[] DEFAULT '{}',
    years_of_experience integer DEFAULT 0,
    type character varying CHECK (type IN ('unknown', 'individual', 'academy', 'group')),
    service_areas text[] DEFAULT '{}',
    audience_types text[] DEFAULT '{}',
    gym_affiliation character varying,
    website character varying,
    instagram_handle character varying,
    youtube_channel character varying,
    languages_spoken text[] DEFAULT '{}',
    hourly_rate numeric,
    currency character varying DEFAULT 'INR',
    location_id uuid,
    is_available boolean DEFAULT true,
    is_verified boolean DEFAULT false,
    rating numeric DEFAULT 0.0,
    total_reviews integer DEFAULT 0,
    total_students integer DEFAULT 0,
    completed_sessions integer DEFAULT 0,
    profile_video_url character varying,
    portfolio_images text[] DEFAULT '{}',
    achievements text[] DEFAULT '{}',
    tags text[] DEFAULT '{}',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT trainers_pkey PRIMARY KEY (id),
    CONSTRAINT trainers_user_id_key UNIQUE (user_id),
    CONSTRAINT trainers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT trainers_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id)
);

-- Trainer sports junction table
CREATE TABLE public.trainer_sports (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    trainer_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    skill_level character varying,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT trainer_sports_pkey PRIMARY KEY (id),
    CONSTRAINT trainer_sports_trainer_id_sport_id_key UNIQUE (trainer_id, sport_id),
    CONSTRAINT trainer_sports_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(id) ON DELETE CASCADE,
    CONSTRAINT trainer_sports_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id) ON DELETE CASCADE
);

-- Training services
CREATE TABLE public.training_services (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    trainer_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    name character varying NOT NULL,
    description text,
    type character varying CHECK (type IN ('unknown', 'one_on_one', 'group', 'workshop', 'camp', 'online')),
    duration integer NOT NULL, -- in minutes
    price numeric NOT NULL,
    currency character varying DEFAULT 'INR',
    max_participants integer,
    skill_levels text[] DEFAULT '{}',
    age_groups text[] DEFAULT '{}',
    equipment_provided text[] DEFAULT '{}',
    equipment_required text[] DEFAULT '{}',
    location character varying,
    is_active boolean DEFAULT true,
    is_online boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT training_services_pkey PRIMARY KEY (id),
    CONSTRAINT training_services_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(id) ON DELETE CASCADE,
    CONSTRAINT training_services_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id)
);

-- Training sessions
CREATE TABLE public.training_sessions (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    service_id uuid NOT NULL,
    trainer_id uuid NOT NULL,
    student_id uuid NOT NULL,
    status character varying DEFAULT 'scheduled' CHECK (status IN ('unknown', 'scheduled', 'confirmed', 'in_progress', 'completed', 'cancelled', 'no_show', 'rescheduled')),
    scheduled_at timestamp with time zone NOT NULL,
    ends_at timestamp with time zone NOT NULL,
    location character varying,
    notes text,
    trainer_notes text,
    student_notes text,
    participant_ids text[] DEFAULT '{}',
    amount numeric,
    currency character varying DEFAULT 'INR',
    is_paid boolean DEFAULT false,
    paid_at timestamp with time zone,
    payment_id character varying,
    student_rating numeric,
    student_feedback text,
    trainer_rating numeric,
    trainer_feedback text,
    completed_at timestamp with time zone,
    cancelled_at timestamp with time zone,
    cancellation_reason text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT training_sessions_pkey PRIMARY KEY (id),
    CONSTRAINT training_sessions_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.training_services(id),
    CONSTRAINT training_sessions_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(id),
    CONSTRAINT training_sessions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id)
);

-- Trainer reviews
CREATE TABLE public.trainer_reviews (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    trainer_id uuid NOT NULL,
    reviewer_id uuid NOT NULL,
    session_id uuid,
    rating numeric NOT NULL CHECK (rating >= 1.0 AND rating <= 5.0),
    comment text,
    tags text[] DEFAULT '{}',
    is_anonymous boolean DEFAULT false,
    is_public boolean DEFAULT true,
    is_reported boolean DEFAULT false,
    trainer_response text,
    responded_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT trainer_reviews_pkey PRIMARY KEY (id),
    CONSTRAINT trainer_reviews_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.trainers(id) ON DELETE CASCADE,
    CONSTRAINT trainer_reviews_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(id),
    CONSTRAINT trainer_reviews_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.training_sessions(id)
);

-- =============================================
-- USER SOCIAL & PROFILE TABLES
-- =============================================

-- User sport profiles
CREATE TABLE public.user_sport_profiles (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    sport_name character varying NOT NULL,
    skill_level character varying NOT NULL,
    years_of_experience integer,
    position character varying,
    achievements text[] DEFAULT '{}',
    bio text,
    rating numeric,
    total_games_played integer DEFAULT 0,
    total_wins integer DEFAULT 0,
    total_losses integer DEFAULT 0,
    preferred_game_type character varying,
    certifications text[] DEFAULT '{}',
    equipment_owned character varying,
    is_public boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_sport_profiles_pkey PRIMARY KEY (id),
    CONSTRAINT user_sport_profiles_user_id_sport_name_key UNIQUE (user_id, sport_name),
    CONSTRAINT user_sport_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- User connections/friendships
CREATE TABLE public.user_connections (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    connected_user_id uuid NOT NULL,
    status character varying DEFAULT 'pending' CHECK (status IN ('unknown', 'pending', 'accepted', 'blocked', 'rejected')),
    requested_at timestamp with time zone,
    accepted_at timestamp with time zone,
    blocked_at timestamp with time zone,
    notes text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_connections_pkey PRIMARY KEY (id),
    CONSTRAINT user_connections_user_id_connected_user_id_key UNIQUE (user_id, connected_user_id),
    CONSTRAINT user_connections_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_connections_connected_user_id_fkey FOREIGN KEY (connected_user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_connections_not_self CHECK (user_id != connected_user_id)
);

-- User preferred sports junction table
CREATE TABLE public.user_preferred_sports (
    user_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_preferred_sports_pkey PRIMARY KEY (user_id, sport_id),
    CONSTRAINT user_preferred_sports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_preferred_sports_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id) ON DELETE CASCADE
);

-- =============================================
-- NOTIFICATION & MESSAGING TABLES
-- =============================================

-- Notifications table
CREATE TABLE public.notifications (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    title character varying NOT NULL,
    message text NOT NULL,
    body text NOT NULL,
    type character varying NOT NULL CHECK (type IN ('unknown', 'system', 'game_invite', 'game_update', 'game_reminder', 'training_booking', 'training_reminder', 'venue_booking', 'venue_reminder', 'friend_request', 'friend_activity', 'achievement', 'promotion', 'news', 'payment', 'review_request', 'security')),
    priority character varying DEFAULT 'normal' CHECK (priority IN ('unknown', 'low', 'normal', 'high', 'urgent')),
    image_url character varying,
    deep_link character varying,
    related_entity_id character varying,
    related_entity_type character varying,
    action_url character varying,
    action_text character varying,
    tags text[] DEFAULT '{}',
    data jsonb,
    is_read boolean DEFAULT false,
    is_persistent boolean DEFAULT false,
    read_at timestamp with time zone,
    expires_at timestamp with time zone,
    scheduled_at timestamp with time zone,
    sent_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT notifications_pkey PRIMARY KEY (id),
    CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- Notification settings
CREATE TABLE public.notification_settings (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    push_enabled boolean DEFAULT true,
    email_enabled boolean DEFAULT true,
    in_app_enabled boolean DEFAULT true,
    game_notifications boolean DEFAULT true,
    training_notifications boolean DEFAULT true,
    venue_notifications boolean DEFAULT true,
    social_notifications boolean DEFAULT true,
    promotional_notifications boolean DEFAULT false,
    security_notifications boolean DEFAULT true,
    quiet_hours_start character varying,
    quiet_hours_end character varying,
    enabled_days text[] DEFAULT ARRAY['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
    fcm_token character varying,
    apns_token character varying,
    device_id character varying,
    platform character varying,
    last_updated timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT notification_settings_pkey PRIMARY KEY (id),
    CONSTRAINT notification_settings_user_id_key UNIQUE (user_id),
    CONSTRAINT notification_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- Conversations
CREATE TABLE public.conversations (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    participant_ids text[] NOT NULL,
    name character varying,
    description text,
    image_url character varying,
    is_group boolean DEFAULT false,
    last_message_id character varying,
    last_message_content character varying,
    last_message_at timestamp with time zone,
    last_message_sender_id character varying,
    unread_count integer DEFAULT 0,
    is_muted boolean DEFAULT false,
    is_archived boolean DEFAULT false,
    related_entity_id character varying,
    related_entity_type character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT conversations_pkey PRIMARY KEY (id)
);

-- Messages
CREATE TABLE public.messages (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    conversation_id uuid,
    sender_id uuid NOT NULL,
    receiver_id uuid NOT NULL,
    content text NOT NULL,
    type character varying DEFAULT 'text' CHECK (type IN ('unknown', 'text', 'image', 'file', 'location', 'system', 'game_invite', 'training_booking')),
    reply_to_id uuid,
    attachments text[] DEFAULT '{}',
    related_entity_id character varying,
    related_entity_type character varying,
    is_read boolean DEFAULT false,
    is_delivered boolean DEFAULT false,
    is_system boolean DEFAULT false,
    read_at timestamp with time zone,
    delivered_at timestamp with time zone,
    edited_at timestamp with time zone,
    deleted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT messages_pkey PRIMARY KEY (id),
    CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE,
    CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id),
    CONSTRAINT messages_receiver_id_fkey FOREIGN KEY (receiver_id) REFERENCES public.users(id),
    CONSTRAINT messages_reply_to_id_fkey FOREIGN KEY (reply_to_id) REFERENCES public.messages(id)
);

-- =============================================
-- PAYMENT TABLES
-- =============================================

-- Payments table
CREATE TABLE public.payments (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    source_id character varying NOT NULL,
    source_type character varying NOT NULL,
    amount numeric NOT NULL,
    currency character varying DEFAULT 'INR',
    status character varying DEFAULT 'pending' CHECK (status IN ('unknown', 'pending', 'processing', 'succeeded', 'failed', 'cancelled', 'refunded', 'partially_refunded')),
    method character varying DEFAULT 'card' CHECK (method IN ('unknown', 'card', 'upi', 'netbanking', 'wallet', 'cash', 'bank_transfer')),
    gateway_transaction_id character varying,
    gateway_order_id character varying,
    gateway_payment_id character varying,
    description text,
    fees numeric,
    taxes numeric,
    net_amount numeric,
    failure_reason text,
    initiated_at timestamp with time zone,
    succeeded_at timestamp with time zone,
    failed_at timestamp with time zone,
    refunded_at timestamp with time zone,
    refund_amount numeric,
    refund_reason text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT payments_pkey PRIMARY KEY (id),
    CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);

-- =============================================
-- ANALYTICS TABLES
-- =============================================

-- Analytics table
CREATE TABLE public.analytics (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid,
    event_name character varying NOT NULL,
    event_data jsonb,
    session_id character varying,
    timestamp timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT analytics_pkey PRIMARY KEY (id),
    CONSTRAINT analytics_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);

-- User analytics
CREATE TABLE public.user_analytics (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    total_games_played integer DEFAULT 0,
    total_games_won integer DEFAULT 0,
    total_games_lost integer DEFAULT 0,
    total_games_cancelled integer DEFAULT 0,
    average_rating numeric DEFAULT 0.0,
    total_ratings_received integer DEFAULT 0,
    total_training_sessions integer DEFAULT 0,
    total_training_hours integer DEFAULT 0,
    total_training_amount numeric DEFAULT 0.0,
    total_venue_bookings integer DEFAULT 0,
    total_venue_hours integer DEFAULT 0,
    total_venue_amount numeric DEFAULT 0.0,
    total_friends integer DEFAULT 0,
    total_game_invites_sent integer DEFAULT 0,
    total_game_invites_received integer DEFAULT 0,
    total_game_invites_accepted integer DEFAULT 0,
    current_active_streak integer DEFAULT 0,
    longest_active_streak integer DEFAULT 0,
    last_active_date timestamp with time zone,
    current_month character varying,
    monthly_games integer DEFAULT 0,
    monthly_training_sessions integer DEFAULT 0,
    monthly_venue_bookings integer DEFAULT 0,
    monthly_spending numeric DEFAULT 0.0,
    last_updated timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_analytics_pkey PRIMARY KEY (id),
    CONSTRAINT user_analytics_user_id_key UNIQUE (user_id),
    CONSTRAINT user_analytics_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE
);

-- User sport stats
CREATE TABLE public.user_sport_stats (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    sport_id uuid NOT NULL,
    skill_level character varying DEFAULT 'beginner' CHECK (skill_level IN ('unknown', 'beginner', 'intermediate', 'advanced', 'expert', 'professional')),
    skill_rating numeric DEFAULT 0.0,
    total_matches integer DEFAULT 0,
    wins integer DEFAULT 0,
    losses integer DEFAULT 0,
    draws integer DEFAULT 0,
    win_rate numeric DEFAULT 0.0,
    average_performance_rating numeric DEFAULT 0.0,
    total_performance_ratings integer DEFAULT 0,
    mvp_count integer DEFAULT 0,
    total_hours_played integer DEFAULT 0,
    first_game_date timestamp with time zone,
    last_game_date timestamp with time zone,
    achievement_ids text[] DEFAULT '{}',
    badge_ids text[] DEFAULT '{}',
    last_skill_update timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_sport_stats_pkey PRIMARY KEY (id),
    CONSTRAINT user_sport_stats_user_id_sport_id_key UNIQUE (user_id, sport_id),
    CONSTRAINT user_sport_stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_sport_stats_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id) ON DELETE CASCADE
);

-- Achievements
CREATE TABLE public.achievements (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    name character varying NOT NULL,
    description text NOT NULL,
    icon character varying,
    category character varying DEFAULT 'games' CHECK (category IN ('unknown', 'games', 'training', 'social', 'skill', 'streak', 'special')),
    rarity character varying DEFAULT 'common' CHECK (rarity IN ('unknown', 'common', 'rare', 'epic', 'legendary')),
    sport_id uuid,
    points integer DEFAULT 0,
    criteria text,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT achievements_pkey PRIMARY KEY (id),
    CONSTRAINT achievements_sport_id_fkey FOREIGN KEY (sport_id) REFERENCES public.sports(id)
);

-- User achievements
CREATE TABLE public.user_achievements (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid NOT NULL,
    achievement_id uuid NOT NULL,
    unlocked_at timestamp with time zone NOT NULL,
    game_id uuid,
    session_id uuid,
    progress integer DEFAULT 100,
    is_notified boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT user_achievements_pkey PRIMARY KEY (id),
    CONSTRAINT user_achievements_user_id_achievement_id_key UNIQUE (user_id, achievement_id),
    CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id) ON DELETE CASCADE,
    CONSTRAINT user_achievements_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id),
    CONSTRAINT user_achievements_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.training_sessions(id)
);

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

-- User indexes
CREATE INDEX idx_users_email ON public.users(email);
CREATE INDEX idx_users_phone ON public.users(phone);
CREATE INDEX idx_users_role ON public.users(role);
CREATE INDEX idx_users_location_id ON public.users(location_id);
CREATE INDEX idx_users_is_active ON public.users(is_active);
CREATE INDEX idx_users_created_at ON public.users(created_at);

-- Location indexes
CREATE INDEX idx_locations_type ON public.locations(type);
CREATE INDEX idx_locations_city ON public.locations(city);
CREATE INDEX idx_locations_state ON public.locations(state);
CREATE INDEX idx_locations_country ON public.locations(country);
CREATE INDEX idx_locations_coordinates ON public.locations(latitude, longitude);

-- Sports indexes
CREATE INDEX idx_sports_name ON public.sports(name);
CREATE INDEX idx_sports_category ON public.sports(category);
CREATE INDEX idx_sports_is_active ON public.sports(is_active);

-- Games indexes
CREATE INDEX idx_games_organizer_id ON public.games(organizer_id);
CREATE INDEX idx_games_sport_id ON public.games(sport_id);
CREATE INDEX idx_games_venue_id ON public.games(venue_id);
CREATE INDEX idx_games_status ON public.games(status);
CREATE INDEX idx_games_start_time ON public.games(start_time);
CREATE INDEX idx_games_scheduled_date ON public.games(scheduled_date);
CREATE INDEX idx_games_skill_level ON public.games(skill_level);
CREATE INDEX idx_games_is_public ON public.games(is_public);
CREATE INDEX idx_games_coordinates ON public.games(latitude, longitude);

-- Venues indexes
CREATE INDEX idx_venues_owner_id ON public.venues(owner_id);
CREATE INDEX idx_venues_location_id ON public.venues(location_id);
CREATE INDEX idx_venues_city ON public.venues(city);
CREATE INDEX idx_venues_is_active ON public.venues(is_active);
CREATE INDEX idx_venues_is_verified ON public.venues(is_verified);
CREATE INDEX idx_venues_coordinates ON public.venues(latitude, longitude);

-- Trainers indexes
CREATE INDEX idx_trainers_user_id ON public.trainers(user_id);
CREATE INDEX idx_trainers_location_id ON public.trainers(location_id);
CREATE INDEX idx_trainers_is_available ON public.trainers(is_available);
CREATE INDEX idx_trainers_is_verified ON public.trainers(is_verified);

-- Notifications indexes
CREATE INDEX idx_notifications_user_id ON public.notifications(user_id);
CREATE INDEX idx_notifications_type ON public.notifications(type);
CREATE INDEX idx_notifications_is_read ON public.notifications(is_read);
CREATE INDEX idx_notifications_created_at ON public.notifications(created_at);

-- Analytics indexes
CREATE INDEX idx_analytics_user_id ON public.analytics(user_id);
CREATE INDEX idx_analytics_event_name ON public.analytics(event_name);
CREATE INDEX idx_analytics_timestamp ON public.analytics(timestamp);

-- Messages indexes
CREATE INDEX idx_messages_conversation_id ON public.messages(conversation_id);
CREATE INDEX idx_messages_sender_id ON public.messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON public.messages(receiver_id);
CREATE INDEX idx_messages_created_at ON public.messages(created_at);

-- Payments indexes
CREATE INDEX idx_payments_user_id ON public.payments(user_id);
CREATE INDEX idx_payments_status ON public.payments(status);
CREATE INDEX idx_payments_source_id ON public.payments(source_id);
CREATE INDEX idx_payments_created_at ON public.payments(created_at);

-- =============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- =============================================

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.saved_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_sport_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_connections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_preferred_sports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sport_skill_levels ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venues ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_sports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.venue_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.game_players ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.game_participations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.game_invites ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.trainers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.trainer_sports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.training_services ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.training_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.trainer_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notification_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.analytics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_analytics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_sport_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;

-- User policies
CREATE POLICY "Users can view their own profile" ON public.users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON public.users FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can view other public profiles" ON public.users FOR SELECT USING (true);

-- User preferences policies
CREATE POLICY "Users can manage their own preferences" ON public.user_preferences FOR ALL USING (auth.uid() = user_id);

-- Saved locations policies
CREATE POLICY "Users can manage their own saved locations" ON public.saved_locations FOR ALL USING (auth.uid() = user_id);

-- User sport profiles policies
CREATE POLICY "Users can manage their own sport profiles" ON public.user_sport_profiles FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can view public sport profiles" ON public.user_sport_profiles FOR SELECT USING (is_public = true);

-- User connections policies
CREATE POLICY "Users can manage their own connections" ON public.user_connections FOR ALL USING (auth.uid() = user_id OR auth.uid() = connected_user_id);

-- Sports policies (public read access)
CREATE POLICY "Sports are publicly readable" ON public.sports FOR SELECT USING (true);

-- Locations policies (public read access)
CREATE POLICY "Locations are publicly readable" ON public.locations FOR SELECT USING (true);

-- Venues policies
CREATE POLICY "Venues are publicly readable" ON public.venues FOR SELECT USING (true);
CREATE POLICY "Venue owners can manage their venues" ON public.venues FOR ALL USING (auth.uid()::text = owner_id::text);

-- Courts policies
CREATE POLICY "Courts are publicly readable" ON public.courts FOR SELECT USING (true);
CREATE POLICY "Venue owners can manage their courts" ON public.courts FOR ALL USING (
    EXISTS (
        SELECT 1 FROM public.venues 
        WHERE venues.id = courts.venue_id 
        AND auth.uid()::text = venues.owner_id::text
    )
);

-- Venue bookings policies
CREATE POLICY "Users can view their own bookings" ON public.venue_bookings FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create their own bookings" ON public.venue_bookings FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own bookings" ON public.venue_bookings FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Venue owners can view bookings for their venues" ON public.venue_bookings FOR SELECT USING (
    EXISTS (
        SELECT 1 FROM public.venues 
        WHERE venues.id = venue_bookings.venue_id 
        AND auth.uid()::text = venues.owner_id::text
    )
);

-- Games policies
CREATE POLICY "Games are publicly readable" ON public.games FOR SELECT USING (is_public = true);
CREATE POLICY "Users can view private games they're invited to" ON public.games FOR SELECT USING (
    NOT is_public AND (
        auth.uid() = organizer_id OR 
        EXISTS (
            SELECT 1 FROM public.game_players 
            WHERE game_players.game_id = games.id 
            AND game_players.player_id = auth.uid()
        )
    )
);
CREATE POLICY "Users can create games" ON public.games FOR INSERT WITH CHECK (auth.uid() = organizer_id);
CREATE POLICY "Game organizers can update their games" ON public.games FOR UPDATE USING (auth.uid() = organizer_id);
CREATE POLICY "Game organizers can delete their games" ON public.games FOR DELETE USING (auth.uid() = organizer_id);

-- Game players policies
CREATE POLICY "Game players are viewable by game participants" ON public.game_players FOR SELECT USING (
    auth.uid() = player_id OR 
    EXISTS (
        SELECT 1 FROM public.games 
        WHERE games.id = game_players.game_id 
        AND (games.organizer_id = auth.uid() OR games.is_public = true)
    )
);
CREATE POLICY "Users can join/leave games" ON public.game_players FOR ALL USING (auth.uid() = player_id);

-- Trainers policies
CREATE POLICY "Trainers are publicly readable" ON public.trainers FOR SELECT USING (true);
CREATE POLICY "Users can manage their own trainer profile" ON public.trainers FOR ALL USING (auth.uid() = user_id);

-- Training sessions policies
CREATE POLICY "Users can view their own training sessions" ON public.training_sessions FOR SELECT USING (
    auth.uid() = student_id OR auth.uid() = trainer_id
);
CREATE POLICY "Users can create training sessions" ON public.training_sessions FOR INSERT WITH CHECK (
    auth.uid() = student_id OR auth.uid() = trainer_id
);
CREATE POLICY "Users can update their own training sessions" ON public.training_sessions FOR UPDATE USING (
    auth.uid() = student_id OR auth.uid() = trainer_id
);

-- Notifications policies
CREATE POLICY "Users can view their own notifications" ON public.notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update their own notifications" ON public.notifications FOR UPDATE USING (auth.uid() = user_id);

-- Messages policies
CREATE POLICY "Users can view their own messages" ON public.messages FOR SELECT USING (
    auth.uid() = sender_id OR auth.uid() = receiver_id
);
CREATE POLICY "Users can send messages" ON public.messages FOR INSERT WITH CHECK (auth.uid() = sender_id);

-- Payments policies
CREATE POLICY "Users can view their own payments" ON public.payments FOR SELECT USING (auth.uid() = user_id);

-- Analytics policies
CREATE POLICY "Users can view their own analytics" ON public.user_analytics FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can view their own sport stats" ON public.user_sport_stats FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can view their own achievements" ON public.user_achievements FOR SELECT USING (auth.uid() = user_id);

-- Achievements are publicly readable
CREATE POLICY "Achievements are publicly readable" ON public.achievements FOR SELECT USING (true);

-- =============================================
-- FUNCTIONS AND TRIGGERS
-- =============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at triggers to all tables with updated_at column
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_preferences_updated_at BEFORE UPDATE ON public.user_preferences FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_saved_locations_updated_at BEFORE UPDATE ON public.saved_locations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_sport_profiles_updated_at BEFORE UPDATE ON public.user_sport_profiles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_connections_updated_at BEFORE UPDATE ON public.user_connections FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sports_updated_at BEFORE UPDATE ON public.sports FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sport_skill_levels_updated_at BEFORE UPDATE ON public.sport_skill_levels FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_locations_updated_at BEFORE UPDATE ON public.locations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_venues_updated_at BEFORE UPDATE ON public.venues FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_courts_updated_at BEFORE UPDATE ON public.courts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_venue_bookings_updated_at BEFORE UPDATE ON public.venue_bookings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_venue_reviews_updated_at BEFORE UPDATE ON public.venue_reviews FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_games_updated_at BEFORE UPDATE ON public.games FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_game_participations_updated_at BEFORE UPDATE ON public.game_participations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_game_invites_updated_at BEFORE UPDATE ON public.game_invites FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_trainers_updated_at BEFORE UPDATE ON public.trainers FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_training_services_updated_at BEFORE UPDATE ON public.training_services FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_training_sessions_updated_at BEFORE UPDATE ON public.training_sessions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_trainer_reviews_updated_at BEFORE UPDATE ON public.trainer_reviews FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_conversations_updated_at BEFORE UPDATE ON public.conversations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_payments_updated_at BEFORE UPDATE ON public.payments FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_user_sport_stats_updated_at BEFORE UPDATE ON public.user_sport_stats FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to automatically create user preferences when a user is created
CREATE OR REPLACE FUNCTION create_user_preferences()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.user_preferences (user_id)
    VALUES (NEW.id);
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER on_user_created
    AFTER INSERT ON public.users
    FOR EACH ROW EXECUTE FUNCTION create_user_preferences();

-- Function to automatically create user analytics when a user is created
CREATE OR REPLACE FUNCTION create_user_analytics()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.user_analytics (user_id)
    VALUES (NEW.id);
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER on_user_created_analytics
    AFTER INSERT ON public.users
    FOR EACH ROW EXECUTE FUNCTION create_user_analytics();

-- Function to update game current_players count
CREATE OR REPLACE FUNCTION update_game_current_players()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE public.games 
        SET current_players = (
            SELECT COUNT(*) 
            FROM public.game_players 
            WHERE game_id = NEW.game_id 
            AND status = 'joined'
        )
        WHERE id = NEW.game_id;
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE public.games 
        SET current_players = (
            SELECT COUNT(*) 
            FROM public.game_players 
            WHERE game_id = NEW.game_id 
            AND status = 'joined'
        )
        WHERE id = NEW.game_id;
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE public.games 
        SET current_players = (
            SELECT COUNT(*) 
            FROM public.game_players 
            WHERE game_id = OLD.game_id 
            AND status = 'joined'
        )
        WHERE id = OLD.game_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ language 'plpgsql';

CREATE TRIGGER game_players_count_trigger
    AFTER INSERT OR UPDATE OR DELETE ON public.game_players
    FOR EACH ROW EXECUTE FUNCTION update_game_current_players();

-- Function to handle new user registration from auth.users
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (
        id, 
        email, 
        full_name, 
        auth_provider,
        phone
    ) VALUES (
        NEW.id,
        NEW.email,
        COALESCE(
            NEW.raw_user_meta_data->>'full_name', 
            NEW.raw_user_meta_data->>'name', 
            'User'
        ),
        CASE 
            WHEN NEW.app_metadata->>'provider' = 'google' THEN 'google'
            WHEN NEW.app_metadata->>'provider' = 'apple' THEN 'apple'
            ELSE 'email'
        END,
        NEW.phone
    )
    ON CONFLICT (id) DO UPDATE SET
        email = EXCLUDED.email,
        phone = EXCLUDED.phone,
        updated_at = NOW();
    
    RETURN NEW;
END;
$$ language 'plpgsql' SECURITY DEFINER;

-- Trigger for new user creation
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =============================================
-- INITIAL DATA SETUP
-- =============================================

-- Insert default sports
INSERT INTO public.sports (name, category, description, min_players, max_players, typical_duration_minutes) VALUES
('Tennis', 'racket', 'Racket sport played on a court', 2, 4, 90),
('Badminton', 'racket', 'Racket sport with shuttlecock', 2, 4, 60),
('Football', 'team', 'Team sport with ball and goals', 6, 22, 90),
('Basketball', 'team', 'Indoor team sport with hoops', 6, 10, 60),
('Cricket', 'team', 'Bat and ball team sport', 8, 22, 180),
('Swimming', 'water', 'Water sport', 1, 50, 60),
('Running', 'individual', 'Individual fitness activity', 1, 100, 45),
('Gym', 'fitness', 'Fitness and strength training', 1, 50, 90),
('Cycling', 'individual', 'Bicycle riding activity', 1, 50, 120),
('Volleyball', 'team', 'Team sport with net', 6, 12, 90)
ON CONFLICT (name) DO NOTHING;

-- Insert default skill levels for each sport
INSERT INTO public.sport_skill_levels (sport_id, level, display_name, description, order_index) 
SELECT 
    s.id,
    level_data.level,
    level_data.display_name,
    level_data.description,
    level_data.order_index
FROM public.sports s
CROSS JOIN (
    VALUES 
        ('beginner', 'Beginner', 'New to the sport', 1),
        ('intermediate', 'Intermediate', 'Some experience', 2),
        ('advanced', 'Advanced', 'Experienced player', 3),
        ('expert', 'Expert', 'Highly skilled', 4),
        ('professional', 'Professional', 'Professional level', 5)
) AS level_data(level, display_name, description, order_index)
ON CONFLICT DO NOTHING;

-- Insert default achievements
INSERT INTO public.achievements (name, description, category, rarity, points) VALUES
('First Game', 'Played your first game', 'games', 'common', 10),
('Social Butterfly', 'Made 10 friends', 'social', 'common', 25),
('Regular Player', 'Played 10 games', 'games', 'common', 50),
('Training Enthusiast', 'Completed 5 training sessions', 'training', 'common', 30),
('Venue Explorer', 'Visited 5 different venues', 'games', 'rare', 40),
('Skill Builder', 'Improved skill level in any sport', 'skill', 'rare', 60),
('Weekend Warrior', 'Played games on 5 consecutive weekends', 'streak', 'epic', 100),
('Sports Master', 'Reached advanced level in 3 sports', 'skill', 'legendary', 200)
ON CONFLICT (name) DO NOTHING; 
     