import Pipes (for, lift, runEffect)
import System.Directory (copyFile)
import System.Environment (getArgs)
import System.FilePath ((</>), takeFileName)
import Text.Regex (mkRegex, matchRegex)
import Util.StreamDirectory (getRecursiveContents)

copyTextFile :: FilePath -> FilePath -> IO ()
copyTextFile dst file = case matchRegex (mkRegex "txt$") file of
    Just _ -> copyFile file $ dst </> (takeFileName file)
    Nothing -> return ()

main :: IO ()
main = do
    [startDir, dst] <- getArgs
    runEffect $ for (getRecursiveContents startDir) (lift . copyTextFile dst)

