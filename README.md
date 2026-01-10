# Project 4: Expert System

**CSC3301 Programming Language Paradigms**  
**Weight:** 5.5% | **Language:** Prolog

## Overview
Build an expert system in Prolog for a domain assigned based on your student ID. Your system will encode domain knowledge as facts and rules, answer queries through logical inference, and explain its reasoning.

## Domains (Variant-Based)
- Medical Diagnosis
- Career Advisor
- Plant Identifier
- Recipe Suggester
- Tech Support
- Animal Classifier

Run `swipl scripts/show_variant.pl` to see your assigned domain.

## Requirements
1. ≥30 facts representing domain knowledge
2. ≥15 rules for inference
3. Main query predicate for your domain
4. `explain/2` predicate showing reasoning chain
5. At least 3 recursive predicates
6. Interactive consultation mode

## Milestones
| M1 | Knowledge Base (20+ facts, 10+ rules) | 30% |
| M2 | Main query predicate working | 35% |
| M3 | Explanation + consultation | 20% |
| Final | Complete with tests | 15% |

## Example (Medical Domain)
```prolog
?- diagnose(patient1, Disease).
Disease = flu.

?- explain(diagnose(patient1, flu), Explanation).
Explanation = ['Symptoms: fever, cough', 'Matched flu criteria'].
```
