% Knowledge Base — CSC3301 Project 4: Expert System
% ================================================
%
% This file contains the facts for your expert system.
% Your domain will be specified in your ASSIGNMENT.md after
% variant generation.
%
% Requirements:
%   - Minimum 30 facts
%   - Well-organized and documented
%   - Use meaningful predicate and constant names
%
% TODO: Replace these placeholder facts with your domain-specific facts.
% See your ASSIGNMENT.md for your assigned domain and requirements.

% --- Placeholder facts (replace with your domain) ---
% Example fact format:
%   predicate(arg1, arg2).
%   property(entity, value).
%   relationship(entity1, entity2).

% ============================================================
% FACT AND RULE INTERFACE PREDICATES
% ============================================================

% fact(F)
%
% PURPOSE: Query predicate to retrieve all facts from the knowledge base
% INPUT: F - variable or specific fact term
% OUTPUT: unifies with each fact in the knowledge base
%
% IMPLEMENTATION NOTES:
%   - This is a meta-predicate for querying the knowledge base
%   - Can be used by the inference engine to enumerate facts
%   - Should succeed for all ground facts in this file
%
% TODO: Define facts in the knowledge base below.
%       Each fact should be of the form: fact_name(arg1, arg2, ...).
%
% EXAMPLE:
%   fact(human(socrates)).
%   fact(human(plato)).
%   fact(mortal_species(human)).

% fact/1 - Returns all facts (defined by consulting knowledge base)
% Uses current_predicate/1 to safely enumerate predicates before
% calling clause/2, which requires a sufficiently instantiated head.
fact(F) :-
    current_predicate(Name/Arity),
    functor(F, Name, Arity),
    \+ system_predicate(F),
    catch(clause(F, true), _, fail).

% Helper: check if predicate is a system predicate
system_predicate(F) :- functor(F, Name, _), atom_codes(Name, [C|_]), C == 0'$.

% ============================================================
% ADD YOUR DOMAIN FACTS BELOW
% ============================================================
