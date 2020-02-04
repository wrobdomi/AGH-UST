-module(tree).
-export([empty/0, insert/2, lookup/2, generate_random_tree/3, generate_tree_from_list/2, fold_tree_to_list/1]).
 
% empty tree % % % % % % % % % % % % % % % % % % % %

empty() -> {node, 'nil'}.



% insert to a tree % % % % % % % % % % % % % % % % % % % %

insert(Key, {node, 'nil'}) ->
	{node, {Key, {node, 'nil'}, {node, 'nil'} } };

insert(NewKey, {node, {Key, Smaller, Larger}}) when NewKey < Key ->
	{node, {Key, insert(NewKey, Smaller), Larger}};

insert(NewKey, {node, {Key, Smaller, Larger}}) when NewKey > Key ->
	{node, {Key, Smaller, insert(NewKey, Larger)}};

insert(Key, {node, {Key, Smaller, Larger}}) ->
	{node, {Key, Smaller, Larger}}.
	
	

% lookup in a tree % % % % % % % % % % % % % % % % % % % %

lookup(_, {node, 'nil'}) ->
	undefined;

lookup(Key, {node, {Key, _, _}}) ->
	true;

lookup(Key, {node, {NodeKey, Smaller, _}}) when Key < NodeKey ->
	lookup(Key, Smaller);

lookup(Key, {node, {_, _, Larger}}) ->
	lookup(Key, Larger).



% generacja losowego drzewa % % % % % % % % % % % % % % % % % % % %

generate_random_tree(0, _, Tree) -> 
	Tree;

generate_random_tree(N, Range, Tree) -> 
	generate_random_tree(N-1, Range, insert(rand:uniform(Range), Tree)).
	
	
	
% generacja drzewa z listy % % % % % % % % % % % % % % % % % % % %

generate_tree_from_list([], Tree) ->
	Tree;

generate_tree_from_list([H|T], Tree) -> 
	generate_tree_from_list(T, insert(H, Tree)).
	

	
% zwiniecie drzewa do listy % % % % % % % % % % % % % % % % % % % %

fold_tree_to_list({node, 'nil'}) ->
	[];

fold_tree_to_list({node, {Key, Smaller, Larger}}) ->
	fold_tree_to_list(Smaller) ++ [Key] ++ fold_tree_to_list(Larger). 
	
	