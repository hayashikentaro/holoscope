{-|
Module: Data.Astro.Types
Description: Common Types
Copyright: Alexander Ignatyev, 2016

Common Types are usfull across all subsystems like Time and Coordinate.

= Examples

== /Decimal hours and Decimal degrees/

@
import Data.Astro.Types

-- 10h 15m 19.7s
dh :: DecimalHours
dh = fromHMS 10 15 19.7
-- DH 10.255472222222222

(h, m, s) = toHMS dh
-- (10,15,19.699999999999562)


-- 51°28′40″
dd :: DecimalDegrees
dd = fromDMS 51 28 40
-- DD 51.477777777777774

(d, m, s) = toDMS dd
-- (51,28,39.999999999987494)
@

== /Geographic Coordinates/
@
import Data.Astro.Types

-- the Royal Observatory, Greenwich
ro :: GeographicCoordinates
ro = GeoC (fromDMS 51 28 40) (-(fromDMS 0 0 5))
-- GeoC {geoLatitude = DD 51.4778, geoLongitude = DD (-0.0014)}
@
-}

module Data.Astro.Types
(
  DecimalDegrees(..)
  , DecimalHours (..)
  , GeographicCoordinates(..)
  , AstronomicalUnits(..)
  , lightTravelTime
  , kmToAU
  , auToKM
  , toDecimalHours
  , fromDecimalHours
  , toRadians
  , fromRadians
  , fromDMS
  , toDMS
  , fromHMS
  , toHMS
)

where

import Data.Astro.Utils as U


newtype DecimalDegrees = DD Double


instance Num DecimalDegrees where
  (+) (DD d1) (DD d2) = DD (d1+d2)
  (-) (DD d1) (DD d2) = DD (d1-d2)
  (*) (DD d1) (DD d2) = DD (d1*d2)
  negate (DD d) = DD (negate d)
  abs (DD d) = DD (abs d)
  signum (DD d) = DD (signum d)
  fromInteger int = DD (fromInteger int)

instance Real DecimalDegrees where
  toRational (DD d) = toRational d

instance Fractional DecimalDegrees where
  (/) (DD d1) (DD d2) = DD (d1/d2)
  recip (DD d) = DD (recip d)
  fromRational r = DD (fromRational r)

instance RealFrac DecimalDegrees where
  properFraction (DD d) =
    let i f = properFraction d
    in i DD f


newtype DecimalHours = DH Double


instance Num DecimalHours where
  (+) (DH d1) (DH d2) = DH (d1+d2)
  (-) (DH d1) (DH d2) = DH (d1-d2)
  (*) (DH d1) (DH d2) = DH (d1*d2)
  negate (DH d) = DH (negate d)
  abs (DH d) = DH (abs d)
  signum (DH d) = DH (signum d)
  fromInteger int = DH (fromInteger int)

instance Real DecimalHours where
  toRational (DH d) = toRational d

instance Fractional DecimalHours where
  (/) (DH d1) (DH d2) = DH (d1/d2)
  recip (DH d) = DH (recip d)
  fromRational r = DH (fromRational r)

instance RealFrac DecimalHours where
  properFraction (DH d) =
    let i f = properFraction d
    in i DH f


-- | Convert decimal degrees to decimal hours
toDecimalHours :: DecimalDegrees -> DecimalHours
toDecimalHours (DD d) = DH $ d/15  -- 360 / 24 = 15

-- | Convert decimal hours to decimal degrees
fromDecimalHours :: DecimalHours -> DecimalDegrees
fromDecimalHours (DH h) = DD $ h*15


-- | Geographic Coordinates
data GeographicCoordinates = GeoC {
  geoLatitude :: DecimalDegrees
  , geoLongitude :: DecimalDegrees
  } deriving Show Eq


-- | Astronomical Units, 1AU = 1.4960×1011 m
-- (originally, the average distance of Earth's aphelion and perihelion).
newtype AstronomicalUnits = AU Double


instance Num AstronomicalUnits where
  (+) (AU d1) (AU d2) = AU (d1+d2)
  (-) (AU d1) (AU d2) = AU (d1-d2)
  (*) (AU d1) (AU d2) = AU (d1*d2)
  negate (AU d) = AU (negate d)
  abs (AU d) = AU (abs d)
  signum (AU d) = AU (signum d)
  fromInteger int = AU (fromInteger int)

instance Real AstronomicalUnits where
  toRational (AU d) = toRational d

instance Fractional AstronomicalUnits where
  (/) (AU d1) (AU d2) = AU (d1/d2)
  recip (AU d) = AU (recip d)
  fromRational r = AU (fromRational r)

instance RealFrac AstronomicalUnits where
  properFraction (AU d) =
    let i f = properFraction d
    in i AU f


-- | Light travel time of the distance in Astronomical Units
lightTravelTime :: AstronomicalUnits -> DecimalHours
lightTravelTime (AU ro) = DH $ 0.1386*ro


kmInOneAU :: Double
kmInOneAU = 149597870.700


-- | Convert from kilometers to Astronomical Units
kmToAU :: Double -> AstronomicalUnits
kmToAU km = AU (km / kmInOneAU)


-- | Comvert from Astronomical Units to kilometers
auToKM :: AstronomicalUnits -> Double
auToKM (AU au) = au * kmInOneAU


-- | Convert from DecimalDegrees to Radians
toRadians (DD deg) = U.toRadians deg


-- | Convert from Radians to DecimalDegrees
fromRadians rad = DD $ U.fromRadians rad


-- | Convert Degrees, Minutes, Seconds to DecimalDegrees
fromDMS :: RealFrac a => Int -> Int -> a -> DecimalDegrees
fromDMS d m s =
  let d' = fromIntegral d
      m' = fromIntegral m
      s' = realToFrac s
  in DD $ d'+(m'+(s'/60))/60


-- | Convert DecimalDegrees to Degrees, Minutes, Seconds
toDMS (DD dd) =
  let d rm = properFraction dd
      m rs = properFraction $ 60 * rm
      s = 60 * rs
  in d m s


-- | Comvert Hours, Minutes, Seconds to DecimalHours
fromHMS :: RealFrac a => Int -> Int -> a -> DecimalHours
fromHMS h m s =
  let h' = fromIntegral h
      m' = fromIntegral m
      s' = realToFrac s
  in DH $ h'+(m'+(s'/60))/60


-- | Convert DecimalDegrees to Degrees, Minutes, Seconds
toHMS (DH dh) =
  let h rm = properFraction dh
      m rs = properFraction $ 60 * rm
      s = 60 * rs
  in h m s
