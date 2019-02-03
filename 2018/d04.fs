module advent.d04

(* Sample Input:
    [1518-03-23 00:35] falls asleep
    [1518-07-04 00:56] wakes up
    [1518-05-19 23:50] Guard #2447 begins shift
*)

type GuardAction = 
    | Wake
    | Sleep
    | Start of int

type GuardEvent = {
    ts : System.DateTime
    action : GuardAction
    id : int option
}

let parse (line : string) =
    let m = rx "^\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2})\] (falls asleep|wakes up|Guard #(\d+) begins shift)$" line
 
    {
        ts = System.DateTime.Parse m.Groups.[1].Value
        
        action =
            match m.Groups.[2].Value with
            | "wakes up" -> Wake
            | "falls asleep" -> Sleep
            | _ -> Start (int m.Groups.[3].Value)

        id = None
    }

let input =
    getInput "d04.txt"
    |> Seq.map parse
    |> Seq.sort
    |> Seq.mapFold (fun cid r -> 
        let nid =
            match r.action with
            | Start i -> Some i
            | _ -> cid
        
        ({
            ts = r.ts
            action = r.action
            id = cid
        }, nid)
    ) None

let p1 =
    let max = 
        fst input
        |> Seq.pairwise
        |> Seq.choose (fun (a, b) -> match a.action with | Sleep -> Some (a.id, a.ts, b.ts) | _ -> None)
        |> Seq.groupBy (fun (i, _, _) -> i)
        |> Seq.maxBy (fun (_, s) -> s |> Seq.sumBy (fun (_, s, e) -> (e - s).TotalMinutes))

    let minute =
        snd max
        |> Seq.collect (fun (_, s, e) -> seq { for m in s.Minute .. (e.Minute-1) do yield m })
        |> Seq.countBy id
        |> Seq.maxBy snd

    ((fst max), minute, ((fst max).Value * (fst minute)))

let p2 =
    let result = 
        fst input
        |> Seq.pairwise
        |> Seq.choose (fun (a, b) -> match a.action with | Sleep -> Some (a.id, a.ts, b.ts) | _ -> None)
        |> Seq.collect (fun (i, s, e) -> seq { for m in s.Minute .. (e.Minute-1) do yield (i, m) })
        |> Seq.countBy id
        |> Seq.maxBy snd
    
    let r = fst result
    (r, (fst r).Value * (snd r))