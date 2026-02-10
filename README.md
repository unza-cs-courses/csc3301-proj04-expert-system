# Project 4: Expert System

**CSC3301 Programming Language Paradigms**
**Weight:** 5.5% | **Language:** Prolog

## Overview

Build an expert system in Prolog for a domain assigned based on your student ID. Your system will encode domain knowledge as facts and rules, answer queries through logical inference, and explain its reasoning.

## Environment Setup

### Installing SWI-Prolog

#### macOS
```bash
brew install swi-prolog
```

#### Ubuntu/Debian
```bash
sudo apt install swi-prolog
```

#### Windows
Download the installer from [swi-prolog.org](https://www.swi-prolog.org/download/stable) and follow the installation wizard.

### Verify Installation

```bash
swipl --version
```

You should see output like: `SWI-Prolog version 9.x.x`

### Running Tests

Run all visible tests:
```bash
swipl -g "consult('tests/visible/test_expert.pl'), run_tests" -t halt
```

### Interactive Development

Start the SWI-Prolog interactive shell:
```bash
swipl
```

Then load your modules:
```prolog
?- consult('src/knowledge_base.pl').
?- consult('src/rules.pl').
?- consult('src/consultation.pl').
```

### Debugging Tips

#### Enable Tracing
Step through your predicates to understand execution flow:
```prolog
?- trace.
?- your_query(X, Y).
?- notrace.
```

The tracer shows:
- `Call:` when a predicate is invoked
- `Exit:` when it succeeds
- `Redo:` when backtracking occurs
- `Fail:` when it fails

#### List Predicate Definitions
View all clauses of a predicate:
```prolog
?- listing(diagnose/2).
?- listing(symptom/2).
```

#### Common Prolog Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `Undefined procedure` | Predicate not defined or wrong arity | Check predicate name and number of arguments |
| `Instantiation error` | Variable should be instantiated | Ensure variables are bound before use |
| `Syntax error` | Typo or missing punctuation | Check parentheses, periods, and commas |
| `False` | Query fails | Use `trace` to debug the execution path |
| `Infinite loop` | Infinite recursion without base case | Add a base case or cut (`!`) to prevent backtracking |

## Variant System

This assignment uses an automated variant system to give each student a unique domain. When you accept the assignment through GitHub Classroom:

1. A GitHub Action automatically runs to generate your personalized variant
2. Your unique domain and requirements are saved to `.variant_config.json`
3. A personalized `ASSIGNMENT.md` is created with your specific requirements

**Check your assigned domain:** See `ASSIGNMENT.md` after the variant is generated, or run:
```bash
python scripts/variant_generator.py your_github_username
```

## Domains (Variant-Based)

Each student is assigned ONE of the following domains:

| Domain | Main Predicate | Description |
|--------|---------------|-------------|
| Medical Diagnosis | `diagnose/2` | Diagnose illnesses based on symptoms |
| Career Advisor | `recommend_career/2` | Recommend careers based on skills/interests |
| Plant Identifier | `identify_plant/2` | Identify plants based on characteristics |
| Recipe Suggester | `suggest_recipe/2` | Suggest recipes based on ingredients |
| Tech Support | `diagnose_problem/2` | Diagnose computer problems |
| Animal Classifier | `classify_animal/2` | Classify animals based on traits |

## Requirements

Your personalized requirements are in `ASSIGNMENT.md`. General requirements include:

1. Knowledge base with domain-specific facts
2. Inference rules for logical deduction
3. Main query predicate for your domain
4. `explain/2` predicate showing reasoning chain
5. Recursive predicates demonstrating Prolog's power
6. Interactive consultation mode

## File Structure

```
.
├── .github/
│   └── workflows/
│       ├── autograding.yml      # Runs tests on push
│       └── generate-variant.yml  # Generates student variant
├── .variant_config.json          # Your variant configuration (auto-generated)
├── ASSIGNMENT.md                 # Your personalized assignment (auto-generated)
├── ASSIGNMENT_TEMPLATE.md        # Template for assignment generation
├── README.md                     # This file
├── scripts/
│   ├── generate_variant.pl       # Prolog variant generator
│   ├── variant_generator.py      # Python variant generator
│   └── generate_assignment.py    # Assignment generator
├── src/
│   ├── knowledge_base.pl         # Your facts go here
│   ├── rules.pl                  # Your inference rules
│   └── consultation.pl           # Interactive consultation
└── tests/
    └── visible/
        └── test_expert.pl        # Visible tests
```

## Milestones

| Milestone | Deliverable | Weight |
|-----------|-------------|--------|
| M1 | Knowledge Base (20+ facts, 10+ rules) | 30% |
| M2 | Main query predicate working | 35% |
| M3 | Explanation + consultation | 20% |
| Final | Complete with tests | 15% |

## Running Tests

```bash
# Run visible tests
swipl -g "consult('tests/visible/test_expert.pl'), run_tests" -t halt

# Load your system interactively
swipl
?- consult('src/knowledge_base').
?- consult('src/rules').
?- consult('src/consultation').
```

## Example (Medical Domain)

```prolog
% Facts
symptom(patient1, fever).
symptom(patient1, cough).
symptom(patient1, fatigue).

% Rule
diagnose(Patient, flu) :-
    symptom(Patient, fever),
    symptom(Patient, cough),
    symptom(Patient, fatigue).

% Query
?- diagnose(patient1, Disease).
Disease = flu.

?- explain(diagnose(patient1, flu), Explanation).
Explanation = ['Symptoms: fever, cough, fatigue', 'Matched flu criteria'].
```

## Getting Started

1. **Wait for variant generation** - After accepting the assignment, wait for the GitHub Action to complete
2. **Read ASSIGNMENT.md** - Your personalized requirements and examples
3. **Start with facts** - Build your knowledge base in `src/knowledge_base.pl`
4. **Add rules** - Implement inference rules in `src/rules.pl`
5. **Test incrementally** - Run tests after each addition
6. **Add explanation** - Implement `explain/2` predicate
7. **Create consultation** - Build interactive mode in `src/consultation.pl`

## Debugging Tips

```prolog
% Enable trace to see rule execution
?- trace.
?- your_query.

% Disable trace
?- nodebug.

% List all facts for a predicate
?- listing(your_predicate).
```

## Academic Integrity

- Discuss concepts with classmates - OK
- Use Prolog documentation - OK
- Share or copy code - NOT OK
- Use AI tools to generate solutions - NOT OK

Your submission will be checked for similarity with other students.
