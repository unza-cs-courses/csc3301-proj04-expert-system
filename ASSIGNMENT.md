# Project 4: Expert System

**CSC3301 Programming Language Paradigms**
**Student ID:** system
**Weight:** 5.5% | **Language:** Prolog

---

## Your Unique Assignment

This assignment has been personalized for you based on your student ID.

### Your Domain: Recipe Suggester

**Description:** Build an expert system that suggests recipes based on available ingredients

| Requirement | Your Value |
|-------------|------------|
| Main Predicate | `suggest_recipe/2` |
| Minimum Facts | 30 |
| Minimum Rules | 15 |
| Minimum Recursive Predicates | 5 |

**Important:** Your code must implement the exact main predicate and meet the minimum requirements to pass the tests.

---

## Overview

Build an expert system in Prolog for your assigned domain. Your system will encode domain knowledge as facts and rules, answer queries through logical inference, and explain its reasoning.

---

## Requirements

### 1. Knowledge Base (`src/knowledge_base.pl`)
- At least **30 facts** representing domain knowledge
- Facts should be well-organized and documented
- Use meaningful predicate and constant names

### 2. Inference Rules (`src/rules.pl`)
- At least **15 rules** for logical inference
- At least **5 recursive predicates**
- Main query predicate: `suggest_recipe/2`

### 3. Explanation System
- Implement `explain/2` predicate showing reasoning chain
- Should explain WHY a conclusion was reached
- Return explanation as a list of reasoning steps

### 4. Interactive Consultation (`src/consultation.pl`)
- Interactive mode for querying the expert system
- User-friendly prompts and responses
- Handle invalid inputs gracefully

---

## Example for Your Domain

**Sample facts:**
```prolog
has_ingredient(kitchen1, eggs)
has_ingredient(kitchen1, flour)
has_ingredient(kitchen1, milk)
```

**Sample rule:**
```prolog
suggest_recipe(Kitchen, pancakes) :- has_ingredient(Kitchen, eggs), has_ingredient(Kitchen, flour), has_ingredient(Kitchen, milk)
```

**Example query:**
```prolog
?- suggest_recipe(kitchen1, Recipe).
Recipe = pancakes.
```

**Example explanation:**
```prolog
?- explain(your_query, Explanation).
Explanation = ['Step 1: ...', 'Step 2: ...', 'Conclusion: ...'].
```

---

## Milestones

| Milestone | Deliverable | Weight |
|-----------|-------------|--------|
| M1 | Knowledge Base (20+ facts, 10+ rules) | 30% |
| M2 | Main query predicate working | 35% |
| M3 | Explanation + consultation mode | 20% |
| Final | Complete system with tests | 15% |

---

## Running Tests

```bash
# Run visible tests
swipl -g "consult('tests/visible/test_expert.pl'), run_tests" -t halt

# Load and test your system interactively
swipl
?- consult('src/knowledge_base').
?- consult('src/rules').
?- consult('src/consultation').
```

---

## File Structure

```
src/
  knowledge_base.pl   # Your facts go here
  rules.pl            # Your inference rules
  consultation.pl     # Interactive consultation mode
tests/
  visible/            # Tests you can see and run
    test_expert.pl
scripts/
  generate_variant.pl # Original variant generator (Prolog)
  variant_generator.py # Variant generator (Python)
```

---

## Submission

1. Complete all source files in `src/`
2. Ensure visible tests pass
3. Push your changes to trigger autograding
4. **Note:** Hidden tests will run after the deadline

---

## Grading Breakdown

| Component | Points | Type |
|-----------|--------|------|
| Visible Tests | 40 | Automatic |
| Hidden Tests | 30 | After deadline |
| Code Quality | 20 | Manual review |
| Plagiarism Check | -10 | Penalty if flagged |
| **Total** | 100 | |

---

## Tips for Success

1. **Start with facts:** Build your knowledge base first
2. **Test incrementally:** Test each rule as you add it
3. **Use trace:** `?- trace.` helps debug rule execution
4. **Document:** Add comments explaining your predicates
5. **Think declaratively:** Describe WHAT, not HOW

---

## Academic Integrity

- Discuss concepts with classmates - OK
- Use Prolog documentation - OK
- Share or copy code - NOT OK
- Use AI tools to generate solutions - NOT OK

Your submission will be checked for similarity with other students.
