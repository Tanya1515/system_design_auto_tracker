CREATE EXTENSION postgis;

CREATE EXTENSION pgrouting;

CREATE TABLE "Users" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "login" VARCHAR(30) NOT NULL UNIQUE
    "phone" VARCHAR(20) NOT NULL UNIQUE
    "fcm_token" VARCHAR(255) UNIQUE NOT NULL,
    "radius" INTEGER CHECK (radius >= 0 AND radius <= 100)
);

CREATE TABLE "UserToBrandType" (
    "user_id" UUID REFERENCES Users(id) ON DELETE CASCADE
    "brand_type_id" UUID REFERENCES BrandTypes(id) ON DELETE CASCADE
    PRIMARY KEY (user_id, brand_type_id)
);

CREATE TABLE "UserToFuelType" (
    "user_id" UUID REFERENCES Users(id) ON DELETE CASCADE
    "fuel_type_id" UUID REFERENCES FuelTypes(id) ON DELETE CASCADE
    PRIMARY KEY (user_id, fuel_type_id)
);

CREATE TABLE "Stations" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "object_id" UUID REFERENCES Objects(id) 
    "brand_id" UUID REFERENCES BrandTypes(id)
    "rating" REAL NOT NULL
    "open_time" TIME NOT NULL,
    "close_time" TIME NOT NULL,
    CHECK (rating >= 0 AND rating <= 5)
);

CREATE TABLE "ServiceToStation" (
    "service_id" UUID REFERENCES Services(id) ON DELETE CASCADE
    "station_id" UUID REFERENCES Stations(id) ON DELETE CASCADE
    PRIMARY KEY (service_id, station_id)
);

CREATE TABLE "FuelTypeToStation" (
    "station_id" UUID REFERENCES Stations(id) ON DELETE CASCADE
    "fuel_type_id" UUID REFERENCES FuelTypes(id) ON DELETE CASCADE
    PRIMARY KEY (station_id, fuel_type_id)
);

CREATE TABLE "FuelTypes" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "fuel" VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE "BrandTypes" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "brand" VARCHAR(30) NOT NULL UNIQUE
    "giff_id" UUID 
);

CREATE TABLE "ObjectTypes" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "type" VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE "Services" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "service" VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE "Objects" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "object_type_id" UUID REFERENCES ObjectTypes(id)
    "address" VARCHAR(50) NOT NULL UNIQUE
    "coordinates" GEOMETRY(GEOMETRY, 4326) NOT NULL,
);

COMMENT ON COLUMN "BrandTypes"."giff_id" IS 'Identificator for picture in notification, that is stored in S3-storage';