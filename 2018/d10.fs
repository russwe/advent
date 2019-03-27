module advent.d10

open System

type Point = { L : int * int ; V : int * int }

(*
Each line represents one point.
Positions are given as <X, Y> pairs:
* X represents how far left (negative) or right (positive) the point appears
* Y represents how far up (negative) or down (positive) the point appears.

0,0       (up -)
            |
(- left) ---|--- (right +)
            |
         (down +)      n,n
*)

let parseInput =
    // position=< 51730, -30721> velocity=<-5,  3>
    let r = rx "position=<\s*(-?\d+),\s*(-?\d+)\s*> velocity=<\s*(-?\d+),\s*(-?\d+)\s*>"
    let parse line =
        let m = r line
        
        {
            L = int32 m.Groups.[1].Value, int32 m.Groups.[2].Value
            V = int32 m.Groups.[3].Value, int32 m.Groups.[4].Value
        }

    parse

let input =
    getInput "d10.txt"
    |> Seq.map parseInput
    |> Seq.toList

let p1 () =
    let rec advance points =
        let rec advancePoints npoints hx hy lx ly points =
            match points with
            | p :: ps ->
                let nx = (fst p.L)+(fst p.V)
                let ny = (snd p.L)+(snd p.V)

                let nhx = max hx nx
                let nhy = max hy ny

                let nlx = min lx nx
                let nly = min ly ny

                let np = {p with L = nx, ny}
                
                advancePoints (np :: npoints) nhx nhy nlx nly ps

            | _ -> npoints, hx, hy, lx, ly
        
        let npoints, hx, hy, lx, ly = advancePoints [] Int32.MinValue Int32.MinValue Int32.MaxValue Int32.MaxValue points

        let dy = hy - ly
        if dy <= 9 then
            let dx = hx - lx
            let normalize p = snd p.L - ly , fst p.L - lx
            npoints |> List.map normalize , dx , dy
        else
            advance npoints

    let disp dx dy points =
        let spoints =
            points
            |> List.distinct
            |> List.sort

        let rec loop cx cy points =
            let nx = (cx + 1) % (dx + 1)
            let ny = if nx = 0 then cy + 1 else cy
    
            if cx = 0 then printf "\n"
    
            match points with

            | (y,x) :: ps when cx = x && cy = y ->
                printf "#"
                loop nx ny ps
            | p :: ps ->
                printf " "
                loop nx ny points
            | _ -> ()

        loop 0 0 spoints
        
    let points, dx, dy = advance input
    disp dx dy points

let p2 () =
    let rec advance count points =
        let rec advancePoints npoints hx hy lx ly points =
            match points with
            | p :: ps ->
                let nx = (fst p.L)+(fst p.V)
                let ny = (snd p.L)+(snd p.V)

                let nhx = max hx nx
                let nhy = max hy ny

                let nlx = min lx nx
                let nly = min ly ny

                let np = {p with L = nx, ny}
            
                advancePoints (np :: npoints) nhx nhy nlx nly ps

            | _ -> npoints, hx, hy, lx, ly
    
        let npoints, hx, hy, lx, ly = advancePoints [] Int32.MinValue Int32.MinValue Int32.MaxValue Int32.MaxValue points

        let dy = hy - ly
        if dy <= 9 then
            count
        else
            advance (count + 1L) npoints

    advance 1L input