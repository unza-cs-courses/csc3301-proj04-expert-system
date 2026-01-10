% Visible Tests for Expert System Project
% CSC3301 Programming Language Paradigms
%
% These tests verify basic structure and functionality of your expert system.
% Hidden tests will verify domain-specific correctness after the deadline.

:- use_module(library(plunit)).

% Load the student's code
:- consult('../../src/knowledge_base').
:- consult('../../src/rules').
:- consult('../../src/consultation').

:- begin_tests(knowledge_base).

test(has_facts, [nondet]) :-
    % Verify that at least some facts exist
    findall(F, clause(F, true), Facts),
    length(Facts, Count),
    Count > 0.

test(minimum_fact_count, [nondet]) :-
    % Check minimum facts requirement (at least 20 base facts)
    aggregate_all(count, (clause(_, true), \+ is_rule_head(_)), FactCount),
    FactCount >= 20.

:- end_tests(knowledge_base).

:- begin_tests(rules).

test(has_rules, [nondet]) :-
    % Verify that rules exist (clauses with bodies)
    findall(H, (clause(H, B), B \== true), Rules),
    length(Rules, Count),
    Count > 0.

test(minimum_rule_count, [nondet]) :-
    % Check minimum rules requirement (at least 10 rules)
    aggregate_all(count, (clause(H, B), B \== true, \+ system_predicate(H)), RuleCount),
    RuleCount >= 10.

:- end_tests(rules).

:- begin_tests(explain_predicate).

test(explain_exists, [nondet]) :-
    % Verify explain/2 predicate is defined
    current_predicate(explain/2).

test(explain_returns_list, [nondet]) :-
    % Verify explain/2 returns a list for some query
    % This test is flexible - student just needs to have explain/2 working
    catch(
        (explain(_, Explanation), is_list(Explanation)),
        _,
        fail
    ).

:- end_tests(explain_predicate).

:- begin_tests(consultation).

test(consultation_mode_exists, [nondet]) :-
    % Verify interactive consultation predicate exists
    (current_predicate(consult_user/0) ;
     current_predicate(start_consultation/0) ;
     current_predicate(interactive/0)).

:- end_tests(consultation).

:- begin_tests(recursion).

test(has_recursive_predicate, [nondet]) :-
    % Check that at least one recursive predicate exists
    % A predicate is recursive if it calls itself
    clause(Head, Body),
    functor(Head, Name, Arity),
    contains_call(Body, Name, Arity).

:- end_tests(recursion).

% Helper predicates for testing

% Check if a term contains a call to a specific predicate
contains_call(Term, Name, Arity) :-
    nonvar(Term),
    functor(Term, Name, Arity), !.
contains_call(Term, Name, Arity) :-
    nonvar(Term),
    Term =.. [_|Args],
    member(Arg, Args),
    contains_call(Arg, Name, Arity).
contains_call((A, B), Name, Arity) :-
    (contains_call(A, Name, Arity) ; contains_call(B, Name, Arity)).
contains_call((A ; B), Name, Arity) :-
    (contains_call(A, Name, Arity) ; contains_call(B, Name, Arity)).

% Check if a head is a rule head (not a fact)
is_rule_head(H) :-
    clause(H, B),
    B \== true.

% Check if predicate is a system predicate
system_predicate(H) :-
    functor(H, Name, _),
    atom_codes(Name, [C|_]),
    C == 0'$.
