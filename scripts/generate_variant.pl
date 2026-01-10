% Generate variant based on student ID
:- use_module(library(random)).

domains([medical, career, plants, recipes, tech_support, animals]).

generate_variant(StudentID) :-
    atom_codes(StudentID, Codes),
    sum_list(Codes, Sum),
    domains(Domains),
    length(Domains, Len),
    Index is Sum mod Len,
    nth0(Index, Domains, Domain),
    format('Your domain: ~w~n', [Domain]),
    format('Main predicate: ~w~n', [Domain]).
