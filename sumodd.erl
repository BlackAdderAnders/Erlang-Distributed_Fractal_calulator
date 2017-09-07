%%Exercise Erlang course @ Ericsson
-module(sumodd).

-export([fromTo/3,mapReduce/3,truncate/1]).

%%sumodd([])                        -> 0;
%%sumodd([X|Xs]) when (X rem 2) =/=  1 ->  X + sumodd(Xs);
%%sumodd([X|Xs]) when (X rem 2) ==     ->  sumodd(Xs).
%%sum([]) -> 0;
%%sum([X|Xs]) -> X + sum([Xs]).

%% seq  (3 args) will give correct steps
fromTo(X, Y, Inc) when X - Inc < Y -> [ X | fromTo(X+Inc, Y, Inc)];
fromTo(_,_,_) -> [].

-spec truncate(float()|integer()) -> float().
truncate(F) ->
	Prec = math:pow(10,6),
	trunc(F*Prec)/Prec.

%%Creates a list from X(-2) to Y(2) with increment of Inc step(ex: 0.0000001231231), then maps list 
%%on all floats with the number if significant decimals.	
mapReduce(X,Y,Inc) -> 
	Result = fromTo(X,Y,Inc),
	[truncate(K)|| K <- Result, K == K].
	
%%1. Create 2 lists for X and Y coords.  
%% 4K resolution = 3840 × 2160  e.g 8.294.400 pixels

%% Number of Y rows is 4 / 2160 = 0,0018518518518519 increments
%% Number of X indicies is 4 / 3840 = 0,0010416666666667 increments

%Xlist = mapReduce(-2,2,0.00104166666). %%This is just 1 row in the matrix
%Ylist = mapReduce(-2,2,0.00185185185).

%%2. Fold list in tuple list (X value, Y value, # iterations)
 
%
% Create tuple list with X value, y value and the iteration set to 0
%------------------------------------------------------------------
create_cord_tuple_list(X,Y,X_increment,Y_increment) ->
	% for every 3840 steps reduce 0,0018518518518519 from 2 untill zero
	% this will be 2160 indecies. Same with 3840, 2 - 0,0010416666666667 will be 3840 indicies
	NewXcordValue = if
						X - X_increment > 0 ->
												X - X_increment;
						true -> 0
					end.
	NewYcordValue = 

%%3. Read the new tuple list and draw graphics OR create file with values from list.


%% 2160 rows with 3840 items =  Matrix M