-module(granolam).
-vsn('2002.0314').  % This work is a part of the public domain.

-compile([nowarn_unused_vars]).

-export([parse/1, interpret/1, run/1, test/1, shell/0, main/1]).

-define(g0(X),X++S)->" "++X++" "++sub(S).
-define(g1(X),X|R0])->{Q,R1}=).
-define(g2(X),{S0,X}=pop(C,S)).
-define(g3(X),S0=push(C,S,X)).
-define(g9,++K->S0=push(C,S).
-define(y,S,C,CS).
-define(t,C,CS,M).
-define(t0,L,P,S0).
-define(l(X),list_to_atom(X)).

%% Parser --------------------------------------------------------------

sub(?g0("("));sub(?g0(")"));sub(?g0("^"));sub(?g0("="));
sub([C|S])->[C]++sub(S);sub([])->[].
lta([])->[];lta([H|T])->[?l(H)|lta(T)].
parse(S)->{P,R}=graph(lta(string:tokens(sub(S)," "))),P.
graph(['^',N|R0])->{N,R0};
graph([N,?g1('=')graph(R0),['('|R2]=R1,{Q2,R3}=
graph2(R2,[]),{{N,Q,Q2},R3};
graph([N,?g1('(')graph2(R0,[]),{{N,nil,Q},R1}.
graph2([')'|R0],A)->{A,R0};
graph2(R,A)->{Q,R0}=graph(R),graph2(R0,A++[Q]).

%% Interpreter ---------------------------------------------------------

interpret(P)->interpret(first(P),P,{stack,nil,[]},stack,[],random).
interpret(nil,  P,?y,M)->{?y};
interpret(stop, P,?y,M)->{?y};
interpret(N, P,?y,M)->
  case find(N,P) of
    {N,nil,L} ->
      interpret(pick(L,M),P,?y,M);
    {N,V,L} when is_atom(V)->
      {N0,P0,S0,C0,CS0,M0} = do(N,V,P,?y,M),
      {N1,V1,L1}=find(N0,P0),
      case N0 of
        N->interpret(pick(L1,M0),P0,S0,C0,CS0,M0);
	_->interpret(N0,P0,S0,C0,CS0,M0)
      end;	
    {N,V,L} ->
      {S0,C0,CS0}=interpret(first(V),V,?y,M),
      interpret(pick(L,M),P,S0,C0,CS0,M);
    _ ->
      {?y}
  end.

do(L,V,P,?y,M) ->
  case V of
    uwaming->?g2(Q),io:fwrite("~s ",[format(Q)]),{?t0,?t};
    bejadoz->?g3(input()),{?t0,?t};
    duronilt->?g2(Q),{L,Q,S0,?t};
    whebong->?g3(P),{?t0,?t};
    taug->?g3({embed,S,[]}),{?t0,?t};
    chehy->?g2(Q),{L,P,Q,?t};
    bimodang->?g2(Q),case Q of
        skip->{?t0,?t};
	   _->{Q,P,S0,C,[L|CS],M}end;
    ubewic->?g3(skip),[H|T]=CS,{H,P,S0,C,T,M};
    rehohur->?g2(Q),{?t0,?t};
    soduv->?g2(Q),case Q of
        {_,_,[]}   ->{?t0,C,CS,first};
	{_,_,[_|_]}->{?t0,C,CS,last};
	          _->{?t0,?t}end;
    chuwakagathaz->{L,P,?y,random};
    sajalom->{L,P,?y,first};
    grangnum->{L,P,?y,last};
    _ ->
      case atom_to_list(V) of
        "#"?g9,?l(K)),{?t0,?t};
        "0"?g9,{?l(K),nil,[]}),{?t0,?t};
        "1"?g9,find(?l(K),P)),{?t0,?t};
        "@"++C0->{L,P,S,?l(C0),CS,M};
	_->{L,P,?y,M}
      end
  end.

%% Utilities ------------------------------------------------------------

first({N,S,L})->N;first(A)->A. pick([],_)->stop;pick([H|_],first)->first(H);
pick(L,last)->first(lists:nth(length(L),L));pick(L,random)->first(lists:nth(
random:uniform(length(L)),L)). find(N,[])->false;find(N,[H|T])->case find(N,H)
of false->find(N,T);V->V end;find(N,{N,S,L}=P)->P;find(N,{O,S,L})->find(N,L);
find(N,_)->false. replace(N,[],G)->[];replace(N,[H|T],G)->[replace(N,H,G)|
replace(N,T,G)];replace(N,{N,S,L}=P,G)->G;replace(N,{O,S,L},G)->replace(N,L,G);
replace(N,V,G)->V. push(C,S,G)->{N,D,L}=find(C,S),replace(C,S,{N,D,[G|L]}). pop
(C, S)->case find(C,S) of{N,D,[]}->{S,nil};{N,D,[H|T]}->{replace(C,S,{N,D,T}),
H}end. format([])->"";format(A) when is_atom(A)->"^"++atom_to_list(A);format([H|T])
->format(H)++format(T);format({N,nil,L})->io_lib:format("~w(~s)",[N,format(L)])
;format({N,V,L})->io_lib:format("~w=~s(~s)",[N,format(V),format(L)]);format(_)

                                  ->"?".

%% User Interface ------------------------------------------------------

input()->parse(lib:nonl(io:get_line('GraNoLa/M> '))).
run(S)->interpret(parse(S)).
test(1)->run("a=^#cthulhu(b=^uwaming(^a))");
test(2)->run("a=^whebong(b=^uwaming(^a))");
test(4)->run("a=^0hello(b=^@hello(c=^taug(d=^uwaming(^a))))");
test(5)->run("a=^1hello(b=^uwaming(end() hello(world())))");
test(6)->run("a=^sajalom(b=^#d(c=^bimodang(^a))"
             "d(e=^#sakura(f=^uwaming(g=^ubewic()))))");
test(7)->run("a=^sajalom(b=^bejadoz(c=^soduv(^a d())))");
test(_)->unknown_test.
shell()->{?y}=interpret(input()),io:fwrite("~s@~w~n",[format(S),C]),
shell().

%% Script Interface ------------------------------------------------------

main(["run",N]) ->
  {ok,B} = file:read_file(N),run(binary_to_list(B)),io:fwrite("\n");
main(["parse",N]) ->
  {ok,B} = file:read_file(N),io:fwrite("~w\n",[parse(binary_to_list(B))]).
