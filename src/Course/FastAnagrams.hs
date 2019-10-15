{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Course.FastAnagrams where

import Course.Core
import Course.List
import Course.Functor
import qualified Data.Set as S

-- Return all anagrams of the given string
-- that appear in the given dictionary file.
-- on a Mac - run this with:
-- > fastAnagrams "Tony" "/usr/share/dict/words"
fastAnagrams ::
  Chars
  -> FilePath
  -> IO (List Chars)
fastAnagrams s =
  (<$>) ( map ncString
        . listh
        . S.toList
        . S.intersection (( S.fromList
                          . hlist
                          . map NoCaseString
                          . permutations
                          ) s)
        . S.fromList
        . hlist
        . map NoCaseString
        . lines
        ) . readFile

newtype NoCaseString =
  NoCaseString {
    ncString :: Chars
  }

instance Eq NoCaseString where
  (==) = (==) `on` map toLower . ncString

instance Ord NoCaseString where
  compare = compare `on` ncString

instance Show NoCaseString where
  show = show . ncString
