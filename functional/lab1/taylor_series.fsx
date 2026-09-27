let a = System.Math.PI / 5.0
let b = 6.0 * System.Math.PI / 5.0
let n = 10
let eps = 0.01
let maxTerms = 100000

let f x = -log(abs (2.0 * sin (x / 2.0)))

let tailBound x k =
    1.0 / (float (k + 1) * abs (sin (x / 2.0)))

let sumSeries x term =
    let rec loop k state acc =
        if k > maxTerms then
            None
        else
            let value, next = term k state
            let sum = acc + value

            if tailBound x k < eps then
                Some(sum, k)
            else
                loop (k + 1) next sum

    loop

let taylorDumb x =
    let term k () = cos (float k * x) / float k, ()
    sumSeries x term 1 () 0.0

let taylorSmart x =
    let cosx = cos x
    let sinx = sin x

    let term k (cosKx, sinKx) =
        let cosNext = cosKx * cosx - sinKx * sinx
        let sinNext = sinKx * cosx + cosKx * sinx
        cosKx / float k, (cosNext, sinNext)

    sumSeries x term 1 (cosx, sinx) 0.0

let cells result =
    match result with
    | Some(value, terms) -> sprintf "%12.6f | %6d" value terms
    | None -> sprintf "%12s | %6s" "n/a" "n/a"

let main () =
    printfn "%8s | %12s | %12s | %6s | %12s | %6s" "x" "Builtin" "Smart Taylor" "Terms" "Dumb Taylor" "Terms"
    printfn "%s" (String.replicate 71 "-")

    for i in 0..n do
        let x = a + float i / float n * (b - a)
        printfn "%8.4f | %12.6f | %s | %s" x (f x) (cells (taylorSmart x)) (cells (taylorDumb x))

main ()
