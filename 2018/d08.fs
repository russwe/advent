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

let p1 =
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

let p2 =
    // Depth-First, walk nodes; sum 0-child metadata; put children into array, sum children values
    0