I'm having an issue with `htmgrrrl` that I have a feeling is pebkac, but I just can't figure out what I'm doing wrong.

I created an example repo & test to show the behavior I'm getting, which can be found here: https://github.com/bchase/gleam_htmlgrrrl_issue/blob/master/test/example_test.gleam#L50-L60

As you can see from the debug output below, it successfully matches the attribute value I'm looking for, builds up `state` as desired... but then the `htmgrrrl.sax` call itself returns `Error(Nil)`.

```
  Compiled in 0.01s
    Running example_test.main
[]
[]
[]
[]
["https://example.com/image.webp"]
["https://example.com/image.webp"]
["https://example.com/image.webp"]
["https://example.com/image.webp"]
Error(Nil)
F
Failures:

  1) example_test.example_test: module 'example_test'
     Values were not equal
     expected: Ok(["https://example.com/image.webp"])
          got: Error(Nil)
     output:

Finished in 0.016 seconds
1 tests, 1 failures
```

Thanks in advance for any help!
