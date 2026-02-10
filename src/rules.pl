% Inference Rules — CSC3301 Project 4: Expert System
% ==================================================
%
% This file contains the inference rules for your expert system.
% Your main predicate is specified in your ASSIGNMENT.md.
%
% Requirements:
%   - Minimum 15 rules
%   - At least 5 recursive predicates
%   - Implement your main query predicate (see ASSIGNMENT.md)
%
% Load the knowledge base
:- consult('knowledge_base.pl').

% Load the inference engine
:- consult('inference_engine.pl').

% TODO: Implement your inference rules below.
% See ASSIGNMENT.md for your assigned main predicate.

% Example rule structure:
% main_predicate(Input, Output) :-
%     condition1(Input, Intermediate),
%     condition2(Intermediate, Output).

% --- Recursive predicate example ---
% ancestor(X, Y) :- parent(X, Y).
% ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% ============================================================
% RULE INTERFACE PREDICATES
% ============================================================

% rule(R, Body)
%
% PURPOSE: Query predicate to retrieve inference rules
% INPUT: R - rule head (conclusion)
%        Body - rule body (conditions)
% OUTPUT: unifies with each rule in the knowledge base
%
% IMPLEMENTATION NOTES:
%   - This is a meta-predicate for querying rules
%   - Returns rule head and body for inspection
%   - Used by inference engine to apply rules
%   - Format: rule(head, body)
%
% TODO: Define inference rules below.
%       Each rule should be of the form:
%         conclusion(X) :- condition1(X), condition2(X).

% rule/2 - Returns all rules (clauses with non-trivial bodies)
rule(H, B) :- clause(H, B), B \== true, \+ system_predicate(H).

% Helper: check if predicate is a system predicate
system_predicate(H) :- functor(H, Name, _), atom_codes(Name, [C|_]), C == 0'$.

% ============================================================
% EXPLANATION PREDICATE (REQUIRED)
% ============================================================

% explain(Query, Explanation)
%
% PURPOSE: Explain how a query conclusion was derived
% INPUT: Query - the goal that was proven
% OUTPUT: Explanation - list of explanation strings describing reasoning chain
%
% IMPLEMENTATION NOTES:
%   - Should build a human-readable explanation
%   - Format as list of strings or atoms
%   - Example output: [
%       'Given: human(socrates)',
%       'Rule: mortal(X) :- human(X)',
%       'Therefore: mortal(socrates)'
%     ]
%   - See inference_engine.pl for explain/2 stub
%
% TODO: Build explanation list showing reasoning chain.
%       Use backward_chain/2 from inference_engine to trace proof
%       Convert proof structure to natural language explanation
