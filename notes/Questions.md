From preliminary results, around 25% of transactions have a conflict with another transaction in the same block. It's highly grouped by addresses (eg one single token contract is responsible for 1/4 of these collisions), thus we'll need deduplication. However, it still feels like TOD is generally not a vulnerability. Can we somehow check how much of this is really troublesome? Should this be part of my/our papers?

Duplicate detection (live): the problem is, that multiple contracts are involved in one attack. So, to detect duplicates, we need to know which contract-groups we want to deduplicate, thus need the results from the analysis.
=> I'll need to implement a lot before evaluation, and trace analysis and attack detection are tightly coupled

"We" + present tense. (cooking recipe)

Skeletons per contract function name (statically)?
    Token contracts via selector function interfaces
    contract flow graphs, but probably not good enough
    decompiler comparison

(How to )cite survey through which I found blockchain analysis papers? https://dl.acm.org/doi/10.1145/3593293. Can document, not a must.
