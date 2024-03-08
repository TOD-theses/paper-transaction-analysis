A structured research of tools detecting frontrunning/TOD.

# Research Questions

1. Which tools exist, that (among other things) try to detect frontrunning/TOD weaknesses in Ethereum smart contracts, based on source or byte code?
2. Which methods do these tools use?
3. Which definition of frontrunning/TOD do these tools use?

# Structured Research

Similar to:
https://www.frontiersin.org/articles/10.3389/fbloc.2022.814977/full

I want to define search queries for different search platforms. These will find papers talking about detection tools. I will go through these papers, verify that they detect frontrunning/TOD, and add them to the list.

# Queries

Domains:
- Ethereum
- Frontrunning
- Automated Detection
- Vulnerability

Keywords:
- Ethereum
	- Smart Contract, Smart Contracts
- Frontrunning
	- frontrunning, front-running, front running
	- TOD, Transaction Order Dependence, Transaction Order Dependency
	- race condition
- Automated Detection
	- Tool, Tools
	- automated, automatic, automatically
	- detect, detected, detection, detector
	- analysis, analysing, analyzing, analyser, analyzer
	- (identify, identifies, identifying)
	- (evaluate, evaluator)
	- (test)
- Vulnerability
	- vulnerability, vulnerabilities
	- weakness, weaknesses
	- bug, bugs
	- security risk, security risks
	- security issue, security issues
	- insecure, insecurity

Query with all domains:
```
("Ethereum" OR "smart contract" OR "smart contracts")
AND (
    "frontrunning" OR "front-running" OR "front running"
    OR "TOD" OR "Transaction Order Dependence" OR "Transaction Order Dependency"
    OR "Race condition") 
AND (
    "tool" OR "tools"
    OR "automated" OR "automatic" OR "automatically"
    OR "detect" OR "detecting" OR "detected" OR "detection" OR "detector"
    OR "analysis" OR "analysing" OR "analyzed" OR "analysed" OR "analyser" OR "analyzer"
    OR "identify" OR "identifies" OR "identifying")
AND (
    "vulnerability" OR "vulnerabilities"
    OR "weakness" OR "weaknesses"
    OR "bug" OR "bugs"
    OR "security risk" OR "security risks"
    OR "security issue" OR "security issues"
    OR "insecurity" OR "insecurities")
```

## Searches

On the 8th March 2024:

