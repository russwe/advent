module advent.d06

let input =
    getInput "d06.txt"
    |> Seq.map (fun l ->
        let c = l.Split([|' ';','|], System.StringSplitOptions.RemoveEmptyEntries)
        ((int c.[0]), (int c.[1])))
    |> Seq.sortBy fst
    |> Seq.toArray

type MinDist =
    | One of (int * (int * int))
    | More of int
    | Zero

type Bounds = {
    xMin : int
    xMax : int

    yMin : int
    yMax : int
}

let defaultBounds = {
    xMin = System.Int32.MaxValue
    xMax = System.Int32.MinValue

    yMin = System.Int32.MaxValue
    yMax = System.Int32.MinValue
}

let dist (ax, ay) (bx, by) = (abs (ax - bx)) + (abs (ay - by))

let bounds =
    input
    |> Array.fold (fun b (x,y) -> {
        xMin = (min x b.xMin)
        xMax = (max x b.xMax)
        yMin = (min y b.yMin)
        yMax = (max y b.yMax)
    }) defaultBounds

let p1 =
    let distanceOverlay data =
        data
        |> Seq.map (fun l ->
            input
            |> Seq.fold (fun m c ->
                let d = dist l c
                match m with
                | One  v when d = fst v -> More d
                | One  v when d < fst v -> One (d, c)
                | More v when d <     v -> One (d, c)
                | Zero -> One (d, c)
                | _ -> m) Zero)
        |> Seq.choose (fun x -> match x with | One (d, c) -> Some c | _ -> None)

    let distances =
        seq { for x in bounds.xMin .. bounds.xMax do for y in bounds.yMin .. bounds.yMax do yield (x,y) }
        |> distanceOverlay
    
    let invalid =
        seq {
            for x in [| bounds.xMin-1 ; bounds.xMax+1 |] do for y in bounds.yMin-1 .. bounds.yMax+1 do yield (x,y)
            for y in [| bounds.yMin-1 ; bounds.yMax+1 |] do for x in bounds.xMin   .. bounds.yMax   do yield (x,y)
        }
        |> distanceOverlay
        |> Set.ofSeq
        
    // need to filter by "infinite" areas
    distances
    |> Seq.filter (not << invalid.Contains)
    |> Seq.countBy id
    |> Seq.maxBy snd

let p2 =
    let once f =
        let seen = System.Collections.Generic.HashSet<_>()
        fun n ->
            if (seen.Add n) then f n
            else false

    let mid =
        (bounds.xMin + (bounds.xMax - bounds.xMin) / 2),
        (bounds.yMin + (bounds.yMax - bounds.yMin) / 2)

    let inZone l = 10000 >= (input |> Seq.sumBy (dist l))

    let sumlr (x,y) =

        let leftSum =
            Seq.initInfinite (fun i -> x-i-1,y)
            |> Seq.takeWhile inZone
            |> Seq.length

        let rightSum = 
            Seq.initInfinite (fun i -> x+i+1,y)
            |> Seq.takeWhile inZone
            |> Seq.length
        
        leftSum + rightSum
    
    let rec sumu (x,y) =
        if inZone (x,y) then 1 + sumlr (x,y) + sumu (x,y+1)
        else 0

    let rec sumd (x,y) =
        if inZone (x,y) then 1 + sumlr (x,y) + sumd (x,y-1)
        else 0

    let mx,my = mid
    sumu mid + sumd (mx,my-1)
