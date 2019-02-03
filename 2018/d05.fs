module advent.d05

let input =
    getInput "d05.txt"
    |> Seq.collect id

let react polymer =
    let rec loop reduced reversed pleft pright =
        match pright with
        | a :: b :: p when abs ((int a) - (int b)) = 32 -> loop true reversed pleft p
        | a :: p -> loop reduced reversed (a :: pleft) p
        | [] -> if reduced then loop false (not reversed) [] pleft elif reversed then pleft |> List.rev else pleft

    loop false true [] polymer

let p1 =
    let result = input |> Seq.toList |> react
    (result.Length, result)

let p2 =
    let trim c p =
        p
        |> Seq.filter (fun e -> (System.Char.ToLowerInvariant e) <> c)
        |> Seq.toList
        
    snd p1
    |> Seq.map System.Char.ToLowerInvariant
    |> Seq.distinctBy id
    |> Seq.map (fun c -> (c, (trim c input |> react).Length))
    |> Seq.minBy snd