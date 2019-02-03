module advent.d03

let parse (line : string) = // #1 @ 167,777: 23x12
    let c = line.Split([| '#' ; '@' ;  ',' ;  ':' ; 'x' ; ' ' |], System.StringSplitOptions.RemoveEmptyEntries)
            |> Array.map int

    (c.[0], c.[1], c.[2], c.[3], c.[4]) // index, fromLeft, fromTop, width, height

let input = getInput "d03.txt" |> Seq.map parse


let p1 =
    input
    |> Seq.collect (fun (_,l,t,w,h) -> seq { for x in l..(l+w-1) do for y in t..(t+h-1) do yield x,y })
    |> Seq.groupBy id
    |> Seq.filter (fun (k,v) -> (Seq.length v) > 1 )
    |> Seq.length

let p2 =
    let mx = input |> Seq.map (fun (i,_,_,_,_) -> i) |> Seq.max

    let overlapping =
        input
        |> Seq.collect (fun (i,l,t,w,h) -> seq { for x in l..(l+w-1) do for y in t..(t+h-1) do yield i,x,y })
        |> Seq.groupBy (fun (i,x,y) -> x,y)
        |> Seq.filter (fun (_,v) -> (Seq.length v) > 1 )
        |> Seq.collect (fun (_, v) -> v)
        |> Seq.map (fun (i,_,_) -> i)
        |> Seq.distinct
                        
    Seq.except overlapping (seq { 1..mx })
