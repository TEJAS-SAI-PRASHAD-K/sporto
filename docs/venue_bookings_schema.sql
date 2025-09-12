-- Supabase SQL Schema for venue_bookings table
-- This table stores the core booking information without venue operational details

-- Drop existing table if needed (uncomment if you want to recreate)
-- DROP TABLE IF EXISTS booking_courts;
-- DROP TABLE IF EXISTS venue_bookings;

CREATE TABLE IF NOT EXISTS venue_bookings (
    -- Primary booking identifiers
    booking_id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    venue_id VARCHAR(255) NOT NULL,
    venue_name VARCHAR(255) NOT NULL,
    venue_city VARCHAR(100) NOT NULL, -- Keep city for filtering/display
    
    -- Booking details
    sport_id VARCHAR(100) NOT NULL,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL, -- HH:mm:ss format
    total_duration INTEGER NOT NULL, -- in minutes
    booking_status VARCHAR(50) NOT NULL DEFAULT 'pending',
    
    -- Pricing information
    subtotal DECIMAL(10,2) NOT NULL,
    convenience_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    coupon_discount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    karma_discount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) NOT NULL DEFAULT 'USD',
    payment_split VARCHAR(50) NOT NULL DEFAULT 'halfAdvance',
    
    -- Optional booking details
    coupon_code VARCHAR(100),
    is_karma_redeem_enabled BOOLEAN NOT NULL DEFAULT false,
    karma_points_used DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    special_requests TEXT,
    cancellation_hours INTEGER NOT NULL DEFAULT 24, -- Keep this as it's booking-specific
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes separately (PostgreSQL syntax)
CREATE INDEX IF NOT EXISTS idx_venue_bookings_user_id ON venue_bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_venue_bookings_venue_id ON venue_bookings(venue_id);
CREATE INDEX IF NOT EXISTS idx_venue_bookings_date ON venue_bookings(booking_date);
CREATE INDEX IF NOT EXISTS idx_venue_bookings_status ON venue_bookings(booking_status);
CREATE INDEX IF NOT EXISTS idx_venue_bookings_created_at ON venue_bookings(created_at);

-- Separate table for booking courts (one-to-many relationship)
CREATE TABLE IF NOT EXISTS booking_courts (
    id BIGSERIAL PRIMARY KEY,
    booking_id VARCHAR(255) NOT NULL,
    court_id VARCHAR(255) NOT NULL,
    court_name VARCHAR(255) NOT NULL,
    sport_id VARCHAR(100) NOT NULL,
    court_type VARCHAR(100) NOT NULL,
    court_surface VARCHAR(100) NOT NULL,
    hourly_rate DECIMAL(10,2) NOT NULL,
    duration_minutes INTEGER NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    features JSONB, -- Store as JSON array
    equipment JSONB, -- Store as JSON array
    
    -- Foreign key constraint
    CONSTRAINT fk_booking_courts_booking_id 
        FOREIGN KEY (booking_id) 
        REFERENCES venue_bookings(booking_id) 
        ON DELETE CASCADE
);

-- Create indexes for booking_courts
CREATE INDEX IF NOT EXISTS idx_booking_courts_booking_id ON booking_courts(booking_id);
CREATE INDEX IF NOT EXISTS idx_booking_courts_court_id ON booking_courts(court_id);

-- Add updated_at trigger for venue_bookings
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_venue_bookings_updated_at
    BEFORE UPDATE ON venue_bookings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Add RLS (Row Level Security) policies
ALTER TABLE venue_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE booking_courts ENABLE ROW LEVEL SECURITY;

-- Create policies for venue_bookings
CREATE POLICY "Users can view own bookings" 
ON venue_bookings FOR SELECT 
USING (auth.uid()::text = user_id);

CREATE POLICY "Users can insert own bookings" 
ON venue_bookings FOR INSERT 
WITH CHECK (auth.uid()::text = user_id);

CREATE POLICY "Users can update own bookings" 
ON venue_bookings FOR UPDATE 
USING (auth.uid()::text = user_id)
WITH CHECK (auth.uid()::text = user_id);

-- Create policies for booking_courts
CREATE POLICY "Users can view own booking courts" 
ON booking_courts FOR SELECT 
USING (
    booking_id IN (
        SELECT booking_id FROM venue_bookings 
        WHERE user_id = auth.uid()::text
    )
);

CREATE POLICY "Users can insert own booking courts" 
ON booking_courts FOR INSERT 
WITH CHECK (
    booking_id IN (
        SELECT booking_id FROM venue_bookings 
        WHERE user_id = auth.uid()::text
    )
);

CREATE POLICY "Users can update own booking courts" 
ON booking_courts FOR UPDATE 
USING (
    booking_id IN (
        SELECT booking_id FROM venue_bookings 
        WHERE user_id = auth.uid()::text
    )
);

-- ========================================
-- MIGRATION SCRIPT (If you have existing venue_bookings table)
-- ========================================
-- Run this section if you already have venue_bookings and need to modify it

-- Step 1: Remove unnecessary columns from existing table
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS venue_address;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS venue_latitude;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS venue_longitude;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS venue_phone;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS venue_email;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS opening_hours;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS closing_hours;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS non_operating_days;
-- ALTER TABLE venue_bookings DROP COLUMN IF EXISTS venue_rating;

-- Step 2: Add any missing columns (uncomment the ones you need)
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS venue_city VARCHAR(100);
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS convenience_fee DECIMAL(10,2) DEFAULT 0.00;
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS coupon_discount DECIMAL(10,2) DEFAULT 0.00;
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS karma_discount DECIMAL(10,2) DEFAULT 0.00;
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS payment_split VARCHAR(50) DEFAULT 'halfAdvance';
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS is_karma_redeem_enabled BOOLEAN DEFAULT false;
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS karma_points_used DECIMAL(10,2) DEFAULT 0.00;
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS special_requests TEXT;
-- ALTER TABLE venue_bookings ADD COLUMN IF NOT EXISTS cancellation_hours INTEGER DEFAULT 24;