## Idea

Analyze existing code analysis tools for Transaction Order Dependence (TOD). The thesis will:
- define several categories of TOD that code analysis tools can detect
- understand which categories the code analysis tools cover and to what extend

## Problem Statement & Motivation

Ethereum bla bla, many attacks using TOD.

A variety of existing tools, yet no understanding of which types of TOD are detected by these tools.

With such an understanding, it is easier to compare existing tools by the types of TOD they can detect, while also pointing out areas of further research.


## Aim of the Thesis and Expected Results

Define categories of TOD relevant to code analysis detection.

Create an overview of existing code analysis tools for TOD, where one can see which categories of TOD they detect and to what extend.

## Methodology

State of the Art research:
- existing work on categorizing TOD
- existing work on code analysis tools for TOD
- existing work on data sets with labelled contracts (TOD-vulnerable, TOD-resistant)

In addition to literature review, this will also include researching tools and data sets which are not yet covered by literature. This is necessary, as the literature often is not up-to-date for such tools.

Based on this research, I will define a set of TOD types, that divide the general TOD to multiple subtypes. These should reflect the different types of solving strategies that code analysis tools can have (TODO: what exactly do I mean here? This sounds like gut feeling - I kinda want to include assumptions / my hypothesis of where the limits of individual approaches are into the type definitions).

Taking existing datasets of vulnerable and non-vulnerable contracts, these new TOD type definitions will be added as labels to the contracts. As there are no tools for this problem yet, this will require a manual investigation of the contracts. When identifying many contracts with similar patterns, small scripts can be written that test for specific instances of these TOD types.

Now we will have a database of contracts, where each contract is labelled on whether they are vulnerable to the TOD types. With this, I will analyze which tools can detect which TOD types. Depending on the availability and usability of the tools, this will cover a practical analysis by testing them against the dataset, or a theoretical analysis of their detection approach.



## State of the Art

...

## Context within the Master Program

- VU Smart Contracts
- Security courses (race conditions, etc)
- Formal methods for Security & Privacy (understanding how program verification works)