module Main (
    main
) where

import Text.Pandoc.JSON
import Text.Pandoc
import System.Process
import Data.List
import System.IO.Temp
import System.IO
import System.Directory


-- | Merges the code block and its output into a Pandoc 'Block'
combine :: Block -> String -> Block
combine cb out = Div ("", [], []) ([cb] ++ bs)
    where (Pandoc _ bs) = readDoc out

readDoc :: String -> Pandoc
readDoc s = case readMarkdown def s of
                 Right doc -> doc
                 Left err  -> error (show err)

output :: Block -> IO Block
output cb@(CodeBlock (_, ["haskell"], namevals) xs) = 
    case lookup "runWith" namevals of
        Just c -> do
            (tmpFile, hFile) <- openTempFile "./" "*.hs"
            hPutStr hFile xs
            hClose hFile
            let ([cName], params) = splitAt 1 $ words c
            out <- readProcess cName (params ++ [tmpFile]) []
            removeFile tmpFile
            return $ combine cb out
        Nothing -> return cb
output x = return x

main :: IO ()
main = toJSONFilter output
