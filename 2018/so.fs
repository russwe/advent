[<AutoOpen>]
module advent.so

// https://stackoverflow.com/questions/3851296/f-return-element-pairs-in-list
let rec pairs l = seq {  
    match l with 
    | h::t -> for e in t do
                yield h, e
                yield! pairs t
    | _ -> ()
}

// https://en.wikibooks.org/wiki/F_Sharp_Programming/Caching
// https://stackoverflow.com/questions/30468925/is-memoizing-possible-without-side-effects
let memoize f =
    let dict = new System.Collections.Concurrent.ConcurrentDictionary<_,_>()
    fun n ->
        match dict.TryGetValue(n) with
        | true, v -> v
        | false, _ ->
             let v = f n
             dict.TryAdd(n, v) |> ignore
             v