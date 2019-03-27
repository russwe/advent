module advent.d08

(*
A header, which is always exactly two numbers: 
The quantity of child nodes.
The quantity of metadata entries.
Zero or more child nodes (as specified in the header).
One or more metadata entries (as specified in the header).

    C M <C M <C M m> m> m ...
*)

let input =
    getInput "d08.txt"
    |> Seq.collect ( fun l -> l.Split([| ' ' |]) |> Array.toSeq)
    |> Seq.map int
    |> Seq.toList

let p1 () =
    let rec processNode total nodes =
        let rec processNodes total nodes count =
            if count > 0 then
                let t, n = processNode total nodes
                processNodes t n (count-1)
            else
                total, nodes

        let rec processMetadata total nodes count =
            match nodes with
            | m :: ms when count > 0 -> processMetadata (total + m) ms (count-1)
            | _ -> total, nodes

        match nodes with
        | nc :: mc :: ns ->
            let t, n = processNodes total ns nc
            processMetadata t n mc
        | _ -> total, nodes

    processNode 0 input

type State =
    {
        HasChildren : bool
        ChildCount : int
        MetaCount : int
        Totals : int list
    }

let p2 () =
    let rec loop state nodes =
        let meta s nodes = 
            let rec loop total count nodes selector =
                match nodes with
                | n :: ns when count > 0 ->
                    let v = selector n

                    loop (v + total) (count - 1) ns selector
                | _ -> total, nodes

            let metaLoop = loop 0 s.MetaCount nodes

            if s.HasChildren then
                let totals = s.Totals |> List.toArray
                metaLoop (fun n -> if n > 0 && n <= totals.Length then totals.[totals.Length-n] else 0)
            else
                metaLoop id

        match state, nodes with
        | s :: ss, cc :: mc :: ns when s.ChildCount > 0 ->
            let nstate = {
                HasChildren = cc > 0
                ChildCount = cc
                MetaCount = mc
                Totals = []
            }

            let ustate = { s with ChildCount = s.ChildCount - 1 }
            
            loop ( nstate :: ustate :: ss ) ns


        | sc :: sn :: ss, _ ->
            let t, ns = meta sc nodes
            loop ({ sn with Totals = t :: sn.Totals } :: ss) ns
            
        | s :: ss, _ -> meta s nodes |> fst

        | [], cc :: mc :: ns ->
            let nstate = {
                HasChildren = cc > 0
                ChildCount = cc
                MetaCount = mc
                Totals = []
            }

            loop [ nstate ] ns

        | _ -> -1 // Shouldn't happen //

    loop [] input
