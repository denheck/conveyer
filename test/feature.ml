let test () = Alcotest.(check int) "1 + 1 = 2" 2 (1 + 1)
let test_set = ["Test test", `Quick, test;]
let () = Alcotest.run "Feature Tests" ["test_set", test_set]
