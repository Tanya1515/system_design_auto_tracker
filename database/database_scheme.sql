CREATE TABLE "Users" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "login" VARCHAR(50) NOT NULL UNIQUE
    "phone" VARCHAR(13) NOT NULL UNIQUE
    "fcm_token" VARCHAR(255) UNIQUE NOT NULL,
    "radius" SMALLINT CHECK (radius >= 0 AND radius <= 100)
);

CREATE TABLE "UserToBrandType" (
    "user_id" UUID REFERENCES Users(id) ON DELETE CASCADE
    "brand_type_id" UUID REFERENCES BrandTypes(id) ON DELETE CASCADE
);

CREATE TABLE "UserToFuelType" (
    "user_id" UUID REFERENCES Users(id) ON DELETE CASCADE
    "fuel_type_id" UUID REFERENCES FuelTypes(id) ON DELETE CASCADE
);

CREATE TABLE "Stations" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "address" VARCHAR(50) NOT NULL UNIQUE
    "object_id" UUID REFERENCES Objects(id) 
    "brand_id" UUID REFERENCES BrandTypes(id)
    "rating" REAL NOT NULL
    "open_time" TIME NOT NULL,
    "close_time" TIME NOT NULL,
    CHECK (close_time > open_time)
);

CREATE TABLE "ServiceToStation" (
    "service_id" UUID REFERENCES Services(id) ON DELETE CASCADE
    "station_id" UUID REFERENCES Stations(id) ON DELETE CASCADE
);

CREATE TABLE "FuelTypeToStation" (
    "station_id" UUID REFERENCES Stations(id) ON DELETE CASCADE
    "fuel_type_id" UUID REFERENCES FuelTypes(id) ON DELETE CASCADE
);

CREATE TABLE "FuelTypes" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "fuel" VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE "BrandTypes" (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "brand" VARCHAR(10) NOT NULL UNIQUE
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
    "name" VARCHAR(50) NOT NULL UNIQUE
    "latitude" DOUBLE PRECISION
    "longtitude" DOUBLE PRECISION
);

COMMENT ON COLUMN "BrandTypes"."giff_id" IS 'Identificator for picture in notification';