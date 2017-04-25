{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Monad
import Control.Monad.IO.Class

import GHCJS.DOM (currentDocument)
import GHCJS.DOM.Document (getElementById)
import GHCJS.DOM.Element (submit)
import GHCJS.DOM.EventM (on)
import GHCJS.DOM.HTMLFormElement ()
import GHCJS.DOM.Types

-- For an up to date list of what ghcjs-dom can do, download ghcjs-dom-0.7.0.4
import Language.Javascript.JSaddle
import Prelude hiding ((!!))

endpoint :: String
endpoint = "api/quotations"

data Quote = Quote
  { text :: String
  , author :: String
  } deriving (Eq, Show, Read)

getElementByIdUnchecked e i =
  let gGetById f d ii = fmap f <$> getElementById d ii
  in do Just doc <- currentDocument
        Just myForm <- gGetById (uncheckedCastTo e) doc i
        return myForm

main :: IO ()
main =
  runJSaddle () $ do
    myForm <- getElementByIdUnchecked HTMLFormElement "add-form"
    void $ on myForm submit $ do liftIO $ putStrLn "Event received!"
    return ()
