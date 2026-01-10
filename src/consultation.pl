% Interactive consultation mode
:- consult('rules.pl').

start_consultation :-
    writeln('Welcome to the Expert System'),
    writeln('Enter symptoms or type "quit" to exit.'),
    consultation_loop.

consultation_loop :-
    write('> '),
    read(Input),
    (Input == quit -> writeln('Goodbye!')
    ; process_input(Input), consultation_loop).

process_input(Input) :-
    % YOUR CODE: Process user input and provide responses
    writeln('Processing...').