Domains: Ethereum & Frontrunning
- [x] ACM: [207](https://dl.acm.org/action/doSearch?fillQuickSearch=false&target=advanced&expand=dl&AllField=AllField%3A%28%28%22Ethereum%22+OR+%22Smart+contract%22+OR+%22Smart+contracts%22%29+AND+%28%22Frontrunning%22+OR+%22Front-running%22+OR+%22Front+running%22+OR+%22TOD%22+OR+%22Transaction+Order+Dependence%22+OR+%22Transaction+Order+Dependency%22+OR+%22Race+condition%22%29%29+AND+AllField%3A%28%28%22Ethereum%22+OR+%22smart+contract%22+OR+%22smart+contracts%22%29+AND+%28+++++%22frontrunning%22+OR+%22front-running%22+OR+%22front+running%22+++++OR+%22TOD%22+OR+%22Transaction+Order+Dependence%22+OR+%22Transaction+Order+Dependency%22+++++OR+%22Race+condition%22%29+%29) - fulltext
- [ ] IEEE Xplore: [323](https://ieeexplore.ieee.org/search/searchresult.jsp?action=search&newsearch=true&matchBoolean=true&queryText=(%22Full%20Text%20%26%20Metadata%22:%22Ethereum%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22smart%20contract%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22smart%20contracts%22)%20AND%20(%22Full%20Text%20%26%20Metadata%22:%22frontrunning%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22front-running%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22front%20running%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22TOD%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22Transaction%20Order%20Dependence%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22Transaction%20Order%20Dependency%22%20OR%20%22Full%20Text%20%26%20Metadata%22:%22Race%20condition%22)) - fulltext
- [ ] ScienceDirect: [108](https://www.sciencedirect.com/search?qs=%28%22Ethereum%22%20OR%20%22smart%20contract%22%29%20AND%20%28%20%20%20%20%20%22frontrunning%22%20OR%20%22front-running%22%20OR%20%22front%20running%22%20%20%20%20%20OR%20%22TOD%22%20OR%20%22Transaction%20Order%20Dependence%22%20OR%20%22Transaction%20Order%20Dependency%22%20%20%20%20%20OR%20%22Race%20condition%22%29) - terms (can not use >8 logical connectors per field, plurals automatically included)

Domains: Ethereum & Automated Detection & Vulnerability
- [ ] Scopus: [1447](https://www.scopus.com/results/results.uri?sort=plf-f&src=s&st1=%22Ethereum%22++AND+%28%22Frontrunning%22+OR+%22Front-running%22+OR+%22Front+running%22+OR+%22TOD%22+OR+%22Transaction+Order+Dependence%22+OR+%22Transaction+Order+Dependency%22+OR+%22Race+condition%22%29&sid=8c71bb9ca4aab8ac677a5d1abecdea3d&sot=b&sdt=b&sl=172&s=TITLE-ABS-KEY%28%28%22Ethereum%22+OR+%22smart+contract%22+OR+%22smart+contracts%22%29+AND+%28+++++%22tool%22+OR+%22tools%22+OR+++++%22automated%22+OR+%22automatic%22+OR+%22automatically%22+++++OR+%22detect%22+OR+%22detecting%22+OR+%22detected%22+OR+%22detection%22+OR+%22detector%22+++++OR+%22analysis%22+OR+%22analysing%22+OR+%22analyzed%22+OR+%22analysed%22+OR+%22analyser%22+OR+%22analyzer%22+++++OR+%22identify%22+OR+%22identifies%22+OR+%22identifying%22+++++%29+AND+%28+++++%22vulnerability%22+OR+%22vulnerabilities%22+++++OR+%22weakness%22+OR+%22weaknesses%22+++++OR+%22bug%22+OR+%22bugs%22+++++OR+%22security+risk%22+OR+%22security+risks%22+++++OR+%22security+issue%22+OR+%22security+issues%22+++++OR+%22insecurity%22+OR+%22insecurities%22++++++%29%29&origin=resultslist&editSaveSearch=&yearFrom=Before+1960&yearTo=Present&sessionSearchId=8c71bb9ca4aab8ac677a5d1abecdea3d&limit=200)
~~- [ ] Base: [2209](https://www.base-search.net/Search/Results?type=all&lookfor=%28+%22Ethereum%22+OR+%22smart+contract%22+OR+%22smart+contracts%22+%29+AND+%28+%22tool%22+OR+%22tools%22+OR+%22automated%22+OR+%22automatic%22+OR+%22automatically%22+OR+%22detect%22+OR+%22detecting%22+OR+%22detected%22+OR+%22detection%22+OR+%22detector%22+OR+%22analysis%22+OR+%22analysing%22+OR+%22analyzed%22+OR+%22analysed%22+OR+%22analyser%22+OR+%22analyzer%22+OR+%22identify%22+OR+%22identifies%22+OR+%22identifying%22+%29+AND+%28+%22vulnerability%22+OR+%22vulnerabilities%22+OR+%22weakness%22+OR+%22weaknesses%22+OR+%22bug%22+OR+%22bugs%22+OR+%22security+risk%22+OR+%22security+risks%22+OR+%22security+issue%22+OR+%22security+issues%22+OR+%22insecurity%22+OR+%22insecurities%22+%29&ling=1&oaboost=1&name=&thes=&refid=dcresen&newsearch=1)~~ (too much)

Domains: Ethereum & Vulnerability
- [ ] Google Scholar: [159](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=allintitle%3A+%28%22Ethereum%22+OR+%22smart+contract%22+OR+%22smart+contracts%22%29+AND+%28+++++%22vulnerability%22+OR+%22vulnerabilities%22+++++OR+%22weakness%22+OR+%22weaknesses%22+++++OR+%22bug%22+OR+%22bugs%22+++++OR+%22security+risk%22+OR+%22security+risks%22+++++OR+%22security+issue%22+OR+%22security+issues%22+++++OR+%22insecurity%22+OR+%22insecurities%22++++++%29&btnG=) - allintitle

Domains: Ethereum & Frontrunning & Automated Detection & Vulnerability
- [ ] Google Scholar: [2790](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=allintext%3A+%28%22Ethereum%22+OR+%22smart+contract%22+OR+%22smart+contracts%22%29+AND+%28+++++%22frontrunning%22+OR+%22front-running%22+OR+%22front+running%22+++++OR+%22TOD%22+OR+%22Transaction+Order+Dependence%22+OR+%22Transaction+Order+Dependency%22+++++OR+%22Race+condition%22%29++AND+%28+++++%22tool%22+OR+%22tools%22+++++OR+%22automated%22+OR+%22automatic%22+OR+%22automatically%22+++++OR+%22detect%22+OR+%22detecting%22+OR+%22detected%22+OR+%22detection%22+OR+%22detector%22+++++OR+%22analysis%22+OR+%22analysing%22+OR+%22analyzed%22+OR+%22analysed%22+OR+%22analyser%22+OR+%22analyzer%22+++++OR+%22identify%22+OR+%22identifies%22+OR+%22identifying%22%29+AND+%28+++++%22vulnerability%22+OR+%22vulnerabilities%22+++++OR+%22weakness%22+OR+%22weaknesses%22+++++OR+%22bug%22+OR+%22bugs%22+++++OR+%22security+risk%22+OR+%22security+risks%22+++++OR+%22security+issue%22+OR+%22security+issues%22+++++OR+%22insecurity%22+OR+%22insecurities%22%29&btnG=) - allintext

#### Reasons

Fulltext?
Too many results?
Further limitations?

ACM, IEEE Xplore and ScienceDirect: fulltext allows to search for frontrunning. Any tool or survey that covers this will include it somewhere in its text, thus searching for (Ethereum & Frontrunning) should cover all tools.

Scopus: no full text -> tools that cover multiple vulnerabilities may not mention the frontrunning domain in the abstract. However, it is likely they mention the other domains.

Base: too many results, dunno how I should properly filter it

Google Scholar:
- Ethereum & Vulnerability: should cover many surveys
- all domains: too many results, thus limit to the first 200

## Criteria

### Tools

- it detects frontrunning/TOD weaknesses, no matter its definition
- tool is freely available (source code or executable)
- usage documentation exists (is sufficient)
- automated process without manual interaction

### Surveys

- it covers tools that detect frontrunning/TOD weaknesses

### Datasets

- it covers >5 example contracts for TOD/frontrunning

## Tools

## Tools Reviews
Similar to "Ethereum smart contract analysis tools: A systematic review"


# Utils

## Google Export

```
const sleep = ms => new Promise(resolve => setTimeout(resolve, ms))
async function saveAll() {
  for (let el of document.querySelectorAll('.gs_or_sav.gs_or_btn')) {
    el.click()
    await sleep(500)
    document.querySelector('.gs_btn_act.gs_btn_lrge').click()
    await sleep(500)
  }
}
await saveAll()
```

```
let sleep = ms => new Promise(resolve => setTimeout(resolve, ms))
async function deleteAll() {
  for (let el of document.querySelectorAll('.gs_or_del.gs_or_btn') ) {
    el.click()
    await sleep(500)
  }
}
await deleteAll()
```