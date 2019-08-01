module advent.d12

type Pot = { I : int64 ; S : bool }

let initial_state =
    getInput "d12_initial_state.txt"
    |> Seq.collect (fun l -> l.ToCharArray())
    |> Seq.mapi (fun i s -> { I = (int64) i ; S = s = '#' })

let transitions =
    getInput "d12_transitions.txt"
    |> Seq.map (rx "(.)(.)(.)(.)(.) => (.)")
    |> Seq.map (fun m ->
        (
            "#" = m.Groups.[1].Value,
            "#" = m.Groups.[2].Value,
            "#" = m.Groups.[3].Value,
            "#" = m.Groups.[4].Value,
            "#" = m.Groups.[5].Value
        ),
        "#" = m.Groups.[6].Value)
    |> dict

let p1 generations =
    let prepare (s : Pot seq) = 
        seq {
            use e = s.GetEnumerator()
            
            e.MoveNext()
            let mutable c = e.Current

            // Buffer Left
            for i = c.I - 4L to c.I - 1L do
                yield { I = i ; S = false }

            yield c

            while e.MoveNext() do
                c <- e.Current
                yield c

            // Buffer Right
            for i = c.I + 1L to c.I + 4L do
                yield { I = i ; S = false }
        }

    let mutate state =
        state
        |> Seq.windowed 5
        |> Seq.map (fun w -> 
            let key = w.[0].S , w.[1].S , w.[2].S , w.[3].S , w.[4].S
            { w.[2] with S = transitions.Item(key) })

    seq { 1L .. generations }
    |> Seq.fold (fun (a : Pot seq) _ -> a |> prepare |> mutate) initial_state
    |> Seq.fold (fun a p -> a + if p.S then p.I else 0L) 0L
   
let p2 generations =
    // Convert mappings into array 00000 - 11111 = 0 - 23  (24)
    let trans =
        getInput "d12_transitions.txt"
        |> Seq.map (rx "(.)(.)(.)(.)(.) => (.)")
        |> Seq.map (fun m ->
            (
                (if "#" = m.Groups.[1].Value then 1 else 0) <<< 4 |||
                (if "#" = m.Groups.[2].Value then 1 else 0) <<< 3 |||
                (if "#" = m.Groups.[3].Value then 1 else 0) <<< 2 |||
                (if "#" = m.Groups.[4].Value then 1 else 0) <<< 1 |||
                (if "#" = m.Groups.[5].Value then 1 else 0) <<< 0
            ),
            "#" = m.Groups.[6].Value)
        |> Seq.sortBy fst
        |> Seq.map snd
        |> Seq.toArray

    // yield only pots with plants
    let istate =
        getInput "d12_initial_state.txt"
        |> Seq.collect (fun l -> l.ToCharArray())
        |> Seq.mapi (fun i s -> { I = (int64) i ; S = s = '#' })
        |> Seq.filter (fun r -> r.S)
        |> Seq.map (fun r -> r.I)
        |> Seq.toArray

    // sliding window with mappings, new items only pots with plants, window has both (sparse) ... yeild only if transition is true
    let rec generate remain (state : int64 array) =
        let updateWindow window v = ((window <<< 1) ||| v) &&& 0b11111

        if remain > 0L then
            let mutable changed = false
            let newState =
                seq {
                    let mutable window = 0
                    let mutable idx = 0L
                
                    for s in state do
                        let delta = abs (s - idx)

                        // trailing
                        let tcount = (min delta 10L) - 5L
                        for t = (s - delta + 1L) to (s - delta + tcount) do
                            window <- updateWindow window 0
                            if trans.[window] then yield t - 2L
                            
                        // leading
                        let lcount = (min delta 5L)
                        for l = (s - lcount + 1L) to (s - 1L) do
                            window <- updateWindow window 0
                            if trans.[window] then yield l - 2L
                            
                        // new val
                        window <- updateWindow window 1
                        if trans.[window] then yield s - 2L
                        
                        idx <- s

                    // final trialing
                    for f = idx + 1L to idx + 4L do
                        window <- updateWindow window 0
                        if trans.[window] then yield f - 2L
                }
                |> Seq.toArray

            if state.Length = newState.Length then
                let offsets =
                    Seq.map2 (fun i1 i2 -> i2 - i1) state newState
                    |> Seq.distinct
                    |> Seq.toArray

                if offsets.Length = 1 then
                    state |> Array.map (fun i -> i + offsets.[0] * remain)
                else
                    generate (remain - 1L) newState
            else
                generate (remain - 1L) newState
        else
            state

    generate generations istate
    |> Seq.reduce (+)