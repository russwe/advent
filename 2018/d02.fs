module advent.d02

let lines = getInput "d02.txt"

let p1 = 
    let results = lines |> Seq.fold (fun (two, three) line ->
        let has = line.ToCharArray()
                    |> Array.groupBy id
                    |> Array.fold (fun (hasTwo, hasThree) e -> match e with
                                                                | (_, v) when v.Length = 2 -> (1, hasThree)
                                                                | (_, v) when v.Length = 3 -> (hasTwo, 1)
                                                                | _ -> (hasTwo, hasThree))
                    (0, 0)

        (two + (fst has), three + (snd has))) (0,0)

    (fst results) * (snd results)

let p2 =
    let diff s1 s2 = Seq.fold2 (fun c a b -> if a = b then c else c+1) 0 s1 s2
    let matching = Seq.allPairs lines lines |> Seq.find (fun (a, b) -> (diff a b) = 1)

    Seq.fold2 (fun a b c -> if b = c then b :: a else a) [] (fst matching) (snd matching)
    |> List.map string
    |> List.rev
    |> String.concat ""
