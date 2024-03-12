Meeting Notes:
- Alternative Idee für die frontrunning Definition: schauen ob unterschiedliche Transaktionsreihenfolgen die contract calls beeinflussen
- Zusätzlich zu minimal vulnerable contracts auch minimal secure contracts:
	- Beispiele zu Verteidigungen gegen frontrunning auf contract Ebene recherchieren und contracts dafür schreiben
	- Contracts durchgehen die von Tools als vulnerable klassifiziert werden, aber (nach manueller Prüfung) nicht vulnerable sind. Diese contracts vereinfachen (minimal reproducible example)
- Recherche: Vorhgensweise + Zeitpunkt, Suchqueries dokumentieren:
	- Vgl. https://www.frontiersin.org/files/Articles/814977/fbloc-05-814977-HTML/image_m/fbloc-05-814977-t001.jpg
	- research zu detection tools: welche Herangehensweisen
- Analyse der ausgeführten opcodes (replays):
	- erigon: eventuell mit snapshots starten und weiter ausführen.
	- etherscan: anschauen ob man geth traces via API abfragen kann (Anmerkung nach meeting: Damit können wir nur die Angriffs-Reihenfolge anschauen. Das reicht zB zum Labeln von Hashfunktionen, aber nicht zur Analyse ob die Tx-Reihenfolge  Hash Funktionen aufgerufen wurden. Aber man kann )
- Testen von minimal vulnerable contracts: Eventuell mit Foundry


Frontrunning definition (informal, similar to Zhang et al.): For a frontrunning attack, $T_A \rightarrow T_V$ is different from $T_V \rightarrow T_A$ , in a way that the victim loses ether/tokens and the attacker gains ether/tokens. 


Next steps:
1. Define contract labels, that could impact performance of detection tools. For this, look through attacked contracts, approaches of detection tools, other papers.
	1. clear definition
	2. rationale, why it could be important
	3. if applicable, how they could be automatically applied
	4. create minimal vulnerable contracts with this label, as examples for these labels
2. (write unit tests for them, showing that these are indeed vulnerable)
3. (apply labels to attacked contracts from Zhang et al. benchmark)
	1. apply automatic labels
	2. verify automatic labelling (take samples? With only ~100 contracts the sample is nearly all contracts for statistical significance)
	3. apply manual labels where necessary
