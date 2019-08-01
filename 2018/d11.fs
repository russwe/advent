module advent.d11

type XYP = { X : int ; Y : int ; P : int }

let p1 size sn =
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

let p2 size sn =
    // compute square (memoized)
    let power = new System.Collections.Concurrent.ConcurrentDictionary<int*int*int, int>()
    let rec computeSquare x y s =
        let compute x y s =
            if s = 1 then
                let rackId = x + 10
                let powerLevel = ((rackId * y) + sn) * rackId
                let hundreds = powerLevel / 100 % 10

                hundreds - 5
            elif s % 2 = 0 then
                let a = s / 2

                seq {
                    //   (a) > a
                    yield computeSquare ( x     ) ( y     ) a
                    
                    //   (a) v a
                    yield computeSquare ( x + a ) ( y     ) a

                    //   (a) < a
                    yield computeSquare ( x + a ) ( y + a ) a
                    
                    //   (a)
                    yield computeSquare ( x     ) ( y + a ) a

                } |> Seq.sum
            else
                let a = (s + 1) / 2
                let b = a - 1
                
                seq { 
                    //   (a) \  a ... 1
                    yield computeSquare x y a

                    //   (b) ^< b ... 2
                    yield computeSquare ( x + a ) ( y + a ) b

                    yield computeSquare ( x + a ) ( y + 1 ) b
                    yield computeSquare ( x + 1 ) ( y + a ) b
                    
                    //   (c) >v c ... b
                    for n = 0 to b-1 do
                        yield computeSquare ( x + a + n ) ( y         ) 1
                        yield computeSquare ( x         ) ( y + a + n ) 1
                }
                |> Seq.sum

        let k = x,y,s
        match power.TryGetValue(k) with
        | true, v ->
            //printfn "[M] %A %A %A = %A" x y s v
            v
        | false, _ ->
            let v = compute x y s
            power.TryAdd(k, v) |> ignore
            // printfn "[C] %A %A %A = %A" x y s v
            v

    seq {
        for s = 1 to size do
            let bound = size - s + 1
            for x = 1 to bound do
                System.Console.Title <- sprintf "%3i %3i" s x
                for y = 1 to bound do
                    yield (x,y,s)
    }
    |> Seq.maxBy (function (x,y,s) -> computeSquare x y s)
