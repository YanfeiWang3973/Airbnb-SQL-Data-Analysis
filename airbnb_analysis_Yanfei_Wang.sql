#                                 SQL Assignment - Airbnb

        ########################################################################
        #   Weighting 2.5%, 15 points in total                                 #
        #   Structure:                                                         #
        # - 7 Questions                                                        #
        # -------------------------------------------------------------------- #
        #   Please keep the following in mind:                                 #
        # - Is the code organized such that it is easy to read/understandable? #
        # - Is documentation (where needed) included?                          #
        # - Code quality/efficiency/logic                                      #
        # - One query per question                                             #
        ########################################################################

#                                     Introduction
# -Analysis: Exploring Airbnb guest data to get interesting insights and to answer business questions.
# -Data: Dataset download link: https://weclouddata.s3.amazonaws.com/datasets/hotel/airbnb/airbnb.zip
# -Tools: MySQL (table structure as shown in the tutorial below)
########################################################################################################################

#                                     Questions
# 1: How many unique listings are provided in the calendar table?
select count(distinct listing_id)
from calendar;
-- Answer: 3585

# 2: How many calendar years do the calendar table span?
# (Expected output: e.g., this table has data from 2009 to 2010)
SELECT CONCAT(
    'This table has data from ',  -- the output that we print
    EXTRACT(YEAR FROM MIN(dt)),  -- the earliest year
    ' to ',
    EXTRACT(YEAR FROM MAX(dt))  -- the latest year
) AS calendar_span
FROM calendar;
-- answer: This table has data from 2016 to 2017

# 3: Find listings that are completely available for the entire year (available for 365 days)
select * from listings
where maximum_nights >= 365;
-- detailed infomation of selected listings

select count(listings.maximum_nights>=365)
from listings;
-- total 7170 options

# 4: How many listings have been completely booked for the year (0 days available)?
select count(availability_365 = 0)
from listings;
-- total 7170 listings are not available for the year

# 5: Which city has the most listings?
SELECT city, COUNT(*) AS city_count
FROM listings
GROUP BY city
ORDER BY city_count DESC
LIMIT 1;
-- answer: Boston

# 6: Which street/st/ave has the most number of listings in Boston?
# (Note:  `beacon street` and `beacon st` should be considered the same street)

-- step one:  replace 'beacon st' to 'beacon street'
select replace('beacon st', 'st', 'street')
from listings;

-- step two:  count the street that has the most number of listings in Boston
select street, count(*) as street_count
from listings
where city='Boston'
group by street
order by street_count DESC
limit 1;
-- Boylston Street that has 128 counts

# 7: In the calendar table, how many listings charge different prices for weekends and weekdays?
# Hint: use average weekend price vs average weekday price
SELECT COUNT(*) AS count_different_prices_during_the_week
FROM (
    SELECT listing_id
    FROM calendar
    GROUP BY listing_id
    HAVING AVG(CASE WHEN DAYOFWEEK(dt)
    IN (1, 7)
    THEN REPLACE(price, '$', '') END) != AVG(CASE WHEN DAYOFWEEK(dt)
    IN (2, 3, 4, 5, 6) THEN REPLACE(price, '$', '') END)
) AS different_prices;

-- the number of different prices between weekdays and weekends: 2861


########################################################################################################################
# Tutorial - Create Tables

show databases ;
drop database if exists airbnb;
create database airbnb;
use airbnb;
# Create and load calendar table
drop table if exists airbnb.calendar;

create table airbnb.calendar (
    listing_id            bigint,
    dt                    char(10),
    available             char(1),
    price                  varchar(20)
);

truncate airbnb.calendar;

set global local_infile =True;
-- load data into the calendar table
load data local infile 'C:/weCloudData 2024/SQL/assignment Airbnb/calendar.csv'
into table airbnb.calendar
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

# test calendar table
select * from airbnb.calendar limit 5;
select * from airbnb.calendar where listing_id=14204600 and dt='2017-08-20';

# Create listings table
drop table if exists airbnb.listings;
create table airbnb.listings (
    id bigint,
    listing_url text,
    scrape_id bigint,
    last_scraped char(10),
    name text,
    summary text,
    space text,
    description text,
    experiences_offered text,
    neighborhood_overview text,
    notes text,
    transit text,
    access text,
    interaction text,
    house_rules text,
    thumbnail_url text,
    medium_url text,
    picture_url text,
    xl_picture_url text,
    host_id bigint,
    host_url text,
    host_name varchar(100),
    host_since char(10),
    host_location text,
    host_about text,
    host_response_time text,
    host_response_rate text,
    host_acceptance_rate text,
    host_is_superhost char(1),
    host_thumbnail_url text,
    host_picture_url text,
    host_neighbourhood text,
    host_listings_count int,
    host_total_listings_count int,
    host_verifications text,
    host_has_profile_pic char(1),
    host_identity_verified char(1),
    street text,
    neighbourhood text,
    neighbourhood_cleansed text,
    neighbourhood_group_cleansed text,
    city text,
    state text,
    zipcode text,
    market text,
    smart_location text,
    country_code text,
    country text,
    latitude text,
    longitude text,
    is_location_exact text,
    property_type text,
    room_type text,
    accommodates int,
    bathrooms text,
    bedrooms text,
    beds text,
    bed_type text,
    amenities text,
    square_feet text,
    price text,
    weekly_price text,
    monthly_price text,
    security_deposit text,
    cleaning_fee text,
    guests_included int,
    extra_people text,
    minimum_nights int,
    maximum_nights int,
    calendar_updated text,
    has_availability varchar(10),
    availability_30 int,
    availability_60 int,
    availability_90 int,
    availability_365 int,
    calendar_last_scraped varchar(10),
    number_of_reviews int,
    first_review varchar(10),
    last_review varchar(10),
    review_scores_rating text,
    review_scores_accuracy text,
    review_scores_cleanliness text,
    review_scores_checkin text,
    review_scores_communication text,
    review_scores_location text,
    review_scores_value text,
    requires_license char(1),
    license text,
    jurisdiction_names text,
    instant_bookable char(1),
    cancellation_policy varchar(20),
    require_guest_profile_picture char(1),
    require_guest_phone_verification char(1),
    calculated_host_listings_count int,
    reviews_per_month text
);

load data local infile 'C:/weCloudData 2024/SQL/assignment Airbnb/listings.csv'
into table airbnb.listings
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
-- fields terminated by '\t'
ignore 1 lines;

select * from airbnb.listings limit 20;

# Create and load reviews table
drop table if exists airbnb.reviews;
create table airbnb.reviews (
    listing_id bigint,
    id bigint,
    date varchar(10),
    reviewer_id bigint,
    reviewer_name text,
    comments text
);

load data local infile 'C:/weCloudData 2024/SQL/assignment Airbnb/reviews.csv'
into table airbnb.reviews
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
-- fields terminated by '\t'
ignore 1 lines;

select * from airbnb.reviews limit 5;