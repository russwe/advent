module advent.d07

let parse =
    let regex = rx "Step (.) must be finished before step (.) can begin"
    fun l ->
        let m = regex l
        (m.Groups.[1].Value.[0], m.Groups.[2].Value.[0])

let input = getInput "d07.txt" |> Seq.map parse

let getReady waiting alphabet =
    let ready =
        waiting
        |> Seq.map snd
        |> Set.ofSeq
        |> Set.difference alphabet

    (Set.toList ready, Set.difference alphabet ready)
    
let p1 =
    let rec loop completed ready waiting alphabet =

        let rdy,alpha = getReady waiting alphabet
        let queue = List.concat [rdy ; ready] |> List.sort

        match queue with
        | q :: qs -> loop (q :: completed) qs (waiting |> List.filter (fun (b,_) -> q <> b)) alpha
        | _ -> completed |> List.rev

    loop [] [] (List.ofSeq input) (Set.ofSeq { 'A' .. 'Z' })
    |> List.map string
    |> String.concat ""

let p2 =
    let rec loop timeElapsed processing waiting alphabet =

        let rdy,alpha = getReady waiting alphabet
        let wrdy = rdy |> List.map (fun r -> 1, 61 + (int r) - (int 'A'), r)

        let queue = processing @ wrdy |> List.sort

        let _,time,_ = List.head queue

        // 5 workers don't trade out tasks, must finish work before a slot can be taken (1 = pending / 0 = processing, remaining time, step)
        let rec reduceQ index completed processed queue = 
            match queue with
            | (_,t,a) :: qs when index < 5 -> 
                if t - time = 0 then
                    reduceQ (index + 1) (completed |> Set.add a) processed qs
                else
                    reduceQ (index + 1) completed ((0, t - time, a) :: processed) qs
            | _ -> completed, processed @ queue
        
        let completed,eq = reduceQ 0 Set.empty [] queue

        // Is there a better condition here?  Really we want to check if there is anything *ready*, but we don't do that until after we loop
        let remaining = waiting |> List.filter (not << completed.Contains << fst)
        match (eq, waiting) with
        | _ :: _ , _
        | _ , _ :: _ -> loop (timeElapsed + time) eq remaining alpha
        | _ -> timeElapsed + time

    loop 0 [] (List.ofSeq input) (Set.ofSeq { 'A' .. 'Z' })