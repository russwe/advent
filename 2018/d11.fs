module advent.d11

type XYP = { X : int ; Y : int ; P : int }

let p size sn =
    (*
        Find the fuel cell's rack ID, which is its X coordinate plus 10.
        Begin with a power level of the rack ID times the Y coordinate.
        Increase the power level by the value of the grid serial number (your puzzle input).
        Set the power level to itself multiplied by the rack ID.
        Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
        Subtract 5 from the power level.
    *)
    let power x y =
        let rackId = x + 10
        let powerLevel = ((rackId * y) + sn) * rackId
        let hundreds = powerLevel / 100 % 10

        hundreds - 5

    let sumWindow (w : XYP array) = { X = w.[0].X ; Y = w.[0].Y ; P = w |> Array.sumBy (fun {P = p} -> p) }

    // need to break on col width ... adding too much in first pass
    // second pass?
    seq {
        for y in  1..size do
            for x in 1..size do
                yield x, y
    }
    |> Seq.map (fun (x,y) -> { X = x ; Y = y ; P = power x y })
    |> Seq.chunkBySize size
    |> Seq.collect (fun p ->
        p
        |> Seq.windowed 3
        |> Seq.map sumWindow)
    |> Seq.sortBy (fun t -> t.X, t.Y)
    |> Seq.windowed 3
    |> Seq.map sumWindow
    |> Seq.maxBy (fun { P = p } -> p)
