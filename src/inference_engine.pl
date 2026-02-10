% Inference Engine — CSC3301 Project 4: Expert System
% ====================================================
%
% This file contains the core inference engine for your expert system.
% Implement domain-agnostic inference mechanisms that work with any domain.
%
% The inference engine should:
%   - Support forward chaining (data-driven inference)
%   - Support backward chaining (goal-driven inference)
%   - Track proof chains for explanation
%   - Implement logical inference patterns
%   - Test hypotheses and derive conclusions
%
% Load the knowledge base and rules
:- consult('knowledge_base.pl').
:- consult('rules.pl').

% ============================================================
% CORE INFERENCE PREDICATES
% ============================================================

% can_derive(Conclusion)
%
% PURPOSE: Derive a conclusion from the knowledge base and rules
% INPUT: Conclusion - a term to be derived
% OUTPUT: succeeds if Conclusion can be proven from facts and rules
%
% IMPLEMENTATION NOTES:
%   - Should attempt to prove the Conclusion using available facts
%   - Should apply inference rules to derive new facts
%   - Should handle backtracking for multiple solutions
%
% TODO: Implement can_derive/1
%       Use forward chaining or backward chaining to derive conclusions
can_derive(_) :- fail.


% forward_chain(Results)
%
% PURPOSE: Perform forward chaining inference
% INPUT: (none - uses knowledge base as input)
% OUTPUT: Results - list of all facts that can be derived
%
% IMPLEMENTATION NOTES:
%   - Start with all known facts
%   - Apply rules repeatedly to derive new facts
%   - Stop when no new facts can be derived
%   - Return complete list of derived facts
%
% TODO: Implement forward_chain/1
%       Iteratively apply rules until fixed point is reached
forward_chain(_) :- fail.


% backward_chain(Goal, Proof)
%
% PURPOSE: Perform backward chaining inference with proof trace
% INPUT: Goal - the goal to prove
% OUTPUT: Proof - list showing proof steps (can be nested)
%
% IMPLEMENTATION NOTES:
%   - Start with the goal to prove
%   - Find rules or facts that match the goal
%   - Recursively prove subgoals
%   - Build proof structure showing reasoning chain
%   - Format: goal(GoalTerm, SubProofs) or fact(FactTerm)
%
% TODO: Implement backward_chain/2
%       Recursively build proof tree from goal to facts
backward_chain(_, _) :- fail.


% explain(Goal, Explanation)
%
% PURPOSE: Explain how a conclusion was derived
% INPUT: Goal - the goal that was proven
% OUTPUT: Explanation - list of explanation strings
%
% IMPLEMENTATION NOTES:
%   - Use backward_chain/2 to get proof structure
%   - Convert proof structure to human-readable explanation
%   - Format as list of strings showing reasoning steps
%   - Example: ['fact: human(socrates)', 'rule: mortal(X) :- human(X)', 'conclusion: mortal(socrates)']
%
% TODO: Implement explain/2
%       Convert proof structure to natural language explanation
explain(_, _) :- fail.


% test_hypothesis(Hypothesis)
%
% PURPOSE: Test whether a hypothesis can be proven true
% INPUT: Hypothesis - a term to test
% OUTPUT: succeeds if hypothesis can be proven, fails otherwise
%
% IMPLEMENTATION NOTES:
%   - Use backward chaining to attempt to prove the hypothesis
%   - Return failure if proof is not found
%   - Can be used for hypothesis testing and diagnostic reasoning
%
% TODO: Implement test_hypothesis/1
%       Attempt to prove the given hypothesis
test_hypothesis(_) :- fail.


% ============================================================
% LOGICAL INFERENCE PATTERNS
% ============================================================

% modus_ponens(P, PImpliesQ, Q)
%
% PURPOSE: Implement logical inference pattern: modus ponens
%          If P is true, and P implies Q, then Q is true
% INPUT: P - antecedent fact
%        PImpliesQ - rule of form (P :- ..., ..., Q, ...)
% OUTPUT: Q - derived consequent
%
% IMPLEMENTATION NOTES:
%   - P is a fact that has been established
%   - PImpliesQ is a rule where P appears in the body
%   - Q is the head of the rule (the conclusion)
%   - Basic pattern: if premise is proven, conclude consequent
%
% TODO: Implement modus_ponens/3
%       Match P against rule body, extract Q from rule head
modus_ponens(_, _, _) :- fail.


% transitive(A, B, C)
%
% PURPOSE: Implement transitive reasoning
%          If A relates to B, and B relates to C, then A relates to C
% INPUT: A, B, C - entities/values
% OUTPUT: succeeds if transitive relationship holds
%
% IMPLEMENTATION NOTES:
%   - Look for relations like: relation(A, B) and relation(B, C)
%   - Derive: relation(A, C)
%   - Common relations: ancestor, greater_than, etc.
%   - May need to search for applicable transitive relations
%
% TODO: Implement transitive/3
%       Find transitive closure of relations
transitive(_, _, _) :- fail.


% ============================================================
% OPTIONAL ADVANCED REASONING PATTERNS
% ============================================================

% certainty(Proposition, CertaintyFactor)
%
% PURPOSE: Associate certainty factors with propositions
% INPUT: Proposition - a term
%        CertaintyFactor - number between 0.0 and 1.0
% OUTPUT: succeeds with certainty factor
%
% IMPLEMENTATION NOTES:
%   - Used for reasoning under uncertainty
%   - Combine certainty factors when applying rules
%   - CF(A and B) = CF(A) * CF(B)
%   - CF(A or B) = CF(A) + CF(B) - CF(A) * CF(B)
%   - Optional: not required for basic expert systems
%
% TODO (OPTIONAL): Implement certainty/2
%       Track certainty factors for derived conclusions
certainty(_, _) :- fail.


% bayesian_update(Hypothesis, Evidence, UpdatedProbability)
%
% PURPOSE: Update probability of hypothesis given evidence
% INPUT: Hypothesis - the proposition to update
%        Evidence - observation that affects probability
% OUTPUT: UpdatedProbability - posterior probability
%
% IMPLEMENTATION NOTES:
%   - Use Bayes' theorem: P(H|E) = P(E|H) * P(H) / P(E)
%   - Requires prior probabilities and likelihoods
%   - Useful for diagnostic and medical expert systems
%   - Optional: not required for basic expert systems
%
% TODO (OPTIONAL): Implement bayesian_update/3
%       Apply Bayesian reasoning for probabilistic inference
bayesian_update(_, _, _) :- fail.
