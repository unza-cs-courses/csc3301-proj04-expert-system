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
    % Verify that at least some student-defined facts exist
    findall(F, (
        clause(F, true),
        \+ infrastructure_predicate(F),
        \+ system_predicate(F)
    ), Facts),
    length(Facts, Count),
    Count > 0.

test(minimum_fact_count, [nondet]) :-
    % Check minimum facts requirement (at least 20 base facts)
    % Counts unit clauses (facts) excluding infrastructure predicates
    aggregate_all(count, (
        clause(F, true),
        \+ infrastructure_predicate(F),
        \+ system_predicate(F)
    ), FactCount),
    FactCount >= 20.

:- end_tests(knowledge_base).

:- begin_tests(rules).

test(has_rules, [nondet]) :-
    % Verify that student-defined rules exist (clauses with non-trivial bodies)
    % Excludes template infrastructure and stub predicates (body = fail)
    findall(H, (
        clause(H, B),
        B \== true,
        B \== fail,
        \+ system_predicate(H),
        \+ infrastructure_predicate(H)
    ), Rules),
    length(Rules, Count),
    Count > 0.

test(minimum_rule_count, [nondet]) :-
    % Check minimum rules requirement (at least 10 rules)
    % Excludes template infrastructure and stub predicates (body = fail)
    aggregate_all(count, (
        clause(H, B),
        B \== true,
        B \== fail,
        \+ system_predicate(H),
        \+ infrastructure_predicate(H)
    ), RuleCount),
    RuleCount >= 10.

:- end_tests(rules).

:- begin_tests(explain_predicate).

test(explain_exists, [nondet]) :-
    % Verify explain/2 predicate is defined and can produce a result
    current_predicate(explain/2),
    explain(_, Explanation),
    is_list(Explanation).

test(explain_returns_list, [nondet]) :-
    % Verify explain/2 returns a list for some query
    % This test is flexible - student just needs to have explain/2 working
    current_predicate(explain/2),
    explain(_, Explanation),
    is_list(Explanation),
    length(Explanation, Len),
    Len > 0.

:- end_tests(explain_predicate).

:- begin_tests(consultation).

test(consultation_mode_exists, [nondet]) :-
    % Verify interactive consultation predicate exists and process_input/1
    % has been implemented beyond the template stub (template stub body is
    % just writeln('Processing...'), so it should have multiple clauses or
    % a body that references the knowledge base / inference engine).
    (current_predicate(consult_user/0) ;
     current_predicate(start_consultation/0) ;
     current_predicate(interactive/0)),
    current_predicate(process_input/1),
    predicate_property(process_input/1, number_of_clauses(N)),
    N > 1.

:- end_tests(consultation).

:- begin_tests(recursion).

test(has_recursive_predicate, [nondet]) :-
    % Check that at least one student-defined recursive predicate exists
    % (excludes template-provided predicates like consultation_loop)
    clause(Head, Body),
    functor(Head, Name, Arity),
    \+ template_predicate(Name),
    contains_call(Body, Name, Arity).

% Template-provided predicates that are already recursive
template_predicate(consultation_loop).
template_predicate(start_consultation).
template_predicate(process_input).
template_predicate(contains_call).
template_predicate(is_rule_head).
template_predicate(system_predicate).
template_predicate(fact).
template_predicate(rule).

:- end_tests(recursion).

% Helper predicates for testing

% Template infrastructure predicates — these are provided in the template
% and should not count as student-defined rules or facts
infrastructure_predicate(H) :- functor(H, fact, 1).
infrastructure_predicate(H) :- functor(H, rule, 2).
infrastructure_predicate(H) :- functor(H, system_predicate, 1).
infrastructure_predicate(H) :- functor(H, can_derive, 1).
infrastructure_predicate(H) :- functor(H, forward_chain, 1).
infrastructure_predicate(H) :- functor(H, backward_chain, 2).
infrastructure_predicate(H) :- functor(H, explain, 2).
infrastructure_predicate(H) :- functor(H, test_hypothesis, 1).
infrastructure_predicate(H) :- functor(H, modus_ponens, 3).
infrastructure_predicate(H) :- functor(H, transitive, 3).
infrastructure_predicate(H) :- functor(H, certainty, 2).
infrastructure_predicate(H) :- functor(H, bayesian_update, 3).
infrastructure_predicate(H) :- functor(H, start_consultation, 0).
infrastructure_predicate(H) :- functor(H, consultation_loop, 0).
infrastructure_predicate(H) :- functor(H, process_input, 1).
% Test-file helper predicates (loaded into same environment)
infrastructure_predicate(H) :- functor(H, infrastructure_predicate, 1).
infrastructure_predicate(H) :- functor(H, contains_call, 3).
infrastructure_predicate(H) :- functor(H, is_rule_head, 1).
infrastructure_predicate(H) :- functor(H, template_predicate, 1).

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
