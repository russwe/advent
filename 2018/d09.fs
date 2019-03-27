module advent.d09

[<AllowNullLiteral>]
type Marble(value : int) =
    let mutable p : Marble = null
    let mutable n : Marble = null

    member this.V : int = value

    member this.P : Marble = p
    member this.P with set v = p <- v

    member this.N : Marble = n
    member this.N with set v = n <- v
 
let p1 players last =
    let mutable current = new Marble(0)
    current.P <- current
    current.N <- current

    let updateCircle player next =
        if next % 23 = 0 then
            // remove 7th counter-clockwise (P)
            let remove = current.P.P.P.P.P.P.P
            
            let pm = remove.P
            let nm = remove.N

            pm.N <- nm
            nm.P <- pm

            current <- nm

            // score += next + 7th ccw
            player, next + remove.V

        else
            // two clockwise (N)
            let cw1 = current.N
            let cw2 = cw1.N

            current <- new Marble(next)

            cw1.N <- current
            current.P <- cw1

            cw2.P <- current
            current.N <- cw2

            player, 0

    { 1 .. last }
    |> Seq.map (fun m -> updateCircle (m % players) m)
    |> Seq.groupBy fst
    |> Seq.map (fun (p, v) -> p, Seq.sumBy snd v)
    |> Seq.maxBy snd

[<AllowNullLiteral>]
type MarbleL(value : int64) =
    let mutable p : MarbleL = null
    let mutable n : MarbleL = null

    member this.V : int64 = value

    member this.P : MarbleL = p
    member this.P with set v = p <- v

    member this.N : MarbleL = n
    member this.N with set v = n <- v

let p2 (players : int64) (last : int64) =
    let mutable current = new MarbleL(0L)
    current.P <- current
    current.N <- current

    let updateCircle player next =
        if next % 23L = 0L then
            // remove 7th counter-clockwise (P)
            let remove = current.P.P.P.P.P.P.P
            
            let pm = remove.P
            let nm = remove.N

            pm.N <- nm
            nm.P <- pm

            current <- nm

            // score += next + 7th ccw
            player, next + remove.V

        else
            // two clockwise (N)
            let cw1 = current.N
            let cw2 = cw1.N

            current <- new MarbleL(next)

            cw1.N <- current
            current.P <- cw1

            cw2.P <- current
            current.N <- cw2

            player, 0L

    { 1L .. last }
    |> Seq.map (fun m -> updateCircle (m % players) m)
    |> Seq.groupBy fst
    |> Seq.map (fun (p, v) -> p, Seq.sumBy snd v)
    |> Seq.maxBy snd