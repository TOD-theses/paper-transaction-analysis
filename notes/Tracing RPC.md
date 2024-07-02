```
cast rpc debug_traceBlockByNumber 0x12f94fa '{"tracer": "prestateTracer", "tracerConfig": { "diffMode": false } }' -r http://localhost:8124/eth > out_pre.json
cast rpc debug_traceBlockByNumber 0x12f94fa '{"tracer": "prestateTracer", "tracerConfig": { "diffMode": true } }' -r http://localhost:8124/eth > out.json
```

The prestate tracer:
- for created contracts, it includes balance: 0x0 (at least for this one tx)
- not sure it includes unchanged values

The diff tracer:
- does not include unchanged state
- does not include 0x0 storage slots
- does not include created accounts in the pre state
- does not include destroyed accounts in the post state

We likely need more post-processing for the diff-tracer ()

