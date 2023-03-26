{-|
Module: Data.Astro.Utils
Description: Utility functions
Copyright: Alexander Ignatyev, 2016

Utility functions.
-}


module Data.Astro.Utils
(
  fromFixed
  , trunc
  , fraction
  , reduceToZeroRange
  , toRadians
  , fromRadians
  , roundToN
  , tropicalYearLen
)

where

import Data.Fixed(Fixed(MkFixed), class HasResolution)
import Data.Tuple(Tuple)

-- | return the integral part of a number
-- almost the same as truncate but result type is Real
trunc :: RealFrac a => a -> a
trunc = fromIntegral . truncate


-- | Almost the same the properFraction function but result type
fraction :: RealFrac a Num b => a -> Tuple b a
fraction v = let Tuple i f = properFraction v
             in Tuple fromIntegral i f


-- | Reduce to range from 0 to n
reduceToZeroRange :: RealFrac a => a -> a -> a
reduceToZeroRange r n =
  let b = n - (trunc (n / r)) * r
  in if b < 0 then b + r else b


-- | Convert from degrees to radians
toRadians :: Floating a => a -> a
toRadians deg = deg*pi/180


-- | Convert from radians to degrees
fromRadians :: Floating a => a -> a
fromRadians rad = rad*180/pi


-- | Round to a specified number of digits
roundToN :: RealFrac a => Int -> a -> a
roundToN n f = (fromInteger $ round $ f * factor) / factor
  where factor = 10.0^^n


-- | Length of a tropical year in days
tropicalYearLen :: Double
tropicalYearLen = 365.242191
