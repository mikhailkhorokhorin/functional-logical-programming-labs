let eps = 0.00001
let maxIterations = 100

let isFinite (x: float) =
    not (System.Double.IsNaN x || System.Double.IsInfinity x)

let dichotomy f a b =
    let rec loop a b =
        let mid = (a + b) / 2.0

        if abs (f mid) < eps || b - a < eps then Ok mid
        elif f a * f mid < 0.0 then loop a mid
        else loop mid b

    if f a * f b > 0.0 then Error "no sign change" else loop a b

let newton f df x0 =
    let rec loop x iter =
        let d = df x

        if iter >= maxIterations then
            Error "no convergence"
        elif abs d < 1e-12 then
            Error "zero derivative"
        else
            let next = x - f x / d

            if not (isFinite next) then Error "diverged"
            elif abs (next - x) < eps then Ok next
            else loop next (iter + 1)

    loop x0 0

let iterations g x0 =
    let rec loop x iter =
        let next = g x

        if iter >= maxIterations then Error "no convergence"
        elif not (isFinite next) then Error "diverged"
        elif abs (next - x) < eps then Ok next
        else loop next (iter + 1)

    loop x0 0

let f28 x = x - 2.0 + sin (1.0 / x)
let df28 x = 1.0 - cos (1.0 / x) / (x * x)
let g28 x = 2.0 - sin (1.0 / x)

let f1 x = exp x + log x - 10.0 * x
let df1 x = exp x + 1.0 / x - 10.0
let g1 x = log (10.0 * x - log x)

let f2 x = cos x - exp (-x * x / 2.0) + x - 1.0
let df2 x = -sin x + x * exp (-x * x / 2.0) + 1.0
let g2 x = 1.0 - cos x + exp (-x * x / 2.0)

let cell result =
    match result with
    | Ok x -> sprintf "%.5f" x
    | Error message -> message

let printRow name a b x0 f df g =
    printfn "%-10s | %-16s | %-16s | %s" name (cell (dichotomy f a b)) (cell (newton f df x0)) (cell (iterations g x0))

let main () =
    printfn "%-10s | %-16s | %-16s | %s" "Equation" "Dichotomy" "Newton" "Iterations"
    printfn "%s" (String.replicate 61 "-")
    printRow "28" 1.2 2.0 1.5 f28 df28 g28
    printRow "1" 3.0 4.0 3.5 f1 df1 g1
    printRow "2" 0.5 2.0 1.0 f2 df2 g2
    printRow "x^2+1" (-1.0) 1.0 0.0 (fun x -> x * x + 1.0) (fun x -> 2.0 * x) (fun x -> x * x + x + 1.0)

main ()
