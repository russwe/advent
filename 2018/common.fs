[<AutoOpen>]
module advent.common

open System.IO;
open System.Text.RegularExpressions

let getInput (fileName : string) : string seq =

    seq {
        use fs = new FileStream(fileName, FileMode.Open, FileAccess.Read);
        use sr = new StreamReader(fs);
        
        while not sr.EndOfStream do yield sr.ReadLine()
    }

let rx expr = 
    let rex = new Regex(expr, RegexOptions.Compiled)
    rex.Match